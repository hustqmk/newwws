//
//  MKPostCell.h
//  Newwws
//
//  Created by hustqmk on 16/1/3.
//  Copyright © 2016年 hustqmk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MKPostFrame;
@interface MKPostCell : UITableViewCell

@property(nonatomic, strong) MKPostFrame *postFrame;

+(instancetype) cellWithTableView:(UITableView *) tableView;

@end
