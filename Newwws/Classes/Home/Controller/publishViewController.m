//
//  publishViewController.m
//  firstAP
//
//  Created by hustqmk on 15/8/9.
//  Copyright (c) 2015年 hustqmk. All rights reserved.
//

#import "publishViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "bmobOperation.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ELCImagePicker/ELCImagePickerController.h"
#import "ELCImagePicker/ELCAlbumPickerController.h"
#import "MKConst.h"
#import "SVProgressHUD.h"

@interface publishViewController ()

@property (strong, nonatomic) IBOutlet UITextView *publishTextView;
@property (strong, nonatomic) IBOutlet UICollectionView *imageCollect;
@property (strong, nonatomic) NSString * imageFileName;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) BmobUser *bUser;
@end

@implementation publishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.publishTextView.layer.borderColor = UIColor.grayColor.CGColor;
    self.publishTextView.layer.borderWidth = 2;
    self.publishTextView.layer.cornerRadius = 6;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.publishTextView setDelegate:self];
    [self.publishTextView becomeFirstResponder];
    // Do any additional setup after loading the view.
    
    // dynamic add button
    //CGRect buttonFrame = CGRectMake(30, 200, 50, 50);
    //UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //button.frame = buttonFrame;
    //[button setTitle:@"Test" forState:UIControlStateNormal];
    //button.backgroundColor = [UIColor clearColor];
    //[button.layer setBorderColor:[[UIColor blackColor] CGColor]];
    //[button.layer setBorderWidth:2.0f];
    //[self.view addSubview:button];
    
    // try to add button in collect view
    // textView
    
    _bUser = [BmobUser getCurrentUser];

}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.imageView.hidden = NO;
    //self.imageView.image = self.image;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) publishTextPost
{
    // record the error info
    __block NSError * postError = nil;
    __block NSUInteger maxPostID;
    BmobQuery * query = [BmobQuery queryWithClassName:NEWS_TABLE_NAME];
    [query orderByDescending:NEWSID];
    query.limit = 1;
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (error) {
            postError = error;
        }
        else {
            if ([array count] == 1) {
                BmobObject *bb = [array firstObject];
                NSNumber *postID= [bb objectForKey:NEWSID];
                maxPostID = postID.integerValue;
            }
            else
                maxPostID = 0;
            
            maxPostID++;
            NSString * text = self.publishTextView.text;
            // 1. save to post table
            NSNumber * newID = [[NSNumber alloc] initWithInteger:maxPostID];
            BmobObject * newsBB = [BmobObject objectWithClassName:NEWS_TABLE_NAME];
            BmobUser *bUser = [BmobUser getCurrentObject];
            [newsBB setObject:newID forKey:NEWSID];
            [newsBB setObject:bUser.username forKey:USERNAME];
            [newsBB setObject:text forKey:NEWS_CONTENT];
            [newsBB saveInBackground];
            
        }
        NSLog(@"Task2 Done");
    }];
}
-(void) publishImagePost: (NSArray *) imageDict withThumb: (NSArray *) thumbImageDict
{
    // record the error info
    __block NSError * postError = nil;
    __block NSMutableArray * imageNameArray =
        [[NSMutableArray alloc] initWithCapacity:[imageDict count]];
    __block NSMutableArray * imageUrlArray =
        [[NSMutableArray alloc] initWithCapacity:[imageDict count]];
    __block NSMutableArray * thumbUrlArray =
        [[NSMutableArray alloc] initWithCapacity:[imageDict count]];
    __block NSUInteger maxPostID;
    dispatch_group_t databaseGroup = dispatch_group_create();
    dispatch_group_t thumbImageGroup = dispatch_group_create();
    
//    for (NSDictionary *image in imageDict) {
//        [imageNameArray addObject:[image objectForKey:@"filename"]];
//    }
    //create the dispatch group
    // start first database connection, store the
    dispatch_group_enter(databaseGroup);
    [BmobProFile uploadFilesWithDatas:imageDict resultBlock:^(NSArray *filenameArray, NSArray *urlArray, NSArray *bmobFileArray, NSError *error) {
        if (error) {
            postError = error;
            NSLog(@"%@",error);
        }
        else{
            NSLog(@"fileArray %@ urlArray %@",filenameArray,urlArray);
            for (BmobFile* bmobFile in bmobFileArray ) {
                NSLog(@"%@",bmobFile);
            }
            for (NSString * fileName in filenameArray) {
                [imageNameArray addObject:fileName];
            }
            for (NSString * fileName in urlArray) {
                [imageUrlArray addObject:fileName];
            }
            
        }
        dispatch_group_leave(databaseGroup);
        NSLog(@"Task1 Done");
    } progress:^(NSUInteger index, CGFloat progress) {
        [SVProgressHUD showProgress:progress status:@"图片上传中，请稍候！"];
         NSLog(@"index %lu progress %f",(unsigned long)index,progress);
    }];
    
    dispatch_group_enter(databaseGroup);
    BmobQuery * query = [BmobQuery queryWithClassName:@"newsPub"];
    [query orderByDescending:@"newsID"];
    query.limit = 1;
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        dispatch_group_leave(databaseGroup);
        if (error) {
            postError = error;
            NSLog(@"%@",error);
        }
        else {
            if ([array count] == 1) {
                NSNumber * postID = [[array firstObject] objectForKey:@"newsID"];
                maxPostID = postID.integerValue;
            }
            else
                maxPostID = 0;
            
        }
        NSLog(@"Task2 Done");
    }];
    
    dispatch_group_enter(databaseGroup);
    [BmobProFile uploadFilesWithDatas:thumbImageDict resultBlock:^(NSArray *filenameArray, NSArray *urlArray, NSArray *bmobFileArray, NSError *error) {
        if (error) {
            postError = error;
            NSLog(@"%@",error);
        }
        else{
            NSLog(@"fileArray %@ urlArray %@",filenameArray,urlArray);
            for (NSString * fileName in urlArray) {
                [thumbUrlArray addObject:fileName];
            }
        }
        dispatch_group_leave(databaseGroup);
        NSLog(@"Task1 Done");
    } progress:^(NSUInteger index, CGFloat progress) {
        NSLog(@"index %lu progress %f",(unsigned long)index,progress);
    }];
    
//    dispatch_group_enter(thumbImageGroup);
//    __block NSMutableArray * thumbImageNames = [[NSMutableArray alloc] initWithCapacity:[imageNameArray count]];
//    dispatch_group_notify(databaseGroup, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        // ask to generate the thumbnail image
//        for (NSString *imageName in imageNameArray) {
//            dispatch_group_enter(thumbImageGroup);
//            NSLog(@"%@",imageName);
//            [BmobProFile thumbnailImageWithFilename:imageName ruleID:1 resultBlock:^(BOOL isSuccessful, NSError *error, NSString *filename, NSString *url, BmobFile *file) {
//                NSLog(@"filename %@",filename);
//                //缩略图的url地址
//                NSLog(@"fileUrl  %@",url);
//                NSLog(@"error    %@",error);
//                if(error){
//                    NSLog(@"%@",error);
//                }else{
//                    dispatch_group_leave(thumbImageGroup);
//                    [thumbUrlArray addObject:url];
//                    
//                }
//            }];
//        }
//        dispatch_group_leave(thumbImageGroup);
//    });
    dispatch_group_notify(databaseGroup, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // wait util above finish
        maxPostID++;
        NSString * text = self.publishTextView.text;
        // 1. save to post table
        NSNumber * newID = [[NSNumber alloc] initWithInteger:maxPostID];
        BmobObject * newsBB = [BmobObject objectWithClassName:NEWS_TABLE_NAME];
        BmobUser *bUser = [BmobUser getCurrentObject];
        [newsBB setObject:bUser forKey:USERPOINT];
        [newsBB setObject:newID forKey:NEWSID];
        [newsBB setObject:bUser.username forKey:USERNAME];
        [newsBB setObject:text forKey:NEWS_CONTENT];
        [newsBB setObject:imageUrlArray forKey:IMAGES];
        [newsBB setObject:thumbUrlArray forKey:THUMBIMAGES];
        [newsBB saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            if (isSuccessful) {
                //NSLog(@"%@",error);
            }
            else{
                NSLog(@"%@",error);
            }
        }];
    });
    
}
- (IBAction)publishNews:(id)sender
{
    if ([self.chooseImages count] == 0)
    {
        [self publishTextPost];
        // publist without picture
    }
    else
    {
        NSUInteger imageCount = [self.chooseImages count];
        NSMutableArray * imageToDataBase = [[NSMutableArray alloc] initWithCapacity:imageCount];
        NSMutableArray * thumbImageToDataBase =[[NSMutableArray alloc] initWithCapacity:imageCount];
        for (NSUInteger index = 0; index < imageCount; index++)
        {
            UIImage * image = [self.chooseImages objectAtIndex:index];
            NSString * imageName = [self.chooseImageNames objectAtIndex:index];
            NSDictionary * dict = [[NSDictionary alloc] initWithObjectsAndKeys:imageName,@"filename",
            UIImageJPEGRepresentation(image, IMAGE_COMPRESSION_RATIO),@"data",nil];
            UIImage * thumbImage = [self shrinkImage:image toSize:CGSizeMake(250, 250)];
            NSDictionary * thumbdict = [[NSDictionary alloc] initWithObjectsAndKeys:imageName,@"filename",
                                   UIImageJPEGRepresentation(thumbImage, IMAGE_COMPRESSION_RATIO),@"data",nil];
            [imageToDataBase addObject:dict];
            [thumbImageToDataBase addObject:thumbdict];
        }
        // submit to database
        [self publishImagePost:imageToDataBase withThumb:thumbImageToDataBase];
    }
    [self.navigationController popToRootViewControllerAnimated:YES];

}

-(void)pickMediaFromSource:(UIImagePickerControllerSourceType)sourceType
{
    NSArray * mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
    if ([UIImagePickerController isSourceTypeAvailable:sourceType] &&
        [mediaTypes count] > 0)
    {
        NSArray * mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.mediaTypes = mediaTypes;
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:NULL];
    }
    else
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error accessing media" message:@"Unsupported media source" delegate:nil cancelButtonTitle:@"Drat!" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(void)openCamera
{
    ELCImagePickerController * elcPicker = [[ELCImagePickerController alloc] initImagePicker];
    elcPicker.maximumImagesCount = 8; // set the max images to select
    elcPicker.returnsOriginalImage = NO; //Only return the fullScreenImage, not the fullResolutionImage
    elcPicker.returnsImage = YES; //Return UIimage if YES. If NO, only return asset location information
    elcPicker.onOrder = YES; //For multiple image selection, display and return selected order of images
    elcPicker.imagePickerDelegate = self;
    
    [self presentViewController:elcPicker animated:YES completion:nil];
}
#pragma mark UICollectionViewDelegate
// return number of items in a section
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}
// return
-(UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)iPath
{
    static NSString *CellIndentifier = @"Cell";
    UICollectionViewCell * cell = [cv dequeueReusableCellWithReuseIdentifier:CellIndentifier forIndexPath:iPath];
    cell.layer.borderColor = [UIColor colorWithRed:0 green:1 blue:1 alpha:1].CGColor;
    cell.layer.borderWidth = 1.0f;
    
    UIButton * ub = [[cell.contentView subviews] lastObject];
    if (iPath.item == 0) {
        [ub setTitle:@"Add" forState:UIControlStateNormal];
        [ub addTarget:self action:@selector(openCamera) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        [ub setTitle:@"Del" forState:UIControlStateNormal];
    }
    return cell;
}

#pragma mark UIImagePickerDelegate

-(UIImage *) shrinkImage:(UIImage *)original toSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    CGFloat originalAspect = original.size.width /original.size.height;
    CGFloat targetAspect = size.width/size.height;
    CGRect targetRect;
    
    if(originalAspect > targetAspect)
    {
        // original is wider than target
        targetRect.size.width = size.width;
        targetRect.size.height = size.height * targetAspect/originalAspect;
        targetRect.origin.x = 0;
        targetRect.origin.y = (size.height - targetRect.size.height) * 0.5;
    }
    else if(originalAspect < targetAspect)
    {
        targetRect.size.width = size.width * originalAspect/targetAspect;
        targetRect.size.height = size.height;
        targetRect.origin.x = (size.width - targetRect.size.width)*0.5;
        targetRect.origin.y = 0;
    }
    else
    {
        targetRect = CGRectMake(0, 0, size.width, size.height);
    }
    
    [original drawInRect:targetRect];
    UIImage * final = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return final;
}

-(void) elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:[info count]];
    NSMutableArray *imageURLs = [NSMutableArray arrayWithCapacity:[info count]];
    NSMutableArray *imageNames = [NSMutableArray arrayWithCapacity:[info count]];
    for (NSDictionary *dict in info)
    {
        if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypePhoto)
        {
            if([dict objectForKey:UIImagePickerControllerOriginalImage])
            {
                UIImage * image = [dict objectForKey:UIImagePickerControllerOriginalImage];
                NSURL *refURL = [dict objectForKey:UIImagePickerControllerReferenceURL];
                [images addObject:image];
                [imageNames addObject:[refURL lastPathComponent]];
            }
        }
    }
    
    self.chooseImages = images;
    self.chooseImageNames = imageNames;
}

-(void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


#pragma mark TextViewDelegate

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if(textView != nil)
        [textView becomeFirstResponder];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
@end
