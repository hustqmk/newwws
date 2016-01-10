//
//  MKUser.h
//  Newwws
//
//  Created by hustqmk on 15/12/27.
//  Copyright © 2015年 hustqmk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MKUser : NSObject
/** id */
@property (nonatomic, copy) NSString *idstr;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image_url;
/** 昵称 */
@property (nonatomic, copy) NSString *name;
/** 手机号 */
@property (nonatomic, copy) NSString *phoneNumber;
@end
