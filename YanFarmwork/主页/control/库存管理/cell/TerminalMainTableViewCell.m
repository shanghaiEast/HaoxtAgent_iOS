//
//  TerminalMainTableViewCell.m
//  YanFarmwork
//
//  Created by HG on 2019/10/22.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "TerminalMainTableViewCell.h"


#import "MachineBundUnbundViewController.h"
#import "MachineSearchViewController.h"
#import "TerminalTransferViewController.h"
#import "InventoryManagementMainViewController.h"
#import "MallMainViewController.h"


@implementation TerminalMainTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [ToolsObject buttonImageRight:_detailButton];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [ToolsObject showShadow:_HListView];
    });
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


//第一行
- (IBAction)machinesSearchBtn:(id)sender {
    NSLog(@"库存查询");
    
    MachineBundUnbundViewController *VC = [[MachineBundUnbundViewController alloc] initWithNibName:@"MachineBundUnbundViewController" bundle:nil];
    VC.hidesBottomBarWhenPushed = YES;
    [_rootVC.navigationController pushViewController:VC animated:YES];

    
//    MachineSearchViewController *VC = [[MachineSearchViewController alloc] initWithNibName:@"MachineSearchViewController" bundle:nil];
//    VC.hidesBottomBarWhenPushed = YES;
//    [_rootVC.navigationController pushViewController:VC animated:YES];
}

- (IBAction)machinesUnBing:(id)sender {
    NSLog(@"机具解绑");
    MallMainViewController *VC = [[MallMainViewController alloc] initWithNibName:@"MallMainViewController" bundle:nil];
    VC.hidesBottomBarWhenPushed = YES;
    [_rootVC.navigationController pushViewController:VC animated:YES];
}



- (IBAction)terminalBtn:(id)sender {
    UIButton *button = (id)sender;
    NSLog(@"终端设置:%ld",button.tag);
    
    TerminalTransferViewController *VC = [[TerminalTransferViewController alloc] initWithNibName:@"TerminalTransferViewController" bundle:nil];
    if (button.tag == 0) {
        VC.terminalType = terminal_huabo;
    }else if (button.tag == 1) {
        VC.terminalType = terminal_huidiao;
    }else if (button.tag == 2) {
        VC.terminalType = terminal_qianyi;
    }
    VC.hidesBottomBarWhenPushed = YES;
    [_rootVC.navigationController pushViewController:VC animated:YES];
    
    
    
}

- (IBAction)detailBtn:(id)sender {
    NSLog(@"查看详情");
    InventoryManagementMainViewController *VC = [[InventoryManagementMainViewController alloc] initWithNibName:@"InventoryManagementMainViewController" bundle:nil];
    VC.hidesBottomBarWhenPushed = YES;
    [_rootVC.navigationController pushViewController:VC animated:YES];
}
@end
