//
//  CollectCellBottomBar.m
//  ChuckTableView
//
//  Created by 梁慧聪 on 2017/1/4.
//  Copyright © 2017年 liangdianxiong. All rights reserved.
//

#import "CollectCellBottomBar.h"

#import "StarCardController.h"
#import "UICollectionViewCell+Chuck.h"
#import "UtilScreenSize.h"
#import "CCellUserNum.h"
#import "CollectCellTopBar.h"
#import "CCellMonth.h"
#import "CollectCellContent.h"
@interface CollectCellBottomBar()
@property (weak, nonatomic) IBOutlet UIButton *btnFriend;
@property (weak, nonatomic) IBOutlet UIButton *btnRightNow;
@property (nonatomic,weak)ChuckCollectionView * collect;
@end
@implementation CollectCellBottomBar

- (void)awakeFromNib {
    [super awakeFromNib];
    [self boderBtn:self.btnFriend];
    [self boderBtn:self.btnRightNow];
    
}
-(void)collectionView:(ChuckCollectionView *)collectionView vcDelegate:(id)vcDelegate cellForRowWithModel:(id)model atIndexPath:(NSIndexPath *)indexPath{
    
    self.collect = collectionView;
}
- (IBAction)clickRightNow:(UIButton *)sender {
    
    if (self.collect) {
        id model = [self.collect modelsAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
        if ([model isEqualToString:@"星卡详情"]) {
            [self.collect replaceSection:CellTopBar models:@[@"开通账号"] cellClass:CCellUserNum.class completion:^(BOOL finished) {
                
            }];
            [self.collect replaceSection:CellContent models:@[@"一月份",@"二月份",@"三月份",@"四月份",@"五月份",@"六月份",@"八月份"] cellClass:CCellMonth.class completion:^(BOOL finished) {
                
            }];
            
        }else{
            [self.collect replaceSection:CellTopBar models:@[@"星卡详情"] cellClass:CollectCellTopBar.class completion:^(BOOL finished) {
                
            }];
            [self.collect replaceSection:CellContent models:@[@"CellContent",@"CellContent"] cellClass:CollectCellContent.class completion:^(BOOL finished) {
                
            }];
            
        }
    }
}

-(void)boderBtn:(UIButton *)btn{
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = UIColorFromRGB(0x4186ce).CGColor;
    btn.layer.cornerRadius = 5;
}
@end
