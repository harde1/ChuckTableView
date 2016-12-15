//
//  WaterLayout.h
//  ChuckTableView
//
//  Created by 梁慧聪 on 2016/12/12.
//  Copyright © 2016年 liangdianxiong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChuckLayout : UICollectionViewLayout
-(instancetype)initItemSize:(CGSize (^)(id model,NSInteger section))itemSize
  interitemSpacingIndexPath:(CGFloat (^)(id model,NSInteger section))interitemSpacing
       lineSpacingIndexPath:(CGFloat (^)(id model,NSInteger section))lineSpacing
      contentInsetIndexPath:(UIEdgeInsets (^)(id model,NSInteger section))contentInset;
-(void)setItemSizeSection:(CGSize (^)(id model,NSInteger section))itemSize;
-(void)setInteritemSpacingIndexPath:(CGFloat (^)(id model,NSInteger section))interitemSpacing;
-(void)setLineSpacingIndexPath:(CGFloat (^)(id model,NSInteger section))lineSpacing;
-(void)setContentInsetIndexPath:(UIEdgeInsets (^)(id model,NSInteger section))contentInset;
@end
