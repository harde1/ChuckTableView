//
//  CCellTitleShare.m
//  ChuckTableView
//
//  Created by 梁慧聪 on 2017/1/5.
//  Copyright © 2017年 liangdianxiong. All rights reserved.
//

#import "CCellTitleShare.h"
#import "UtilScreenSize.h"
#import "CsFrame.h"
@interface CCellTitleShare()
@property (nonatomic, strong) UILabel *lbTitle;
@property (nonatomic, strong) UILabel *lbPeople;
@property (nonatomic, strong) UIButton *btnShare;
@property (nonatomic, strong) UIButton *btnFull;
@end
@implementation CCellTitleShare

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.lbTitle];
        [self.contentView addSubview:self.lbPeople];
        [self.contentView addSubview:self.btnShare];
        [self.contentView addSubview:self.btnFull];
        [self resetFrame];
    }
    return self;
}

- (void)resetFrame {
    
   self.lbTitle.cslayout
    .leftSpaceEqual(PxToPt(30))
    .centerYEqual(self.contentView.centerY-self.lbTitle.height/2);
    
//    self.lbTitle.left = PxToPt(30);
//    [self.lbTitle sizeToFit];
//    self.lbTitle.centerY = self.contentView.centerY - self.lbTitle.height/2;
    
}

-(UILabel *)lbTitle{
    if (!_lbTitle) {
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.font = [UIFont systemFontOfSize:PxToPt(32)];
        _lbTitle.textColor = UIColorFromRGB(0x333333);
        _lbTitle.text = @"国美酷狗：湘江音乐节";
    }
    return _lbTitle;
}
-(UILabel *)lbPeople{
    if (!_lbPeople) {
        _lbPeople = [[UILabel alloc] init];
    }
    return _lbPeople;
}
-(UIButton *)btnShare{
    if (!_btnShare) {
        _btnShare = [[UIButton alloc] init];
    }
    return _btnShare;
}
-(UIButton *)btnFull{
    if (!_btnShare) {
        _btnFull = [[UIButton alloc] init];
    }
    return _btnFull;
}
@end
