//
//  ChuckCRView.m
//  ChuckTableView
//
//  Created by 梁慧聪 on 2016/12/12.
//  Copyright © 2016年 liangdianxiong. All rights reserved.
//

#import "ChuckCRView.h"

@implementation ChuckCRView
- (void)collectionView:(ChuckCollectionView *)collectionView vcDelegate:(id)vcDelegate model:(id)model viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    self.backgroundColor = [UIColor grayColor];
}
@end
