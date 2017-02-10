//
//  CCellDetail.m
//  ChuckTableView
//
//  Created by 梁慧聪 on 2017/1/5.
//  Copyright © 2017年 liangdianxiong. All rights reserved.
//

#import "CCellDetail.h"
#import "UICollectionViewCell+Chuck.h"
#import "UtilScreenSize.h"
//#import "UIView+Metrics.h"
#import "CsFrame.h"
@interface CCellDetail()
@property (nonatomic, strong) UIButton *btnIntroduce;
@end
@implementation CCellDetail
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.ivHead];
        [self.contentView addSubview:self.lbTitle];
        [self.contentView addSubview:self.lbSub];
        [self.contentView addSubview:self.btnSubscript];
        [self.contentView addSubview:self.lbDate];
        
        [self.contentView addSubview:self.lbIntroduce];
        [self.contentView addSubview:self.btnIntroduce];
        [self resetFrame];
    }
    return self;
}
-(void)resetFrame{
    
    self.ivHead.cslayout
    .left.equalTo(PxToPt(30))
    .top.equalTo(PxToPt(30))
    .width.equalTo(PxToPt(80))
    .height.equalTo(PxToPt(80)).end();
    
    self.lbTitle.cslayout
    .left.equalTo(self.ivHead.right).offset(PxToPt(15))
    .centerY.equalTo(self.ivHead.centerY).offset(-self.ivHead.height/4)
    .width.equalTo(self.width-self.ivHead.right).end();
    
    self.lbSub.cslayout
    .left.equalTo(self.ivHead.right).offset(PxToPt(15))
    .centerY.equalTo(self.ivHead.centerY).offset(self.ivHead.height/4)
    .width.equalTo(self.width-self.ivHead.right).end();
    
    self.btnSubscript.cslayout
    .top.equalTo(PxToPt(40))
    .right.equalTo(self.width-PxToPt(30))
    .width.equalTo(PxToPt(120))
    .height.equalTo(PxToPt(60)).end();
    
    self.lbDate.cslayout
    .topSpaceEqual(self.ivHead.bottom).offset(PxToPt(20))
    .leftSpaceEqual(PxToPt(30))
    .widthEqual(self.width - 2 * PxToPt(30)).end();
    
    self.btnIntroduce.cslayout
    .topSpaceEqual(self.btnSubscript.bottom).offset(PxToPt(30))
    .rightSpaceEqual(self.width-PxToPt(30))
    .widthEqual(PxToPt(60))
    .heightEqual(PxToPt(30))
    .end();
    
    self.lbIntroduce.cslayout
    .top.equalTo(self.lbDate.bottom).offset(PxToPt(20))
    .left.equalTo(PxToPt(30))
    .width.equalTo(self.width - 2 * PxToPt(30)).end();
    
    [self.lbIntroduce sizeToFit];
    
    [self cellChangeHeight]; 
    
}
-(void)collectionView:(ChuckCollectionView *)collectionView vcDelegate:(id)vcDelegate cellForRowWithModel:(id)model atIndexPath:(NSIndexPath *)indexPath{
   
}

-(UILabel *)lbTitle{
    if (!_lbTitle) {
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.text = @"hhhh";
    }
    return _lbTitle;
}
-(UILabel *)lbSub{
    if (!_lbSub) {
        _lbSub = [[UILabel alloc] init];
        _lbSub.text = @"hhhh";
    }
    return _lbSub;
}
-(UIImageView *)ivHead{
    if (!_ivHead) {
        _ivHead = [[UIImageView alloc] init];
        _ivHead.backgroundColor = [UIColor grayColor];
    }
    return _ivHead;
}
-(UIButton *)btnSubscript{
    if (!_btnSubscript) {
        _btnSubscript = [UIButton buttonWithType:UIButtonTypeSystem];
        [_btnSubscript setTitle:@"订阅" forState:0];
    }
    return _btnSubscript;
}
-(UIButton *)btnIntroduce{
    if (!_btnIntroduce) {
        _btnIntroduce = [UIButton buttonWithType:UIButtonTypeSystem];
        [_btnIntroduce setTitle:@"下拉" forState:0];
        _btnIntroduce.backgroundColor = [UIColor redColor];
        [_btnIntroduce addTarget:self action:@selector(clickBtnIntroduce:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnIntroduce;
}
-(UILabel *)lbDate{
    if (!_lbDate) {
        _lbDate = [[UILabel alloc] init];
        _lbDate.text = @"hhhh";
    }
    return _lbDate;
}
-(UILabel *)lbIntroduce{
    if (!_lbIntroduce) {
        _lbIntroduce = [[UILabel alloc] init];
        _lbIntroduce.text = @"fdhaksjfhkjdslfdhaksjfhkjdslhfljkdahsfjhdsakjfdhaksjfhkjdslhfljkdahsfjhdsakjfdhaksjfhkjdslhfljkdahsfjhdsakjfdhaksjfhkjdslhfljkdahsfjhdsakjhfljkdahsfjhdsakj";
        _lbIntroduce.numberOfLines = 0;
    }
    return _lbIntroduce;
}

- (void)clickBtnIntroduce:(id)sender {
    BOOL isHidden = self.lbIntroduce.hidden;
    [self cellChangeHeight];
    self.lbIntroduce.hidden = !isHidden;
    [self.chuckCollectionView reloadData];
}

-(void)cellChangeHeight{
    BOOL isHidden = self.lbIntroduce.hidden;
    ChuckModel * chuckmodel = self.chuckModel;
    if (isHidden) {
        chuckmodel.cellHeight = self.lbIntroduce.bottom + PxToPt(30);
    }else{
        chuckmodel.cellHeight = self.lbDate.bottom;
    }
}

@end
