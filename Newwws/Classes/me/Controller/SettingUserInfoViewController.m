//
//  SettingUserInfoViewController.m
//  Newwws
//
//  Created by hustqmk on 16/1/24.
//  Copyright © 2016年 hustqmk. All rights reserved.
//

#import "SettingUserInfoViewController.h"

@interface SettingUserInfoViewController ()

@end

@implementation SettingUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    [self createSettingView];
    // Do any additional setup after loading the view.
}

-(void) viewWillAppear:(BOOL)animated
{
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createSettingView{
    
    CGRect frame = [UIScreen mainScreen].bounds;
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, frame.size.width - 100, frame.size.height - 200)];
    bgView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:bgView];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
