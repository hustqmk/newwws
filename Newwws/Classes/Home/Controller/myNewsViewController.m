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
@property (strong, nonatomic) BmobEvent *bmobEvent;
@end

static NSString * const NEWS_TABLE = @"newsPub";
static NSString * const NEWS_ID = @"newsID";
static NSString * const NEWS_TEXT = @"text";

@implementation News

@end
@implementation myNewsViewController

- (void)initNewsData
{
    BmobQuery * query = [BmobQuery queryWithClassName:NEWS_TABLE];
    [query orderByDescending:NEWS_ID];
    query.limit = 3;
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for (BmobObject *obj in array) {
            News * info = [[News alloc] init];
            info.text = [obj objectForKey:NEWS_TEXT];
            [self.newsData addObject:info];
        }
        [self.myNewsTableView reloadData];
    }];
    
}

-(void)listen{
    //创建BmobEvent对象
    _bmobEvent          = [BmobEvent defaultBmobEvent];
    //设置代理
    _bmobEvent.delegate = self;
    //启动连接
    [_bmobEvent start];
}

-(void)bmobEventCanStartListen:(BmobEvent *)event{
    //监听Post表更新
    [_bmobEvent listenTableChange:BmobActionTypeUpdateTable tableName:NEWS_TABLE];
}
//接收到得数据
-(void)bmobEvent:(BmobEvent *)event didReceiveMessage:(NSString *)message{
    //打印数据
    NSLog(@"didReceiveMessage:%@",message);
    
}
- (void) updateMyNews
{
    BmobQuery * query = [BmobQuery queryWithClassName:NEWS_TABLE];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self listen];
    // Do any additional setup after loading the view.
    // get user info
    _newsData = [[NSMutableArray alloc] initWithCapacity:3];
    [self initNewsData];
    // load user data
}

-(void) viewDidAppear:(BOOL)animated
{
    [self updateMyNews];
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
