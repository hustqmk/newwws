//
//  MKPost.h
//  Newwws
//
//  Created by hustqmk on 15/12/27.
//  Copyright © 2015年 hustqmk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XXUser;

@interface MKPost : NSObject
/** Post id */
@property (nonatomic, copy) NSString *idstr;
/** 作者 */
@property (nonatomic, strong) XXUser *user;
/** 时间 */
@property (nonatomic, copy) NSString *created_at;
/** 正文 */
@property (nonatomic, copy) NSString *text;;
/** 配图 */
@property (nonatomic, strong) NSArray *pic_urls;

@end
