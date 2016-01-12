//
//  settinhHeaderViewController.h
//  chuanke
//
//  Created by mj on 15/11/30.
//  Copyright © 2015年 jinzelu. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol settinhHeaderDelegate
-(void)Phone:(NSString *)mobilePhone andPasswd:(NSString *)passwd;
@end

@interface settinhHeaderViewController : UIViewController
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *passwd;
@property (nonatomic, copy) NSString *smsCode;
@end
