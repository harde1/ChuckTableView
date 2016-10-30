//
//  SmartCell.m
//  ChuckTableView
//
//  Created by cong on 2016/10/28.
//  Copyright © 2016年 liangdianxiong. All rights reserved.
//

#import "SmartCell.h"

@implementation SmartCell

-(void)tableView:(SmartTableView *)tableView vcDelegate:(id)vcDelegate cellForRowWithModel:(id)model atIndexPath:(NSIndexPath *)indexPath{
    SmartModel * smartModel = [tableView smartModelAtIndexPath:indexPath];
    self.detailTextLabel.text =  [NSString stringWithFormat:@"s:%ld,r:%ld,%@",smartModel.indexPath.section,smartModel.indexPath.row,model];
    self.textLabel.text =  [NSString stringWithFormat:@"s:%ld,r:%ld,%@",smartModel.indexPath.section,smartModel.indexPath.row,model];
    self.backgroundColor = [UIColor yellowColor];
}
-(CGFloat)tableView:(SmartTableView *)tableView vcDelegate:(id)vcDelegate heightForRowWithModel:(id)model atIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(void)tableView:(SmartTableView *)tableView vcDelegate:(id)vcDelegate didSelectRowWithModel:(id)model atIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击到：%@",model);

}

-(void)tableView:(SmartTableView *)tableView vcDelegate:(id)vcDelegate commitEditingWithModel:(id)model style:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"---编辑模式---");
    [tableView removeIndexPath:indexPath animation:UITableViewRowAnimationLeft];
    
}
@end
