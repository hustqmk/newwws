//
//  MKPostFrame.m
//  Newwws
//
//  Created by hustqmk on 15/12/27.
//  Copyright © 2015年 hustqmk. All rights reserved.
//

#import "MKPostFrame.h"
#import "MKPost.h"
#import "MKUser.h"
#import "MKPhoto.h"

@implementation MKPostFrame

-(void)setStatus:(MKPost *)status
{
    _status = status;
    
    MKUser * user = _status.user;
    
    // cell 的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width - MKPostPadding;
    
    // 0. Post 父控件
    CGFloat orginalW = cellW;
    CGFloat orginalX = 0;
    CGFloat orginalY = 0;
    
    // 1. 头像
    CGFloat iconXY = MKPostPadding;
    CGFloat iconWH = 34;
    _iconViewF = CGRectMake(iconXY,iconXY,iconWH,iconWH);
    
}

@end
