//
//  XibAutpHeightCell.m
//  ChuckTableView
//
//  Created by cong on 2016/10/29.
//  Copyright © 2016年 liangdianxiong. All rights reserved.
//

#import "XibAutpHeightCell.h"

@implementation XibAutpHeightCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}
-(void)tableView:(ChuckTableView *)tableView vcDelegate:(id)vcDelegate cellForRowWithModel:(id)model atIndexPath:(NSIndexPath *)indexPath{
    ChuckModel * chuckModel = [tableView chuckModelAtIndexPath:indexPath];
    self.lbText.text = [NSString stringWithFormat:@"  s:%ld,r:%ld,%@",chuckModel.indexPath.section,chuckModel.indexPath.row,model];
}
-(void)tableView:(ChuckTableView *)tableView vcDelegate:(id)vcDelegate didSelectRowWithModel:(id)model atIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击到：%@",model);
}
-(void)tableView:(ChuckTableView *)tableView vcDelegate:(id)vcDelegate commitEditingWithModel:(id)model style:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"---编辑模式---");
    [tableView removeIndexPath:indexPath animation:UITableViewRowAnimationLeft];
    
}
@end
