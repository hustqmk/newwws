//
//  MKPostFrame.h
//  Newwws
//
//  Created by hustqmk on 15/12/27.
//  Copyright © 2015年 hustqmk. All rights reserved.
//

// 定义Post frame的内部框架

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGGeometry.h>
// 间距
#define MKPostPadding 10
// 昵称字体
#define MKPostNameFont 14
// 时间字体
#define MKPostTimeFont 10
// 来源字体
#define MKPostSourceFont XXStatusTimeFont
// 正文字体
#define MKPostContentFont 14

@class MKPost;

@interface MKPostFrame : NSObject


/** Post父控件 */
@property (nonatomic, assign, readonly) CGRect originalViewF;
/** 头像 */
@property (nonatomic, assign, readonly) CGRect iconViewF;
/** 昵称 */
@property (nonatomic, assign, readonly) CGRect nameBtnF;
/** 时间 */
@property (nonatomic, assign, readonly) CGRect timeLabelF;
/** 原创微博正文 */
@property (nonatomic, assign, readonly) CGRect contentLabelF;
/** 原创微博配图 */
@property (nonatomic, assign, readonly) CGRect photoViewF;
/** 微博工具条父控件 */
@property (nonatomic, assign, readonly) CGRect statusToolBarF;

/** cell的高度 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;

@property (nonatomic, strong) MKPost *post;

@end
