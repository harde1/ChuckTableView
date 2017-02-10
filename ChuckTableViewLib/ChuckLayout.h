//
//  WaterLayout.h
//  ChuckTableView
//
//  Created by 梁慧聪 on 2016/12/12.
//  Copyright © 2016年 liangdianxiong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ChuckModel;
@interface ChuckLayout : UICollectionViewLayout
-(instancetype)initItemSize:(CGSize (^)(id model,ChuckModel * chuckModel,NSInteger section))itemSize
  interitemSpacingIndexPath:(CGFloat (^)(id model,ChuckModel * chuckModel,NSInteger section))interitemSpacing
       lineSpacingIndexPath:(CGFloat (^)(id model,ChuckModel * chuckModel,NSInteger section))lineSpacing
      contentInsetIndexPath:(UIEdgeInsets (^)(NSInteger section))contentInset;

//不同setion的itemSize大小
-(void)setItemSizeSection:(CGSize (^)(id model,ChuckModel * chuckModel,NSInteger section))itemSize;
//不同setion的cell与cell之间的距离
-(void)setInteritemSpacingIndexPath:(CGFloat (^)(id model,ChuckModel * chuckModel,NSInteger section))interitemSpacing;
//不同setion的行与行之间的距离
-(void)setLineSpacingIndexPath:(CGFloat (^)(id model,ChuckModel * chuckModel,NSInteger section))lineSpacing;
//每个section的内嵌
-(void)setContentInsetIndexPath:(UIEdgeInsets (^)(NSInteger section))contentInset;
-(void)reload;
@end
