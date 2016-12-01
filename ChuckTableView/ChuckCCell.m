//
//  ChuckCCell.m
//  ChuckTableView
//
//  Created by 梁慧聪 on 2016/11/30.
//  Copyright © 2016年 liangdianxiong. All rights reserved.
//

#import "ChuckCCell.h"

@implementation ChuckCCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.lbText = [[UILabel alloc]initWithFrame:self.bounds];
//        self.lbText.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.lbText];
    }
    return self;
}
-(void)collectionView:(ChuckCollectionView *)collectionView vcDelegate:(id)vcDelegate cellForRowWithModel:(id)model atIndexPath:(NSIndexPath *)indexPath{
    self.lbText.text = model;
    self.backgroundColor = [UIColor yellowColor];
}
-(void)collectionView:(ChuckCollectionView *)collectionView vcDelegate:(id)vcDelegate didSelectRowWithModel:(id)model atIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了：%@",self);
}
@end
