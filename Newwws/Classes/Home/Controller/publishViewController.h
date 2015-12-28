//
//  publishViewController.h
//  firstAP
//
//  Created by hustqmk on 15/8/9.
//  Copyright (c) 2015年 hustqmk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELCImagePicker/ELCImagePickerController.h"

@interface publishViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,
UIImagePickerControllerDelegate,UINavigationBarDelegate,UITextViewDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, copy) NSArray * chooseImages;
@property (nonatomic, copy) NSArray * chooseImageNames;
@end
