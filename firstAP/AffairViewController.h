//
//  AffairViewController.h
//  firstAP
//
//  Created by hustqmk on 15/7/31.
//  Copyright (c) 2015年 hustqmk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AffairViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITabBar *AffairTabBar;
@property (weak, nonatomic) IBOutlet UILabel *tabBarIndexLabel;
@property (strong, nonatomic) NSArray *tabString;
@end
