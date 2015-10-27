//
//  TuanViewController.m
//  Compare
//
//  Created by huangshuimei on 10/3/15.
//  Copyright (c) 2015 huangshuimei. All rights reserved.
//

#import "TuanViewController.h"
#import "JKPopMenuView.h"
#import "BaseWebViewController.h"

@interface TuanViewController ()<JKPopMenuViewSelectDelegate>{
    BOOL _dismissFlag;
}
@property (nonatomic, strong)JKPopMenuView *jkpop;

@end

@implementation TuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dismissFlag = YES;
    self.title = @"团购";
    //TODO: 侧栏
//    UIImage *image = [[UIImage imageNamed:@"icon1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    
//    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithImage:image  style:UIBarButtonItemStylePlain target:self action:@selector(disPlayMenuItem)];
//    self.navigationItem.leftBarButtonItem = leftBar;

    UIColor *topColor = [UIColor colorWithRed:196.0f/255.0f green:166.0/255.0 blue:189.0f/255.0f alpha:1.0];
    UIImage *imagetop= [Utility createImageWithColor:topColor];
    [self.navigationController.navigationBar setBackgroundImage:imagetop forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    if (_dismissFlag) {
        [self disPlayMenuItem];
        _dismissFlag = !_dismissFlag;
    }
    
    [self initBandView];
}

- (void)disPlayMenuItem {
    NSMutableArray *array = [[NSMutableArray alloc]init];
    NSArray *titleArray = @[@"美团",@"大众点评",@"拉手",@"窝窝团",@"糯米",@"团800",@"wait"];
    for (NSInteger i = 1; i < 7; i++) {
        NSString *string = [NSString stringWithFormat:@"icon%ld",i];
        JKPopMenuItem *item = [JKPopMenuItem itemWithTitle:titleArray[i-1] image:[UIImage imageNamed:string]];
        [array addObject:item];
    }
    
    self.jkpop = [JKPopMenuView menuViewWithItems:array];
    _jkpop.delegate = self;
    [_jkpop show:self];
    
}
- (void)viewDidDisappear:(BOOL)animated {
    [_jkpop disappear];
    _dismissFlag = !_dismissFlag;
}

#pragma mark App JKPopMenuViewSelectDelegate
- (void)popMenuViewSelectIndex:(NSInteger)index
{
    NSLog(@"%s,%ld",__func__,index);
    BaseWebViewController *btVC = [[BaseWebViewController alloc] init];
    btVC.urlType = (int)index;
    [self presentViewController:btVC animated:YES completion:^(void){
        btVC.isTuanFlag = YES;
    }];
    
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
