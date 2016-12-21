//
//  CCellHomeHeader.m
//  kugou
//
//  Created by 梁慧聪 on 2016/12/16.
//  Copyright © 2016年 caijinchao. All rights reserved.
//

#import "CCellHomeHeader.h"
#import "UICollectionViewCell+Chuck.h"
#import "CollectController.h"
#import "NSString+SizeFont.h"
@interface CCellHomeHeader()
@property(nonatomic,strong) UIView * vLine;
@property(nonatomic,strong) UIButton * btnRight;
@property(nonatomic,strong) UILabel * lbPrograma;
@end
@implementation CCellHomeHeader
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.vLine];
        [self.contentView addSubview:self.btnRight];
        [self.contentView addSubview:self.lbPrograma];
    }
    return self;
}
-(void)collectionView:(ChuckCollectionView *)collectionView vcDelegate:(CollectController *)vcDelegate cellForRowWithModel:(id)model atIndexPath:(NSIndexPath *)indexPath{



}


-(UIView *)vLine{
    if (!_vLine) {
        _vLine = [[UIView alloc] init];
        _vLine.backgroundColor = UIColorFromRGB(0xee6f93);
        _vLine.size = CGSizeMake(PxToPt(5), PxToPt(36));
    }
    _vLine.centerY = self.contentView.centerY;
    return _vLine;
}
-(UIButton *)btnRight{
    if (!_btnRight) {
        NSString * titile = @"节目单";

        _btnRight = [[UIButton alloc] init];
        _btnRight.size = CGSizeMake(PxToPt(166), PxToPt(50));

        _btnRight.layer.borderWidth = 1;
        _btnRight.layer.cornerRadius = 4;
        _btnRight.layer.masksToBounds = YES;




        _btnRight.titleLabel.font = [UIFont systemFontOfSize:12.f];
        _btnRight.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_btnRight setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];

        [_btnRight setTitle:titile forState:UIControlStateNormal];




    }
    _btnRight.left = self.width - _btnRight.width;
    _btnRight.centerY = self.contentView.centerY;
    return _btnRight;
}

-(UILabel *)lbPrograma{
    if (!_lbPrograma) {
        _lbPrograma = [UILabel new];
        _lbPrograma.font = [UIFont systemFontOfSize:PxToPt(32)];
    }
    _lbPrograma.left = self.vLine.right + PxToPt(20);
    _lbPrograma.size = CGSizeMake(self.btnRight.left - _lbPrograma.left, PxToPt(32));
    _lbPrograma.centerY = self.contentView.centerY;
    return _lbPrograma;
}
@end
