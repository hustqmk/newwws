//
//  MKPostCell.m
//  Newwws
//
//  Created by hustqmk on 16/1/3.
//  Copyright © 2016年 hustqmk. All rights reserved.
//

#import "MKPostCell.h"
#import "MKPostTopView.h"
#import "MKPostFrame.h"

@interface MKPostCell()

@property(nonatomic, weak) MKPostTopView * topView;

@end


@implementation MKPostCell


+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    MKPostCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MKPostCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectedBackgroundView = [[UIView alloc] init];
        
        // 初始化微博的topView
        [self setupTopView];
        
    }
    return self;
}

-(void) setFrame:(CGRect)frame
{
    frame.origin.x = MKPostPadding * 0.5;
    frame.size.width -= MKPostPadding;
    frame.origin.y += MKPostPadding * 0.5;
    frame.size.height -= MKPostPadding *0.5;
    
    [super setFrame:frame];
}

/**
 *  初始化微博的topView
 */
- (void)setupTopView
{
    MKPostTopView *topView = [[MKPostTopView alloc] init];
    [self.contentView addSubview:topView];
    self.topView = topView;
}

-(void) setPostFrame:(MKPostFrame *)postFrame
{
    _postFrame = postFrame;
    
    [self setupTopViewData];
}

-(void) setupTopViewData
{
    MKPostFrame * postFrame = self.postFrame;
    self.topView.postFrame = postFrame;
    self.topView.frame = postFrame.originalViewF;
}
@end
