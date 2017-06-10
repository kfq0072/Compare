//
//  LoginViewController.m
//  Compare
//
//  Created by huangshuimei on 2016/12/22.
//  Copyright © 2016年 huangshuimei. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (IBAction)forgetPassWordClick:(id)sender {
    UIStoryboard *loginStoryboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
//    FindMyPassWordViewController *findPassVC = [loginStoryboard instantiateViewControllerWithIdentifier:@"FindMyPassWordViewController"];
//    findPassVC.loginVC = self;
//    [self.navigationController pushViewController:findPassVC animated:YES];
}
- (IBAction)doRegisterClick:(id)sender {
//    SignUpController *signUpVC = [[SignUpController alloc]init];
//    [self.navigationController pushViewController:signUpVC animated:YES];
}
- (IBAction)tryPlayClick:(id)sender {
    [self backButtonPress:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.userNameTextField addTarget:self action:@selector(contentTextChange:) forControlEvents:UIControlEventAllEditingEvents];
    [self.pwdTextField addTarget:self action:@selector(contentTextChange:) forControlEvents:UIControlEventAllEditingEvents];
    [self.loginButton setTitleColor:UIHexColor(0x59687f) forState:UIControlStateNormal];
    self.loginButton.userInteractionEnabled = NO;
    
}
-(void)contentTextChange:(UITextField *)sender
{
    if (sender == self.userNameTextField) {
        //电话输入合法后改变提示
        if ([self isPhoneNumberValid] && [self.alertText.text isEqualToString:@"请输入正确的手机号码"]) {
            self.alertText.text = @"";
        }
        
    }
    else
    {
        
    }
    
    
    if (self.userNameTextField.text != nil && self.pwdTextField.text != nil && ![self.userNameTextField.text isEqualToString:@""] && ![self.pwdTextField.text isEqualToString:@""] ) {
        [self loginButtonEnable:YES];
    }
    else
    {
        [self loginButtonEnable:NO];
    }
}
#pragma mark - 登录按键可点击与不可点击状态改变
-(void)loginButtonEnable:(BOOL)enable
{
    self.loginButton.userInteractionEnabled = enable;
    if (enable == NO) {
        [self.loginButton setTitleColor:UIHexColor(0x59687f) forState:UIControlStateNormal];
    }
    else
    {
        [self.loginButton setTitleColor:UIHexColor(0xffffff) forState:UIControlStateNormal];
    }
}


- (IBAction)loginButtonPress:(id)sender {
//    if (![self isPhoneNumberValid]) {
//        //提示电话号码不合法
//        self.alertText.text = @"请输入正确的手机号码";
//        return;
//    }
//    [_loginButton setTitle:@"登录中..." forState:UIControlStateNormal];
//    SignAndLoginHandler *handler = [[SignAndLoginHandler alloc]init];
//    [handler loginWithUserName:self.userNameTextField.text AndPassWord:self.pwdTextField.text MyDelegate:self];
}
#pragma mark - login and signup delegate
-(void)loginResponse:(BOOL)success ContentText:(NSString *)textStr AndUserIcon:(NSString *)iconUrlStr
{
//    if (success == YES) {
//        [self.userImageView sd_setImageWithURL:[NSURL URLWithString:iconUrlStr] placeholderImage:[UIImage imageNamed:@"icon_login_header"]];
//    }else
//    {
//        self.alertText.text = textStr;
//    }
}
-(void)loginFinish:(BOOL)finish
{
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    if (finish == YES) {
        [self backButtonPress:nil];
    }else
    {
        NSLog(@"com.Fate.用户信息获取失败");
    }
}
#pragma mark - 电话号码合法检查
-(BOOL)isPhoneNumberValid
{
    BOOL flag = NO;
    NSString *phoneNumber = self.userNameTextField.text;
    if (phoneNumber.length>0) {
        NSString *toBeString = phoneNumber;
        NSString *regex = @"^((13[0-9])|(147)|(145)|(15[^4,\\D])|(17[0-9])|(18[0-9]))\\d{8}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        flag = [pred evaluateWithObject:toBeString];
    }
    return flag;
}

#pragma mark - 获取历史用户信息
- (IBAction)showUserHistoryInfo:(id)sender {
    
}

#pragma mark - 返回
- (IBAction)backButtonPress:(id)sender {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
