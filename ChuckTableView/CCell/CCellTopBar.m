//
//  CCellTopBar.m
//  kugou
//
//  Created by 梁慧聪 on 2016/12/16.
//  Copyright © 2016年 caijinchao. All rights reserved.
//

#import "CCellTopBar.h"
#import "UICollectionViewCell+Chuck.h"
#import "CollectController.h"


//#import "NSDate+Extension.h"
#define leftRight [UtilScreenSize getPtbyWidth:26]

@interface CCellTopBar()


@property(nonatomic,strong)UIView * vBg;
@property(nonatomic,strong)UIView * vBgDown;

@property(nonatomic,strong)UIImageView * ivHead;
@property(nonatomic,strong)UILabel * lbTime;
@property(nonatomic,strong)UILabel * lbPrograma;
@property(nonatomic,strong)UILabel * lbTitle;
@property(nonatomic,strong)UIImageView * ivArrow;
@property(nonatomic,strong)UIButton * btnLeft;

@end
@implementation CCellTopBar
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.vBg];
        [self.contentView addSubview:self.vBgDown];
        [self.vBg addSubview:self.ivHead];
        [self.vBg addSubview:self.lbTime];
        [self.vBg addSubview:self.lbPrograma];
        [self.vBg addSubview:self.lbTitle];
        [self.contentView addSubview:self.ivArrow];
        self.contentView.layer.masksToBounds = YES;
    }
    return self;
}

-(void)collectionView:(ChuckCollectionView *)collectionView vcDelegate:(CollectController *)vcDelegate cellForRowWithModel:(id)model atIndexPath:(NSIndexPath *)indexPath{


}

-(void)collectionView:(ChuckCollectionView *)collectionView vcDelegate:(CollectController*)vcDelegate didSelectRowWithModel:(id)model atIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"--%@",collectionView.modelSource);

    //    [collectionView removeSectionRange:NSMakeRange(1, 2) completion:^(BOOL finished) {
    //
    //    }];

    //    [collectionView insertModel:@"cell内容的位置" cellClass:NSClassFromString(@"CCellHomeCell") indexPath:[NSIndexPath indexPathForItem:10 inSection:2] completion:^(BOOL finished) {
    //
    //    }];
    [collectionView replaceSection:2 models:@[@"dsahdkjas",@"dasdjhkasd",@"dsdas"] cellClass:NSClassFromString(@"CCellHomeCell") completion:^(BOOL finished) {

    }];
}

-(UIImageView *)ivHead{
    if (!_ivHead) {
        _ivHead = [UIImageView new];
        _ivHead.size = CGSizeMake([UtilScreenSize getPtbyWidth:64], [UtilScreenSize getPtbyWidth:64]);
        _ivHead.left = leftRight;
        _ivHead.backgroundColor = [UIColor grayColor];
        _ivHead.layer.cornerRadius = _ivHead.size.height/2.;
    }
    _ivHead.centerY = self.contentView.centerY;
    return _ivHead;
}
-(UIImageView *)ivArrow{
    if (!_ivArrow) {
        _ivArrow = [UIImageView new];
        _ivArrow.size = CGSizeMake(PxToPt(12), PxToPt(22));
        //        [_ivArrow setImage:[UIImage imageNamed:@"kglive_homeRevision_arrow"] colorKey:KGColorKeyType_ST];
    }
    _ivArrow.centerY = self.contentView.centerY;
    _ivArrow.left = self.width - leftRight - _ivArrow.size.width;
    return _ivArrow;
}
-(UILabel *)lbTime{
    if (!_lbTime) {
        _lbTime = [UILabel new];
        _lbTime.font = [UIFont systemFontOfSize:[UtilScreenSize getFontbyPx:22]];
        _lbTime.text = @"--:--";
        _lbTime.size = CGSizeMake(PxToPt(80), PxToPt(22));
    }
    _lbTime.left = self.ivHead.right + leftRight;
    _lbTime.centerY = self.contentView.centerY-[UtilScreenSize getFontbyPx:22];
    return _lbTime;
}
-(UILabel *)lbPrograma{
    if (!_lbPrograma) {
        _lbPrograma = [UILabel new];
        _lbPrograma.font = [UIFont systemFontOfSize:[UtilScreenSize getFontbyPx:22]];
        _lbPrograma.text = @"---";
        _lbPrograma.size = CGSizeMake(PxToPt(80), PxToPt(22));
    }
    _lbPrograma.left = self.lbTime.right + [UtilScreenSize getFontbyPx:40];
    _lbPrograma.centerY =self.lbTime.centerY;
    return _lbPrograma;
}
-(UILabel *)lbTitle{
    if (!_lbTitle) {
        _lbTitle = [UILabel new];
        _lbTitle.font = [UIFont systemFontOfSize:[UtilScreenSize getFontbyPx:28]];
        _lbTitle.text = @"---";
        _lbTitle.size = CGSizeMake(PxToPt(293), PxToPt(28));
        _lbTitle.width = self.btnLeft.left - self.lbTime.left;
    }
    _lbTitle.left = self.lbTime.left;
    _lbTitle.centerY = self.contentView.centerY+[UtilScreenSize getFontbyPx:28];
    return _lbTitle;
}
-(UIButton *)btnLeft{
    if (!_btnLeft) {
        _btnLeft =[UIButton buttonWithType:UIButtonTypeSystem];

    }
    return _btnLeft;
}
-(UIView *)vBg{
    if (!_vBg) {
        _vBg = [[UIView alloc] initWithFrame:self.contentView.bounds];
        _vBg.width = self.ivArrow.left;
        _vBg.backgroundColor = [UIColor whiteColor];
    }
    return _vBg;
}
-(UIView *)vBgDown{
    if (!_vBgDown) {
        _vBgDown = [[UIView alloc] initWithFrame:self.contentView.bounds];
        _vBgDown.width = self.ivArrow.left;
        _vBgDown.backgroundColor = [UIColor whiteColor];
    }
    return _vBg;
}
@end
