//
//  CCellPlayer.m
//  ChuckTableView
//
//  Created by 梁慧聪 on 2017/1/5.
//  Copyright © 2017年 liangdianxiong. All rights reserved.
//

#import "CCellPlayer.h"
#import "UICollectionViewCell+Chuck.h"
#import "ReviewController.h"
@interface CCellPlayer()

@end
@implementation CCellPlayer

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.ivPlayer];
        
        
        [self resetFrame];
    }
    return self;
}
-(void)collectionView:(ChuckCollectionView *)collectionView vcDelegate:(ReviewController *)vcDelegate didEndDisplayingCellWithModel:(id)model atIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"第一个cell离开了");
    __weak typeof(self) wSelf = self;
    [wSelf.ivPlayer removeFromSuperview];
    [UIView animateWithDuration:0.5 animations:^{
        [vcDelegate.view addSubview:wSelf.ivPlayer];
        wSelf.ivPlayer.frame = wSelf.bounds;
    }];
}
-(void)collectionView:(ChuckCollectionView *)collectionView vcDelegate:(ReviewController *)vcDelegate willDisplayCellWithModel:(id)model atIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"第一个cell出现了");
        [self resetPlayer];
}
-(void)resetPlayer{
    __weak typeof(self) wSelf = self;
    [wSelf.ivPlayer removeFromSuperview];
    [UIView animateWithDuration:0.5 animations:^{
        [wSelf.contentView addSubview:wSelf.ivPlayer];
        wSelf.ivPlayer.frame = wSelf.bounds;
    }];
}
-(UIImageView *)ivPlayer{
    if (!_ivPlayer) {
        _ivPlayer = [[UIImageView alloc] init];
        _ivPlayer.backgroundColor = [UIColor lightGrayColor];
    }
    return _ivPlayer;
}

- (void)resetFrame {
    self.ivPlayer.frame = self.bounds;
}
@end
