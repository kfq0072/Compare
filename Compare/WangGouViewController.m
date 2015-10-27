//
//  WangGouViewController.m
//  Compare
//
//  Created by huangshuimei on 10/3/15.
//  Copyright (c) 2015 huangshuimei. All rights reserved.
//

#import "WangGouViewController.h"
#import "SFSCollectionMenuController.h"
#import "BaseWangViewController.h"

@interface WangGouViewController ()<SFSCollectionMenuDelegate>{
    BOOL _dismissFlag;
}
@property (nonatomic, strong) SFSCollectionMenuController *collectionMenu;



@end

@implementation WangGouViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    _dismissFlag = YES;
    self.title = @"网购";
    
    UIColor *topColor = [UIColor colorWithRed:196.0f/255.0f green:166.0/255.0 blue:189.0f/255.0f alpha:1.0];
    UIImage *imagetop= [Utility createImageWithColor:topColor];
    [self.navigationController.navigationBar setBackgroundImage:imagetop forBarMetrics:UIBarMetricsDefault];
    
    UIColor *bottomColor = [UIColor colorWithRed:220.0f/255.0f green:191.0/255.0 blue:192.0f/255.0f alpha:1.0];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.frame;
    UIColor *midColor = [UIColor colorWithRed:220.0f/255.0f green:231.0/255.0 blue:164.0f/255.0f alpha:1.0];
    gradient.colors = [NSArray arrayWithObjects:(id)topColor.CGColor,
                       (id)midColor.CGColor,
                       (id)bottomColor.CGColor,nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
    
}
- (void)viewDidAppear:(BOOL)animated {
    if (_dismissFlag) {
         [self buttonTap];
        _dismissFlag = !_dismissFlag;
    }
    [self initBandView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)buttonTap {
    if (!_collectionMenu) {
        _collectionMenu = [[SFSCollectionMenuController alloc] initWithDelegate:self];
    }
    [self.collectionMenu showMenuWithLightEffect:SFSLightEffectTypeMediumLight];
}


#pragma mark - SFSCollectionMenuDelegate methods

- (UIView *)viewForMenu {
    return self.view;
}

- (NSInteger)numberOfButtonsInMenuController:(SFSCollectionMenuController *)controller {
    return 6;
}

- (UIImage *)imageForButtonAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *images = @[[UIImage imageNamed:@"taobao"],
                        [UIImage imageNamed:@"jd"],
                        [UIImage imageNamed:@"suning"],
                        [UIImage imageNamed:@"tianMao"],
                        [UIImage imageNamed:@"yixun"],
                        [UIImage imageNamed:@"weipin"]];
    return images[indexPath.row];
}

- (UIColor *)backgroundColorForButtonAtIndexPath:(NSIndexPath *)indexPath {
    return [UIColor colorWithRed:1 green:1 blue:1 alpha:1.0];
}

- (void)controller:(SFSCollectionMenuController *)controller didTapButtonAtIndexPath:(NSIndexPath *)indexPath {
    
    BaseWangViewController *wVC = [[BaseWangViewController alloc] init];
    wVC.urlType = (int)indexPath.row;
    [self presentViewController:wVC animated:YES completion:^(void){
        _dismissFlag = YES;
        wVC.isTuanFlag = NO;
    }];

}

- (NSString *)accessibilityLabelForButtonAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *labels = @[@"Camera",
                        @"Chat",
                        @"Phone",
                        @"Star",
                        @"Tag",
                        @"Voicemail"];
    return labels[indexPath.row];
}

- (NSString *)accessibilityHintForButtonAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *hints = @[@"Opens the camera",
                       @"Starts a chat session",
                       @"Opens the phone app",
                       @"Marks this as a favorite",
                       @"Tags this for later",
                       @"Opens the voicemail interface to listen to voicemails"];
    return hints[indexPath.row];
}

- (UIImage *)imageForCloseButton {
    return [UIImage imageNamed:@"closeButtonGray"];
}

- (NSString *)labelTextForMenu {
//    return @"My Menu";
    return @" ";
}

- (UIColor *)colorForLabelText {
    return [UIColor whiteColor];
}

- (NSString *)accessibilityHintForMenuLabel {
    return @"Displaying My Menu to choose an option";
}

- (NSString *)accessibilityLabelForMenuLabel {
    return @" ";
//    return @"My Menu";
}

- (BOOL)isButtonEnabledAtIndexPath:(NSIndexPath *)indexPath inMenuController:(SFSCollectionMenuController *)controller {
//    NSInteger button = indexPath.row;
//    if (button == 1) // this would be the "Chat" button
//        return NO;
    // or for instance, if MessageUI framework is added, you could do:
    // return ([MFMessageComposeViewController canSendText]) ? YES : NO;
    
    return YES;
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
