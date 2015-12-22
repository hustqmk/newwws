//
//  registerViewController.m
//  firstAP
//
//  Created by hustqmk on 15/8/18.
//  Copyright (c) 2015年 hustqmk. All rights reserved.
//

#import "registerViewController.h"

@interface registerViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *verifyCodeTextField;
@property (nonatomic) int smsID;
@end

@implementation registerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)requestVerifyCodeButtonPressed:(id)sender {
    NSString * phoneNumber = self.phoneNumberTextField.text;
    [BmobSMS requestSMSCodeInBackgroundWithPhoneNumber:phoneNumber andTemplate:@"test" resultBlock:^(int number, NSError *error) {
        if (error) {
            NSLog(@"error when request verify code.");
        }
        else
        {
            self.smsID = number;
            NSLog(@"%d",number);
        }
    }];
}
- (IBAction)submitButtonPressed:(id)sender {
    utility * util = [[utility alloc] init];
    NSString * phoneNumber = self.phoneNumberTextField.text;
    NSString * passwd = self.passwordTextField.text;
    NSString * verifyCode = self.verifyCodeTextField.text;
    
    if([util checkUseName:phoneNumber] || [util checkPasswd:passwd])
    {
        [BmobSMS verifySMSCodeInBackgroundWithPhoneNumber:phoneNumber andSMSCode:verifyCode resultBlock:^(BOOL isSuccessful, NSError *error) {
            if (isSuccessful) {
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"恭喜，验证成功" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                [alert show];
            }
            else
            {
                NSLog(@"%@",error);
            }
        }];
    }
    else
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"password set wrong format" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
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
