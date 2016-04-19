//
//  KeyboardManager.h
//  KeyboradManagerDemo
//
//  Created by zhangdong on 16/4/18.
//  Copyright © 2016年 zhangdong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol KeyboardDelegate <NSObject>

- (void)keyboardWillShowWithInputView:(UIView *)inputView;

- (void)keyboardWillHideWithInputView:(UIView *)inputView;

- (void)keyboardDidShowWithInputView:(UIView *)inputView andkeyBoardHeight:(NSInteger)keyboardHeight;

@end

@interface KeyboardManager : NSObject

/**
 *  正常偏移情况下(不设值)，输入框正好贴在键盘上侧，设置此值可以远离键盘上边缘
 */
@property (nonatomic, assign) NSInteger moreOffsetY;
@property (nonatomic, assign, readonly) NSInteger keyboardHeight;         // 键盘高度
@property (nonatomic, weak) id<KeyboardDelegate>delegate;

/**
 *  隐藏键盘
 */
- (void)hideKeyboard;

/**
 *  添加输入视图
 *
 *  @param inputView      输入框
 *  @param willScrollView 想要其滚动的视图
 */
- (void)addInputView:(UIView *)inputView andWillScrollView:(UIView *)willScrollView;

// 移动到下一个
- (void)moveToNextInputView:(UIView *)inputView;
@end
