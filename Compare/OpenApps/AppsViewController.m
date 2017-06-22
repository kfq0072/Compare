//
//  AppsViewController.m
//  Compare
//
//  Created by hsm on 2017/6/21.
//  Copyright © 2017年 huangshuimei. All rights reserved.
//

#import "AppsViewController.h"
#import "AppsCollectionViewCell.h"
#import "Masonry.h"
#import "Utility.h"
static NSString * const kcellIdentifier = @"CollectCellID";
@interface AppsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSArray *_imageNamesArr;
    NSDictionary *_urlStrDic;
}
@property (nonatomic,strong)UICollectionView *mCollectionView;


@end

@implementation AppsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"App";
    self.view.backgroundColor = [UIColor whiteColor];
    _imageNamesArr = @[@"weChat",@"qq",@"aliPay",@"toutiao",@"mengpai"];
    _urlStrDic =@{@"weChat":@"weixin://",
                  @"aliPay":@"",
                  @"qq":@"mqq://"};
    [self.view addSubview:self.mCollectionView];
    [self.mCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self.view.mas_top);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    //通过Nib生成cell，然后注册 Nib的view需要继承 UICollectionViewCell
    [_mCollectionView registerNib:[UINib nibWithNibName:@"AppsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:kcellIdentifier];
    UIColor *topColor = [UIColor colorWithRed:196.0f/255.0f green:166.0/255.0 blue:189.0f/255.0f alpha:1.0];
    UIColor *bottomColor = [UIColor colorWithRed:220.0f/255.0f green:191.0/255.0 blue:192.0f/255.0f alpha:1.0];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.frame;
    UIColor *midColor = [UIColor colorWithRed:220.0f/255.0f green:231.0/255.0 blue:164.0f/255.0f alpha:1.0];
    gradient.colors = [NSArray arrayWithObjects:(id)topColor.CGColor,
                       (id)midColor.CGColor,
                       (id)bottomColor.CGColor,nil];
    [self.view.layer insertSublayer:gradient atIndex:0];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UICollectionView *)mCollectionView {
    if (_mCollectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _mCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _mCollectionView.dataSource = self;
        _mCollectionView.delegate = self;
        _mCollectionView.backgroundColor = [UIColor clearColor];
        
    }
    return _mCollectionView;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AppsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kcellIdentifier forIndexPath:indexPath];
    NSString *name = [NSString stringWithFormat:@"%@.jpeg",_imageNamesArr[indexPath.row]];
    [cell setUpCellWithImageName:name];
    return cell;
}

#pragma mark - UICollectionViewDelegate
//选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   [collectionView deselectItemAtIndexPath:indexPath animated:YES];
   NSString *nameStr = _imageNamesArr[indexPath.row];
    NSString *urlStr = _urlStrDic[nameStr];
    [self openAppWithUrlStr:urlStr];
}

#pragma mark -- UICollectionViewDelegateFlowLayout
/** 每个cell的尺寸*/
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellWidth = self.mCollectionView.frame.size.width/2 - 10;
    return CGSizeMake(cellWidth, cellWidth);
}

/** 头部的尺寸*/
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(self.view.bounds.size.width, 0);
}

/** 顶部的尺寸*/
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{

    return CGSizeMake(self.view.bounds.size.width, 0);
}

//* section的margin
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

#pragma mark - private
- (void)openAppWithUrlStr:(NSString *)urlStr {
    NSURL *url = [NSURL URLWithString:urlStr];
    if([[UIApplication sharedApplication] canOpenURL:url]){
        [[UIApplication sharedApplication] openURL:url];
    } else {
        UIAlertView*ale=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请安装该app后重试，或用PC进行操作。" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [ale show];
    }
}


@end
