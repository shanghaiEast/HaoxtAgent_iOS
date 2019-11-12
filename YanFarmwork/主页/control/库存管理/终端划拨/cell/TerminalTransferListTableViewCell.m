//
//  TerminalTransferListTableViewCell.m
//  YanFarmwork
//
//  Created by HG on 2019/10/23.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "TerminalTransferListTableViewCell.h"

#import "TerminalTransferDetailViewController.h"

@implementation TerminalTransferListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _detailBtn.layer.borderWidth = 1.0f;
    _detailBtn.layer.borderColor = [IMPORTANT_BACKGROUND CGColor];
    _detailBtn.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)createView:(NSDictionary *)dict {
    _detailDict = dict;
    
    _successCountLabel.text = @"232343400";
}

- (IBAction)detailBtnClicked:(id)sender {
    TerminalTransferDetailViewController *VC = [[TerminalTransferDetailViewController alloc] initWithNibName:@"TerminalTransferDetailViewController" bundle:nil];
    VC.detailDict = [NSDictionary new];
    VC.hidesBottomBarWhenPushed = YES;
    [_root.navigationController pushViewController:VC animated:YES];
    
}
@end
