//
//  PersonInfoViewVC.m
//  KeyboradManagerDemo
//
//  Created by zhangdong on 16/4/18.
//  Copyright © 2016年 zhangdong. All rights reserved.
//

#import "PersonInfoViewVC.h"
#import "KeyboardManager.h"


@interface PersonInfoViewVC ()
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *nickNameField;
@property (weak, nonatomic) IBOutlet UITextField *nameTxtField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@property (nonatomic, strong) KeyboardManager *keyboardManager;
@end

@implementation PersonInfoViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _keyboardManager = [[KeyboardManager alloc] init];
    _keyboardManager.moreOffsetY = 20;
    
    [_keyboardManager addInputView:_phoneTextField andWillScrollView:self.view];
    [_keyboardManager addInputView:_emailTextField andWillScrollView:self.view];
    [_keyboardManager addInputView:_nameTxtField andWillScrollView:self.view];
    [_keyboardManager addInputView:_nickNameField andWillScrollView:self.view];
    [_keyboardManager addInputView:_passwordField andWillScrollView:self.view];
    [_keyboardManager addInputView:_confirmPasswordField andWillScrollView:self.view];
    
    NSLog(@"=== %@ ===", self.view.subviews);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.keyboardManager hideKeyboard];
}
@end
