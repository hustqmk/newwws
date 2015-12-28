//
//  utility.h
//  firstAP
//
//  Created by hustqmk on 15/8/18.
//  Copyright (c) 2015年 hustqmk. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ERROR_USERNAME_ILLEGAL_CHARACTER 2
#define ERROR_USERNAME_ILLEGAL_LENGTH 3
#define ERROR_PASSWORD_ILLEGAL_CHARACTER 4
#define ERROR_PASSWORD_ILLEGAL_LENGTH 5
@interface utility : NSObject
-(NSInteger) checkUseName:(NSString *) userName;
-(NSInteger) checkPasswd:(NSString *) password;
@end
