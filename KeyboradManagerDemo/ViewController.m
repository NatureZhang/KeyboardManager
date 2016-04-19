//
//  ViewController.m
//  KeyboradManagerDemo
//
//  Created by zhangdong on 16/4/18.
//  Copyright © 2016年 zhangdong. All rights reserved.
//

#import "ViewController.h"
#import "PersonInfoTableVC.h"
#import "PersonInfoViewVC.h"
#import "BottomTxtViewVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)gotoInfoViewVC:(id)sender {
    
    PersonInfoViewVC *infoViewVC = [[PersonInfoViewVC alloc] init];
    [self.navigationController pushViewController:infoViewVC animated:YES];
}

- (IBAction)gotoInfoTableVC:(id)sender {
    
    PersonInfoTableVC *infoTableVC = [[PersonInfoTableVC alloc] init];
    [self.navigationController pushViewController:infoTableVC animated:YES];
}

- (IBAction)gotoBottomViewVC:(id)sender {
    
    BottomTxtViewVC *vc = [[BottomTxtViewVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
