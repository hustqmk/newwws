//
//  myNewsViewController.m
//  firstAP
//
//  Created by hustqmk on 15/8/8.
//  Copyright (c) 2015年 hustqmk. All rights reserved.
//

#import "myNewsViewController.h"
#import <BmobSDK/Bmob.h>
#import <BmobSDK/BmobProFile.h>
@interface myNewsViewController ()
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *theNewField;
@property (strong, nonatomic) NSMutableArray * newsData;
@property (weak, nonatomic) IBOutlet UITableView *myNewsTableView;

@end

static NSString * const title = @"Main title";
static NSString * const subTitle = @"Sub Title";

@implementation News

@end
@implementation myNewsViewController

- (void)getUserInfo
{
    BmobQuery * query = [BmobQuery queryWithClassName:@"newsPub"];
    [query orderByDescending:@"newsID"];
    query.limit = 20;
    [self.newsData removeAllObjects];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for (BmobObject *obj in array) {
            News * info = [[News alloc] init];
            info.text = [obj objectForKey:@"text"];
            //info.thumbnailName = [obj objectForKey:@"thumbnailName"];
            [self.newsData addObject:info];
        }
        [self.myNewsTableView reloadData];
    }];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // get user info
    _newsData = [[NSMutableArray alloc] initWithCapacity:20];
    [self getUserInfo];
    // load user data
}

-(void) viewDidAppear:(BOOL)animated
{
    [self getUserInfo];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Delegate

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}


-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * tableName = @"newsTableCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:tableName];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:tableName];
    }
    if(_newsData && _newsData.count > indexPath.row)
    {
        cell.textLabel.text = [_newsData[indexPath.row] valueForKey:@"text"];
        //cell.detailTextLabel.text = subTitle;
        NSString * imageName = [_newsData[indexPath.row] valueForKey:@"thumbnailName"];
        if (imageName != nil) {
            [BmobProFile downloadFileWithFilename:imageName block:^(BOOL isSuccessful, NSError *error, NSString *filepath) {
                if (isSuccessful) {
                    UIImage *image = [UIImage imageWithContentsOfFile:filepath];
                    cell.imageView.image = image;
                    cell.imageView.hidden = NO;
                    [cell setNeedsLayout];
                }
            } progress:^(CGFloat progress) {
                NSLog(@"Download Progress: %f",progress);
            }];
        }
        else
        {
            [cell setNeedsLayout];
        }
        
    }

    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
