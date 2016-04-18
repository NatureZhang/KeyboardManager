//
//  PersonInfoTableVC.m
//  KeyboradManagerDemo
//
//  Created by zhangdong on 16/4/18.
//  Copyright © 2016年 zhangdong. All rights reserved.
//

#import "PersonInfoTableVC.h"
#import "PersonInfoCell.h"

static NSString *const infoCellId = @"infoCellId";

@interface PersonInfoTableVC ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (weak, nonatomic) IBOutlet UITableView *infoTableView;

@end

@implementation PersonInfoTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self registerTableViewCell];
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
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView reloadData];
}
@end
