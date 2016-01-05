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
#import "MKPost.h"
#import "MKPostFrame.h"
#import "MJRefresh.h"
#import "MKPostCell.h"
#import "MKPhoto.h"
@interface myNewsViewController ()
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *theNewField;
@property (strong, nonatomic) NSMutableArray * newsData;
@property (weak, nonatomic) IBOutlet UITableView *myNewsTableView;
@property (strong, nonatomic) BmobEvent *bmobEvent;
@property (strong, nonatomic) NSArray *postFrame;
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

-(void) headerRefreshing
{
    // 连接服务器，获取最新的数据
    BmobQuery *bQuery = [BmobQuery queryWithClassName:NEWS_TABLE_NAME];
    [bQuery setLimit:DEFAULT_NEWS_NUMBER];
    [bQuery orderByDescending:CREATEDAT];
    [bQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [self.myNewsTableView headerEndRefreshing];
        NSMutableArray *postFrameArray = [NSMutableArray array];
        for (BmobObject * obj in array) {
            MKPost * myPost = [[MKPost alloc] init];
            myPost.post_id = [obj objectForKey:NEWSID];
            myPost.text = [obj objectForKey:NEWS_CONTENT];
            myPost.user = [obj objectForKey:USERNAME];
            myPost.created_at = [obj objectForKey:CREATEDAT];
            NSArray * thumbimage_array = [obj objectForKey:THUMBIMAGES];
            NSArray * image_array = [obj objectForKey:IMAGES];
            NSMutableArray *thumbpics_url = [[NSMutableArray alloc] initWithCapacity:[thumbimage_array count]];
            NSMutableArray *image_url = [[NSMutableArray alloc] initWithCapacity:[image_array count]];
            for (int i = 0; i < [thumbimage_array count]; i++) {
                NSMutableString *thumbpics = [[NSMutableString alloc] initWithCapacity:256];
                NSMutableString *pics = [[NSMutableString alloc] initWithCapacity:256];
                MKPhoto * mp = [[MKPhoto alloc]init];
                [thumbpics appendString:thumbimage_array[i]];
                [thumbpics appendString:MKImageUrlPara];
                [pics appendString:image_array[i]];
                [pics appendString:MKImageUrlPara];
                mp.thumbnail_pic = thumbpics;
                mp.pic = pics;
                [thumbpics_url addObject:mp];
            }
            for (NSString *url in image_array) {
                NSMutableString *pics = [[NSMutableString alloc] initWithCapacity:256];
                [pics appendString:url];
                [pics appendString:MKImageUrlPara];
                [image_url addObject:pics];
            }
            myPost.thumbpics_urls = thumbpics_url;
            myPost.pic_urls = image_url;
            
            MKPostFrame * postFrame = [[MKPostFrame alloc] init];
            postFrame.post = myPost;
            [postFrameArray addObject:postFrame];
        }
        self.postFrame = postFrameArray;
        [self.myNewsTableView reloadData];
        if (postFrameArray.count) {
            [self.myNewsTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }

    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self listen];
    // Do any additional setup after loading the view.
    // get user info
    _newsData = [[NSMutableArray alloc] initWithCapacity:3];
    [self initNewsData];
    [self.myNewsTableView addHeaderWithTarget:self action:@selector(headerRefreshing)];
    [self.myNewsTableView headerBeginRefreshing];
    
    self.myNewsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myNewsTableView.backgroundColor = MKColor(226,226,226);
    self.myNewsTableView.contentInset = UIEdgeInsetsMake(0,0,MKPostPadding*0.5, 0);
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
    return [self.postFrame count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.postFrame[indexPath.row] cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MKPostCell *cell = [MKPostCell cellWithTableView:tableView];
    
    cell.postFrame = self.postFrame[indexPath.row];
    
    return cell;
}
/*
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
}*/
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
