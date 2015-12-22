//
//  main.m
//  firstAP
//
//  Created by hustqmk on 15/6/12.
//  Copyright (c) 2015年 hustqmk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <BmobSDK/Bmob.h>

int main(int argc, char * argv[]) {
    @autoreleasepool {
        NSString *appKey = @"125382748cab16daf89aa904c5bec292";
        [Bmob registerWithAppKey:appKey];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
