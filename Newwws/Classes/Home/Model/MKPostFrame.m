//
//  MKPostFrame.m
//  Newwws
//
//  Created by hustqmk on 15/12/27.
//  Copyright © 2015年 hustqmk. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "MKPostFrame.h"
#import "MKPost.h"
#import "MKUser.h"
#import "MKPhoto.h"
#import "MKPhotosView.h"

@implementation MKPostFrame

-(void)setPost:(MKPost *)post
{
    _post = post;
    
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
    
    // 2. 昵称
    CGFloat nameX = CGRectGetMaxX(_iconViewF) + MKPostPadding;
    CGFloat nameY = iconXY;
    CGSize nameSize = [_post.user sizeWithFont:[UIFont systemFontOfSize:MKPostNameFont]];
    _nameBtnF = (CGRect){nameX,nameY,nameSize};
    
    // 3. 时间
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(_nameBtnF) + MKPostPadding * 0.5;
    CGSize timeSize = [post.created_at sizeWithFont:[UIFont systemFontOfSize:MKPostTimeFont]];
    _timeLabelF = (CGRect){timeX,timeY,timeSize};
    
    // 4. 正文
    CGFloat contentX = iconXY;
    CGFloat contentY = MAX(CGRectGetMaxY(_iconViewF), CGRectGetMaxY(_timeLabelF) + MKPostPadding);
    CGFloat contentMaxW = cellW - 2 * MKPostPadding;
    CGSize contentSize = [post.text sizeWithFont:[UIFont
        systemFontOfSize:MKPostContentFont] constrainedToSize:CGSizeMake(contentMaxW, MAXFLOAT)];
    _contentLabelF = (CGRect){contentX,contentY,contentSize};
    
    CGFloat originalH = CGRectGetMaxY(_contentLabelF) + MKPostPadding;
    
    // 5. 图片
    if (post.thumbpics_urls.count) {
        CGFloat photoX = iconXY;
        CGFloat photoY = originalH;
        CGSize photoSize = [MKPhotosView sizeWithPhotosCount:post.thumbpics_urls.count];
        _photoViewF = CGRectMake(photoX, photoY, photoSize.width, photoSize.height);
        
        originalH = CGRectGetMaxY(_photoViewF) + MKPostPadding;
    }
    
    _cellHeight = originalH + MKPostPadding * 0.5;
    
}

@end
