//
//  MKPhotoView.m
//  Newwws
//
//  Created by hustqmk on 15/12/27.
//  Copyright © 2015年 hustqmk. All rights reserved.
//

#import "MKPhotoView.h"
#import "MKPhoto.h"
#import "UIImageView+WebCache.h"


@interface MKPhotoView()

@property(nonatomic, strong) UIImageView * gifView;

@end

@implementation MKPhotoView

-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *gif = [UIImage imageNamed:@"timeline_image_gif"];
        UIImageView *gifView = [[UIImageView alloc] initWithImage:gif];
        [self addSubview:gifView];
        
        self.gifView = gifView;
    }

    return self;
}

-(void) setPhoto:(MKPhoto *)photo
{
    _photo = photo;
    
    self.gifView.hidden = ![photo.thumbnail_pic hasSuffix:@".gif"];
    
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic]
            placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
}

-(void)layoutSubviews
{
    
}

@end
