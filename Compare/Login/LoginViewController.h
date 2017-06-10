//
//  LoginViewController.h
//  Compare
//
//  Created by huangshuimei on 2016/12/22.
//  Copyright © 2016年 huangshuimei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UILabel *alertText;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@end
