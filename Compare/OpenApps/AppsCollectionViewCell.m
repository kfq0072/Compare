//
//  AppsCollectionViewCell.m
//  Compare
//
//  Created by hsm on 2017/6/21.
//  Copyright © 2017年 huangshuimei. All rights reserved.
//

#import "AppsCollectionViewCell.h"
@interface AppsCollectionViewCell(){

}
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end
@implementation AppsCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code  
}

- (void)setUpCellWithImageName:(NSString *)name {
    self.imageView.image = [UIImage imageNamed:name];
}

@end
