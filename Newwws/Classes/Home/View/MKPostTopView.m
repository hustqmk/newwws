//
//  MKPostTopView.m
//  Newwws
//
//  Created by hustqmk on 15/12/27.
//  Copyright © 2015年 hustqmk. All rights reserved.
//

#import "MKPostTopView.h"
#import "UIImageView+WebCache.h"
#import "MKPhotosView.h"
#import "MKPostFrame.h"
#import "MKConst.h"
#import "MKPost.h"
#import "UIImage+Extend.h"
#import "MKUser.h"

@class MKPhotosView;
@interface MKPostTopView()

/** 头像 */
@property (nonatomic, weak) UIImageView *iconView;
/** 昵称 */
@property (nonatomic, weak) UIButton *nameBtn;
/** 原创微博时间 */
@property (nonatomic, weak) UILabel *timeLabel;
/** 原创微博正文 */
@property (nonatomic, weak) UILabel *contentLabel;
/** 原创微博配图 */
@property (nonatomic, weak) MKPhotosView *photosView;

@end

@implementation MKPostTopView

#pragma mark - 初始化

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.userInteractionEnabled = YES;
        
        // 1. 头像
        UIImageView *iconview  = [[UIImageView alloc] init];
        [self addSubview:iconview];
        self.iconView = iconview;
        
        // 2. 姓名
        UIButton *nameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        nameBtn.titleLabel.font = [UIFont systemFontOfSize:MKPostNameFont];
        [self addSubview:nameBtn];
        self.nameBtn = nameBtn;
        
        // 4. 时间
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.font = [UIFont systemFontOfSize:MKPostTimeFont];
        timeLabel.textColor = MKColor(135, 135, 135);
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        // 6. 正文
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.font = [UIFont systemFontOfSize:MKPostContentFont];
        contentLabel.textColor = MKColor(35, 35, 35);
        contentLabel.numberOfLines = 0;
        [self addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        MKPhotosView *photosView = [[MKPhotosView alloc] init];
        [self addSubview:photosView];
        self.photosView = photosView;
    }
    
    return self;
}


#pragma mark - 设置数据
-(void)setPostFrame:(MKPostFrame *)postFrame
{
    _postFrame = postFrame;
    
    MKPost * post = postFrame.post;
    MKUser * user = postFrame.post.user;
    
    // set user header image
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url]
                     placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    self.iconView.frame = postFrame.iconViewF;
    
    // nike name
    [self.nameBtn setTitle:user.name forState:UIControlStateNormal];
    self.nameBtn.frame = postFrame.nameBtnF;
    [self.nameBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    // time
    self.timeLabel.text = post.created_at;
    CGFloat timeX = self.postFrame.nameBtnF.origin.x;
    CGFloat timeY = CGRectGetMaxY(self.postFrame.nameBtnF) + MKPostPadding * 0.5;
    CGSize timeSize = [post.created_at sizeWithFont:[UIFont systemFontOfSize:MKPostTimeFont]];
    self.timeLabel.frame = (CGRect){timeX, timeY, timeSize};
    
    // CONTENT
    self.contentLabel.text = post.text;
    self.contentLabel.frame = postFrame.contentLabelF;
    
    if (post.thumbpics_urls.count) {
        self.photosView.hidden = NO;
        self.photosView.photos = post.thumbpics_urls;
        self.photosView.frame = postFrame.photoViewF;
    }
    else{
        self.photosView.hidden = YES;
    }
}





















@end
