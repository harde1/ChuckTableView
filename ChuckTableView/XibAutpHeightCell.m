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
-(void)tableView:(SmartTableView *)tableView vcDelegate:(id)vcDelegate cellForRowWithModel:(id)model atIndexPath:(NSIndexPath *)indexPath{
    SmartModel * smartModel = [tableView smartModelAtIndexPath:indexPath];
    self.lbText.text = [NSString stringWithFormat:@"s:%ld,r:%ld,%@",smartModel.indexPath.section,smartModel.indexPath.row,model];;

}
-(void)tableView:(SmartTableView *)tableView vcDelegate:(id)vcDelegate commitEditingWithModel:(id)model style:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"---编辑模式---");
    [tableView removeIndexPath:indexPath animation:UITableViewRowAnimationLeft];
    
}
@end
