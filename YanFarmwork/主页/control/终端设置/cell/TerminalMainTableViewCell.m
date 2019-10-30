//
//  TerminalMainTableViewCell.m
//  YanFarmwork
//
//  Created by HG on 2019/10/22.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "TerminalMainTableViewCell.h"


#import "MachineUnbundViewController.h"
#import "MachineSearchViewController.h"
#import "TerminalTransferViewController.h"
#import "InventoryManagementMainViewController.h"


@implementation TerminalMainTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [ToolsObject buttonImageRight:_detailButton];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


//第一行
- (IBAction)machinesSearchBtn:(id)sender {
    NSLog(@"机具查询");
    MachineSearchViewController *VC = [[MachineSearchViewController alloc] initWithNibName:@"MachineSearchViewController" bundle:nil];
    VC.hidesBottomBarWhenPushed = YES;
    [_rootVC.navigationController pushViewController:VC animated:YES];
}

- (IBAction)machinesUnBing:(id)sender {
    NSLog(@"机具解绑");
    MachineUnbundViewController *VC = [[MachineUnbundViewController alloc] initWithNibName:@"MachineUnbundViewController" bundle:nil];
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
