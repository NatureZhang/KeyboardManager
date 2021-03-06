//
//  BottomTxtVCView.m
//  KeyboradManagerDemo
//
//  Created by __Nature__ on 16/4/19.
//  Copyright © 2016年 __Nature__. All rights reserved.
//

#import "BottomTxtViewVC.h"
#import "KeyboardManager.h"
@interface BottomTxtViewVC ()
@property (nonatomic, strong) KeyboardManager *keyBoardManager;
@property (nonatomic, strong) UITextField *bottomTxtField;
@end

@implementation BottomTxtViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.keyBoardManager = [[KeyboardManager alloc] init];
    [self layoutBottomTxtView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)layoutBottomTxtView {
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    _bottomTxtField = [[UITextField alloc] initWithFrame:CGRectMake(0, screenSize.height - 50, screenSize.width, 50)];
    [self.view addSubview:_bottomTxtField];
    
    _bottomTxtField.placeholder = @"请输入信息";
    _bottomTxtField.borderStyle = UITextBorderStyleRoundedRect;
    
    [self.keyBoardManager addInputView:_bottomTxtField andWillScrollView:self.bottomTxtField];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.bottomTxtField resignFirstResponder];
}

@end
