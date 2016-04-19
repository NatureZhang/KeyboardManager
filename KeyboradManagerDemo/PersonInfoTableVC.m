//
//  PersonInfoTableVC.m
//  KeyboradManagerDemo
//
//  Created by __Nature__ on 16/4/18.
//  Copyright © 2016年 __Nature__. All rights reserved.
//

#import "PersonInfoTableVC.h"
#import "PersonInfoCell.h"

#import "KeyboardManager.h"

static NSString *const infoCellId = @"infoCellId";

@interface PersonInfoTableVC ()
<
UITableViewDelegate,
UITableViewDataSource,
UITextFieldDelegate
>

@property (weak, nonatomic) IBOutlet UITableView *infoTableView;
@property (nonatomic,strong) KeyboardManager *keyboardManager;
@end

@implementation PersonInfoTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self registerTableViewCell];
    
    self.keyboardManager = [[KeyboardManager alloc] init];
    _keyboardManager.moreOffsetY = 30;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)registerTableViewCell {
    
    [_infoTableView registerNib:[UINib nibWithNibName:@"PersonInfoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:infoCellId];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PersonInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:infoCellId];
    UITextField *textField = cell.textFeild;
    textField.delegate = self;
    textField.returnKeyType = UIReturnKeyNext;
    textField.placeholder = [NSString stringWithFormat:@"请输入：%ld", (long)indexPath.row];
    [_keyboardManager addInputView:textField andWillScrollView:tableView];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView reloadData];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.keyboardManager hideKeyboard];
}

#pragma mark - UITextFieldDelegate 
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [_keyboardManager moveToNextInputView:nil];
    return YES;
}
@end
