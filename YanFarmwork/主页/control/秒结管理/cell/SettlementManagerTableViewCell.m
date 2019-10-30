//
//  SettlementManagerTableViewCell.m
//  YanFarmwork
//
//  Created by HG on 2019/10/22.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "SettlementManagerTableViewCell.h"

@implementation SettlementManagerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _setBtn.layer.borderWidth = 1.0;
    _setBtn.layer.borderColor = [[UIColor colorWithHexString:@"#CCCCCC"] CGColor];
    _setBtn.layer.masksToBounds = YES;
    
    [_detailBtn setTitleColor:IMPORTANT_BACKGROUND forState:UIControlStateNormal];
    _detailBtn.layer.borderWidth = 1.0;
    _detailBtn.layer.borderColor = [IMPORTANT_BACKGROUND CGColor];
    _detailBtn.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)createCell:(NSDictionary *)dict {
    
    
    
    
    
}

- (IBAction)setBtnClick:(id)sender {
}
- (IBAction)detailBtnClick:(id)sender {
}
@end
