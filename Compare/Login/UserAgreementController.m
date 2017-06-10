//
//  UserAgreementController.m
//  Compare
//
//  Created by huangshuimei on 2016/12/22.
//  Copyright © 2016年 huangshuimei. All rights reserved.
//

#import "UserAgreementController.h"

@interface UserAgreementController ()

@end

@implementation UserAgreementController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"用户服务条款和隐私政策";
    UIWebView *agreementWeb = [[UIWebView alloc]initWithFrame:CGRectMake(15, 12, mainScreenWidth-30, mainScreenHeight-12)];
    agreementWeb.backgroundColor = [UIColor whiteColor];
    agreementWeb.scrollView.showsVerticalScrollIndicator = NO;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"USERAGREEMENT.html" ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [agreementWeb loadRequest:request];
 
    [self.view addSubview:agreementWeb];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
