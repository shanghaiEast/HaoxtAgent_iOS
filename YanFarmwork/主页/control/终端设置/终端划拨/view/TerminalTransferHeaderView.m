//
//  TerminalTransferHeaderView.m
//  YanFarmwork
//
//  Created by HG on 2019/10/22.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "TerminalTransferHeaderView.h"

#import "TerminalTransferListViewController.h"

@implementation TerminalTransferHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



- (void)createView {
    [ToolsObject buttonImageRight:_addSaleMan];
}

- (IBAction)addBatchBtnClick:(id)sender {
    if (_addBatchBlock) {
        _addBatchBlock(YES);
    }
}

- (IBAction)addSalemanClick:(id)sender {
     NSLog(@"添加业务员");
}

- (IBAction)backBtnClicked:(id)sender {
    [_rootVC.navigationController popViewControllerAnimated:YES];
   
    [self showNavigation];
}

- (IBAction)detailListBtnClick:(id)sender {
    NSLog(@"划拨明细");
    TerminalTransferListViewController *VC = [[TerminalTransferListViewController alloc] initWithNibName:@"TerminalTransferListViewController" bundle:nil];
    VC.hidesBottomBarWhenPushed = YES;
    [_rootVC.navigationController pushViewController:VC animated:YES];
    
     [self showNavigation];
}

- (void)showNavigation{
     [_rootVC.navigationController setNavigationBarHidden:NO animated:NO];
}

@end
