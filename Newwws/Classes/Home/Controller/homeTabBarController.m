//
//  homeTabBarController.m
//  Newwws
//
//  Created by hustqmk on 16/1/9.
//  Copyright © 2016年 hustqmk. All rights reserved.
//

#import "homeTabBarController.h"

@implementation homeTabBarController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.delegate = self;
}
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if (viewController.tabBarItem.tag == 2) {
        NSLog(@"%@",viewController);
    }
}
@end
