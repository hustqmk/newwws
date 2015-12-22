//
//  myNewsViewController.h
//  firstAP
//
//  Created by hustqmk on 15/8/8.
//  Copyright (c) 2015年 hustqmk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myNewsViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate>
@end


@interface News : NSObject
@property(strong, nonatomic) NSString * text;
@property(strong, nonatomic) NSString * imageName;
@property(strong, nonatomic) NSString * thumbnailName;
@property(strong, nonatomic) NSNumber * userID;
@property(strong, nonatomic) NSNumber * newsID;
@end