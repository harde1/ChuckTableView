//
//  CCellMonth.m
//  ChuckTableView
//
//  Created by 梁慧聪 on 2017/1/4.
//  Copyright © 2017年 liangdianxiong. All rights reserved.
//

#import "CCellMonth.h"
#import "UICollectionViewCell+Chuck.h"
#import "UtilScreenSize.h"
@interface CCellMonth()

@property (weak, nonatomic) IBOutlet UILabel *lbMonth;

@end
@implementation CCellMonth

- (void)awakeFromNib {
    [super awakeFromNib];
    [self boderBtn:_lbMonth];
}
-(void)collectionView:(ChuckCollectionView *)collectionView vcDelegate:(id)vcDelegate cellForRowWithModel:(id)model atIndexPath:(NSIndexPath *)indexPath{
    self.lbMonth.text = model;
}
-(void)boderBtn:(UIView *)view{
    view.layer.borderWidth = 1;
    view.layer.borderColor = UIColorFromRGB(0x4186ce).CGColor;
    view.layer.cornerRadius = 5;
}
@end
