//
//  MKPhotosView.m
//  Newwws
//
//  Created by hustqmk on 15/12/29.
//  Copyright © 2015年 hustqmk. All rights reserved.
//

#import "MKPhotosView.h"
#import "MKPhotoView.h"


#define MKPhotoW 70
#define MKPhotoH 70
#define MKPhotoMargin 10

@implementation MKPhotosView

-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self)
    {
        for (int index = 0; index < 9; index++) {
            MKPhotoView *photoView = [[MKPhotoView alloc] init];
            photoView.tag = index;
            photoView.userInteractionEnabled = YES;
            [self addSubview:photoView];
        }
    }
    return self;
}

+ (CGSize) sizeWithPhotosCount:(int) count
{
    // 一行最多3列
    int maxColumns = (count == 4) ? 2 : 3;
    
    // 总行数
    int rows = (count + maxColumns - 1) / maxColumns;
    // 高度
    CGFloat photosH = rows * MKPhotoH + (rows - 1) * MKPhotoMargin;
    
    // 总列数
    int cols = (count >= maxColumns) ? maxColumns : count;
    // 宽度
    CGFloat photosW = cols * MKPhotoW + (cols - 1) * MKPhotoMargin;
    
    return CGSizeMake(photosW, photosH);
}

-(void) setPhotos:(NSArray *)photos
{
    _photos = photos;
    
    for (int index = 0; index < self.subviews.count; index++) {
        MKPhotoView *photoView = self.subviews[index];
        
        if(index < photos.count){
            photoView.hidden = NO;
            
            photoView.photo = photos[index];
            
            int maxColumns = (photos.count == 4)?2:3;
            int col = index % maxColumns;
            int row = index / maxColumns;
            
            CGFloat photoX = col * (MKPhotoW + MKPhotoMargin);
            CGFloat photoY = row * (MKPhotoH + MKPhotoMargin);
            photoView.frame = CGRectMake(photoX,photoY,MKPhotoW,MKPhotoH);
            
            if (photos.count == 1) {
                photoView.contentMode = UIViewContentModeScaleAspectFit;
                photoView.clipsToBounds = NO;
            }
            else{
                photoView.contentMode = UIViewContentModeScaleAspectFill;
                photoView.clipsToBounds = YES;
            }
        }
        else
        {
            photoView.hidden = YES;
        }
    }
}
@end
