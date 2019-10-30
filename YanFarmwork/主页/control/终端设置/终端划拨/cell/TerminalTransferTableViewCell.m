//
//  TerminalTransferTableViewCell.m
//  YanFarmwork
//
//  Created by HG on 2019/10/22.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "TerminalTransferTableViewCell.h"

@implementation TerminalTransferTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)delectOrAddbtnClicked:(id)sender {
    NSLog(@"删除或添加");
}
- (IBAction)reductBtnClicked:(id)sender {
    NSLog(@"减");
    
    if (_numberLabelChangeBlock) {
        int numCount = [_numberLabel.text intValue];
        numCount --;
        
        _numberLabelChangeBlock(numCount);
        
    }
}
- (IBAction)addBtnClicked:(id)sender {
    NSLog(@"加");
    
    if (_numberLabelChangeBlock) {
        int numCount = [_numberLabel.text intValue];
        numCount ++;
        
        _numberLabelChangeBlock(numCount);
        
    }
}

- (IBAction)scanBtnClicked:(id)sender {
    NSLog(@"扫描：0-起始");
    UIButton *button = (id)sender;
    if (button.tag == 0) {
        
    }else{
        
    }
}
@end
