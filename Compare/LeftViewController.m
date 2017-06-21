//
//  LeftViewController.m
//  LeftRightSlider
//
//  Created by Zhao Yiqi on 13-11-27.
//  Copyright (c) 2013年 Zhao Yiqi. All rights reserved.
//

#import "LeftViewController.h"
#import "Utility.h"
#import "AnimationPauseViewController.h"
#import "SettingTableViewController.h"
#import "MBProgressHUD.h"

@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate> {
    int _index;
}

@property (strong, nonatomic) NSArray *imageArray;
@property (strong, nonatomic)MBProgressHUD *HUD;
@end

@implementation LeftViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"我";
    NSArray *imageTitle = @[@"摇一摇",@"设置",@"清除内存"];
    _imageArray = imageTitle;
    _index = 0 ;
    
    UITableView *tableV=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-100, self.view.frame.size.height)];
    tableV.backgroundColor=[UIColor whiteColor];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    self.view.backgroundColor = [UIColor redColor];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.0;
    }else {
        return 10.0;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 && indexPath.section ==0 ) {
        return 80.0;
    }else {
        return 44.0;
    }
}
#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 2) {
        return 2;
    }else {
        return 1;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identiy = @"cellIdent";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identiy];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identiy];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor clearColor];
    if (indexPath.row == 0 && indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"me"];
        cell.textLabel.text = @"your information";
    }else {
        cell.textLabel.text = [_imageArray objectAtIndex:_index];
        _index ++;
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        AnimationPauseViewController  *animationVC = [storyboard instantiateViewControllerWithIdentifier:@"animationVC"];
        [self.navigationController pushViewController:animationVC animated:YES];
    }else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            SettingTableViewController *setTb = [storyboard instantiateViewControllerWithIdentifier:@"SettingTb"];
            [self.navigationController pushViewController:setTb animated:YES];
        }else {
            [self showDeterminateActivity];
        }
    }
}

- (void)showDeterminateActivity {
    
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUD];
    _HUD.center = [UIScreen mainScreen].focusedView.center;
    
    // Set determinate mode
    _HUD.mode = MBProgressHUDModeDeterminate;
    
    _HUD.delegate = self;
    _HUD.labelText = @"Cleaning";
    
    // myProgressTask uses the HUD instance to update progress
    [_HUD showWhileExecuting:@selector(myProgressTask) onTarget:self withObject:nil animated:YES];
}


- (void)showWithCustomView {
    
    
    // The sample image is based on the work by http://www.pixelpressicons.com, http://creativecommons.org/licenses/by/2.5/ca/
    // Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
    
    _HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    
    // Set custom view mode
    _HUD.mode = MBProgressHUDModeCustomView;
    _HUD.labelText = @"Completed";
    [_HUD hide:YES afterDelay:3];
    
    
}

#pragma mark - MBProgressHUDDelegate

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [_HUD removeFromSuperview];
    _HUD = nil;
    
}

- (void)myProgressTask {
    // This just increases the progress indicator in a loop
    float progress = 0.0f;
    while (progress < 1.0f) {
        progress += 0.01f;
        _HUD.progress = progress;
        usleep(20000);
    }
    [self showWithCustomView];
    
}
@end
