//
//  homeTabBarController.m
//  Newwws
//
//  Created by hustqmk on 16/1/9.
//  Copyright © 2016年 hustqmk. All rights reserved.
//

#import "homeTabBarController.h"
#import "bmobOperation.h"
#import "SettingUserInfoViewController.h"
#import "LogViewController.h"
@implementation homeTabBarController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.delegate = self;
}
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if (tabBarController.selectedIndex == 2) {
        BmobUser *bUser = [BmobUser getCurrentUser];
        if (bUser) {
            // open user setting interface
            [self.navigationController pushViewController:[[SettingUserInfoViewController alloc]init] animated:NO];
        }
        else{
            [self.navigationController pushViewController:[[LogViewController alloc]init] animated:NO];
        }
        NSLog(@"select 2");
    }else if(tabBarController.selectedIndex == 1){
        NSLog(@"select 1");
    }else if(tabBarController.selectedIndex == 0){
        NSLog(@"Select 0");
    }
}
@end
