//
//  HistroyViewController.m
//  Compare
//
//  Created by huangshuimei on 10/8/15.
//  Copyright (c) 2015 huangshuimei. All rights reserved.
//

#import "MeViewController.h"
#import "Utility.h"
#import "AnimationPauseViewController.h"
#import "SettingTableViewController.h"
#import "MBProgressHUD.h"



@interface MeViewController ()<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate> {
    int _index;
}
@property (weak, nonatomic) IBOutlet UITableView *hTableView;
@property (strong, nonatomic) NSArray *imageArray;
@property (strong, nonatomic)MBProgressHUD *HUD;



@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我";
    UIColor *topColor = [UIColor colorWithRed:196.0f/255.0f green:166.0/255.0 blue:189.0f/255.0f alpha:1.0];
    UIImage *imagetop= [Utility createImageWithColor:topColor];
    [self.navigationController.navigationBar setBackgroundImage:imagetop forBarMetrics:UIBarMetricsDefault];
    // Do any additional setup after loading the view.
//    NSArray *imageName = @[@"pic",@"save",@"money",@"face",@"set",@"clear"];
    NSArray *imageTitle = @[@"摇一摇",@"设置",@"清除内存"];
    _imageArray = imageTitle;
    _index = 0 ;
    [_hTableView.layer insertSublayer:[Utility designColor:_hTableView.frame] atIndex:0];
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
    
    _HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:_HUD];
    
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
