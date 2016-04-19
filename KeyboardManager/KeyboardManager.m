//
//  KeyboardManager.m
//  KeyboradManagerDemo
//
//  Created by __Nature__ on 16/4/18.
//  Copyright © 2016年 __Nature__. All rights reserved.
//

#import "KeyboardManager.h"

@interface KeyboardManager ()

@property (nonatomic, strong) NSMutableArray<UIView *> *arrayInputViews;         // 输入视图
@property (nonatomic, strong) NSMutableArray<UIView *> *arrayWantScrollView;     // 想要滚动的视图
@property (nonatomic, assign, readwrite) NSInteger keyboardHeight;       // 键盘高度
@property (nonatomic, assign) NSInteger changeHeight;           // 改变的高度

@end

static const NSInteger inputViewTag = 1000001;

@implementation KeyboardManager

- (void)dealloc {
    
    [self removeKeyboardObserver];
    NSLog(@"keyboardManager dealloc");
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self registerKeyboardObserver];
        self.arrayInputViews = [[NSMutableArray alloc] init];
        self.arrayWantScrollView = [[NSMutableArray alloc] init];
    }
    return self;
}

// 注册观察者
- (void)registerKeyboardObserver {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

// 移除观察者
- (void)removeKeyboardObserver {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - observer action

- (void)keyboardWillShow:(NSNotification *)notification {
    
    if (!_arrayInputViews && [_arrayInputViews count] == 0) {
        return;
    }
    
    for (int i = 0; i < [_arrayInputViews count]; i ++) {
        
        UIView *inputView = [_arrayInputViews objectAtIndex:i];
        UIView * willScrollView = [_arrayWantScrollView objectAtIndex:i];

        if ([inputView isFirstResponder]) {
            
            // 找到第一响者
            NSDictionary *info              = [notification userInfo];
            NSValue *value                  = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
            CGSize size                     = [value CGRectValue].size;
            self.keyboardHeight = size.height;
            
            if ([inputView isDescendantOfView:willScrollView]) {
                // 滚动
                [self scrollWillScrollView:willScrollView inputView:inputView];
            }
            
            if (_delegate
                && [_delegate conformsToProtocol:@protocol(KeyboardDelegate)]
                && [_delegate respondsToSelector:@selector(keyboardWillShowWithInputView:)]) {
                
                [_delegate keyboardWillHideWithInputView:inputView];
            }
        }
    }
}

- (void)keyboardDidShow:(NSNotification *)notification {
    
    if (!_arrayInputViews && [_arrayInputViews count] == 0) {
        return;
    }

    for (int i = 0; i < [_arrayInputViews count]; i ++) {

        UIView * inputView = [_arrayInputViews objectAtIndex:i];
        
        if ([inputView isFirstResponder]) {
            
            if (_delegate
                && [_delegate conformsToProtocol:@protocol(KeyboardDelegate)]
                && [_delegate respondsToSelector:@selector(keyboardDidShowWithInputView:andkeyBoardHeight:)]) {
                
                [_delegate keyboardDidShowWithInputView:inputView andkeyBoardHeight:_keyboardHeight];
            }
        }
    }
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
    if (!_arrayInputViews && [_arrayInputViews count] == 0) {
        return;
    }

    for (int i = 0; i < [_arrayInputViews count]; i ++) {
        
        UIView * inputView = [_arrayInputViews objectAtIndex:i];
        UIView * willScrollView = [_arrayWantScrollView objectAtIndex:i];
        
        if ([inputView isFirstResponder]) {
            // 找到第一响者
            NSDictionary *info              = [notification userInfo];
            NSValue *value                  = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
            CGSize size                     = [value CGRectValue].size;
            self.keyboardHeight = size.height;
            
            if ([inputView isDescendantOfView:willScrollView]) {
                // 滚动
                [self recoverWillScrollView:willScrollView];
            }
            
            if (_delegate
                && [_delegate conformsToProtocol:@protocol(KeyboardDelegate)]
                && [_delegate respondsToSelector:@selector(keyboardWillHideWithInputView:)]) {
                
                [_delegate keyboardWillHideWithInputView:inputView];
            }
        }
    }
}

// 添加输入View 和 想要滚动的 View
- (void)addInputView:(UIView *)inputView andWillScrollView:(UIView *)willScrollView {
    
    if (inputView == nil || willScrollView == nil) {
        return;
    }
    
    // 移除掉旧的，添加新的，避免重复
    
    NSMutableArray *tmparrayInputView = [[NSMutableArray alloc] init];
    NSMutableArray *tmpArrayScrollView = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [_arrayInputViews count]; i ++) {
        
        UIView *tmpInputView = [_arrayInputViews objectAtIndex:i];
        UIView *tmpScrollView = [_arrayWantScrollView objectAtIndex:i];
        
        if (inputView == tmpInputView) {
            
            [tmparrayInputView addObject:tmpInputView];
            [tmpArrayScrollView addObject:tmpScrollView];
            
            break;
        }
    }
    
    [_arrayInputViews removeObjectsInArray:tmparrayInputView];
    [_arrayInputViews removeObjectsInArray:tmpArrayScrollView];
    
    NSInteger lastTag = [_arrayInputViews count];
    inputView.tag = inputViewTag + lastTag;
    
    // 将新的插入
    [_arrayInputViews addObject:inputView];
    [_arrayWantScrollView addObject:willScrollView];
}

// 移动到下一个
- (void)moveToNextInputView:(UIView *)inputView {
    
    if (!_arrayInputViews && [_arrayInputViews count] == 0) {
        return;
    }
    
    if (inputView) {
        [inputView becomeFirstResponder];
        return;
    }
    
    NSInteger currentInputViewTag = 0;
    
    for (int i = 0; i < [_arrayInputViews count]; i ++) {
        
        UIView *inputView = [_arrayInputViews objectAtIndex:i];
        
        if ([inputView isFirstResponder]) {
            
            if (i == _arrayInputViews.count - 1) {
                return;
            }
            
            currentInputViewTag = inputView.tag;
            break;
        }
    }
    
    for (int i = 0; i < [_arrayInputViews count]; i ++) {
        
        UIView *inputView = [_arrayInputViews objectAtIndex:i];
        if (inputView.tag == currentInputViewTag + 1) {
            [inputView becomeFirstResponder];
            break;
        }
    }
}

// 滚动想要滚动的视图
- (void)scrollWillScrollView:(UIView *)willScrollView inputView:(UIView *)inputView {
    
    // 参考View
    UIView *refView = [UIApplication sharedApplication].keyWindow;
    
    CGRect frame = [inputView.superview convertRect:inputView.frame toView:refView];
    int offset = frame.origin.y + frame.size.height - (refView.frame.size.height - self.keyboardHeight);//计算偏移量
    
    if (offset > 0) {
        
        NSInteger contentOffSet = offset + _moreOffsetY;
        _changeHeight += contentOffSet;
        
        [UIView animateWithDuration:0.3f animations:^{
            
            willScrollView.frame = CGRectOffset(willScrollView.frame, 0, -contentOffSet);
        }];
    }
}

// 恢复滚动的位置
- (void)recoverWillScrollView:(UIView *)willScrollView {
    
    NSInteger movement = _changeHeight;
    
    [UIView animateWithDuration:0.3f animations:^{
        
        willScrollView.frame = CGRectOffset(willScrollView.frame, 0, movement);
        
    } completion:^(BOOL finished) {
        
        _changeHeight = 0;
        
    }];
}

// 隐藏键盘
- (void)hideKeyboard {
    
    if (_arrayInputViews == nil && [_arrayInputViews count] == 0) {
        
        return;
    }
    
    for (int i = 0; i < [_arrayInputViews count]; ++i) {
        id inputObject  = [_arrayInputViews objectAtIndex:i];
        
        // 如果输入对象为第一响应
        if ([inputObject isFirstResponder] == YES) {
            
            [inputObject resignFirstResponder];
        }
    }
}
@end
