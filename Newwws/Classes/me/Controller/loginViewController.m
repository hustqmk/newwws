//
//  loginViewController.m
//  firstAP
//
//  Created by hustqmk on 15/8/13.
//  Copyright (c) 2015年 hustqmk. All rights reserved.
//

#import "loginViewController.h"
#import <BmobSDK/Bmob.h>
@interface loginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwdTextField;
@property (strong, nonatomic) NSString * userName;
@property (strong, nonatomic) NSString * passwd;
@end

@implementation loginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BmobUser *user = [BmobUser getCurrentUser];
    if (user) {
        // load my setting
        NSLog(@"%@",user);
    }
    else
    {
        // load login view controller
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) login
{
    NSString *userName = self.accountTextField.text;
    NSString *passwd = self.passwdTextField.text;
    
    [BmobUser loginWithUsernameInBackground:userName password:passwd block:^(BmobUser *user, NSError *error)
     {
         if (error)
         {
             NSLog(@"%@",error);
         }
         else
         {
             NSLog(@"Login success!");
         }
     }];
}

- (IBAction)loginPressed:(id)sender {
    utility * util = [[utility alloc] init];
    NSString * passwd = self.passwdTextField.text;
    NSString * useName = self.accountTextField.text;
    if ([util checkUseName:useName] && [util checkPasswd:passwd])
    {
        [self login];
    }

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
