//
//  MKPhotosView.h
//  Newwws
//
//  Created by hustqmk on 15/12/29.
//  Copyright © 2015年 hustqmk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MKPhotosView : UIView
+ (CGSize)sizeWithPhotosCount:(int)count;

@property (nonatomic, strong) NSArray *photos;
@end
