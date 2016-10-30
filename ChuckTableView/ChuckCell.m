//
//  ChuckCell.m
//  ChuckTableView
//
//  Created by cong on 2016/10/28.
//  Copyright © 2016年 liangdianxiong. All rights reserved.
//

#import "ChuckCell.h"

@implementation ChuckCell

-(void)tableView:(ChuckTableView *)tableView vcDelegate:(id)vcDelegate cellForRowWithModel:(id)model atIndexPath:(NSIndexPath *)indexPath{
    ChuckModel * chuckModel = [tableView chuckModelAtIndexPath:indexPath];
    self.detailTextLabel.text =  [NSString stringWithFormat:@"s:%ld,r:%ld,%@",chuckModel.indexPath.section,chuckModel.indexPath.row,model];
    self.textLabel.text =  [NSString stringWithFormat:@"s:%ld,r:%ld,%@",chuckModel.indexPath.section,chuckModel.indexPath.row,model];
    self.backgroundColor = [UIColor yellowColor];
}
-(CGFloat)tableView:(ChuckTableView *)tableView vcDelegate:(id)vcDelegate heightForRowWithModel:(id)model atIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(void)tableView:(ChuckTableView *)tableView vcDelegate:(id)vcDelegate didSelectRowWithModel:(id)model atIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击到：%@",model);

}

-(void)tableView:(ChuckTableView *)tableView vcDelegate:(id)vcDelegate commitEditingWithModel:(id)model style:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"---编辑模式---");
    [tableView removeIndexPath:indexPath animation:UITableViewRowAnimationLeft];
    
}
@end
