//
//  UICollectionViewCell+Chuck.h
//  ChuckTableView
//
//  Created by 梁慧聪 on 2016/11/30.
//  Copyright © 2016年 liangdianxiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChuckCellConfigure.h"
@interface UICollectionViewCell (Chuck)<ChuckCellConfigure>
@property(nonatomic,weak)ChuckModel * chuckModel;
@property(nonatomic,weak)ChuckCollectionView * chuckCollectionView;
@property(nonatomic,weak)id<ChuckDelegate> chuckDelegate;
@end
