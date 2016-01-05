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
    self.accountTextField.delegate = self;
    self.passwdTextField.delegate = self;
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
             UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Login Message" message:@"user name or password wrong." delegate:nil cancelButtonTitle:@"OK!" otherButtonTitles:nil, nil];
             [alert show];
             NSLog(@"Login success!");
         }
         else
         {
             UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Login Message" message:@"You're In!" delegate:nil cancelButtonTitle:@"OK!" otherButtonTitles:nil, nil];
             [alert show];
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

#pragma mark TextViewDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField != nil)
        [textField becomeFirstResponder];
}

- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string
{
    if([string isEqualToString:@"\n"])
    {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}

@end
