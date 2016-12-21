//
//  CCellHomeCell.m
//  kugou
//
//  Created by 梁慧聪 on 2016/12/16.
//  Copyright © 2016年 caijinchao. All rights reserved.
//

#import "CCellHomeCell.h"
#import "UtilScreenSize.h"
#import "CollectController.h"
@interface CCellHomeCell()
@property(nonatomic,strong)UIImageView * ivContent;
@property(nonatomic,strong)UIImageView * ivPrograma;
@property (nonatomic, strong) UIView * bgView;
@property(nonatomic,strong)UILabel * lbTitle;
@property(nonatomic,strong)UILabel * lbSinger;
@property(nonatomic,strong)UILabel * lbAudienceNum;
@end
@implementation CCellHomeCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        [self initView];
    }
    return self;
}
-(void)initView{
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.ivContent];
    [self.bgView addSubview:self.ivPrograma];

    [self.bgView addSubview:self.lbTitle];
    [self.bgView addSubview:self.lbSinger];
    [self.bgView addSubview:self.lbAudienceNum];

    self.contentView.layer.shadowOffset = CGSizeMake(1, 1);
    self.contentView.layer.shadowOpacity = 0.1;
    self.contentView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.contentView.layer.shadowRadius = 2;
}


- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.frame = self.bounds;

        _bgView.layer.masksToBounds = YES;
        _bgView.layer.cornerRadius = 4;
        _bgView.layer.borderWidth = 0.5;
        

    }
    return _bgView;
}
-(UIImageView *)ivContent{
    if (!_ivContent) {
        _ivContent = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width,self.width * 212.0/339)];
        _ivContent.backgroundColor = [UIColor grayColor];
        
    }
    return _ivContent;
}
-(UIImageView *)ivPrograma{
    if (!_ivPrograma) {
        _ivPrograma = [[UIImageView alloc] init];
        _ivPrograma.size = CGSizeMake(PxToPt(66), PxToPt(30));
        _ivPrograma.left = self.width - _ivPrograma.width;
    }
    return _ivPrograma;
}
-(UILabel *)lbTitle{
    UIEdgeInsets edge = UIEdgeInsetsMake(PxToPt(10), PxToPt(10), PxToPt(10), PxToPt(10));

    if (!_lbTitle) {
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.text = @"------";
        _lbTitle.width = self.width - edge.left - edge.right;
        _lbTitle.height = PxToPt(60);
        _lbTitle.left = edge.left;


    }
    _lbTitle.top = self.ivContent.bottom+edge.top;
    return _lbTitle;
}
-(UILabel *)lbSinger{
    if (!_lbSinger) {
        _lbSinger = [[UILabel alloc] init];
        _lbSinger.text = @"---";
        _lbSinger.size = CGSizeMake(PxToPt(201), PxToPt(20));


    }
    _lbSinger.left = self.lbTitle.left;
    _lbSinger.top = self.lbTitle.bottom+PxToPt(10);

    return _lbSinger;
}
-(UILabel *)lbAudienceNum{
    if (!_lbAudienceNum) {
        _lbAudienceNum = [[UILabel alloc] init];
        _lbAudienceNum.text = @"---";
        _lbAudienceNum.size = CGSizeMake(PxToPt(108), PxToPt(20));
        _lbAudienceNum.textAlignment = NSTextAlignmentRight;
    }
    _lbAudienceNum.top = self.lbSinger.top;
    _lbAudienceNum.left = self.lbSinger.right;
    return _lbAudienceNum;
}
@end
