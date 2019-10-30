//
//  DeliveryRecordTableViewCell.m
//  YanFarmwork
//
//  Created by HG on 2019/10/28.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "DeliveryRecordTableViewCell.h"

@implementation DeliveryRecordTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _detailBtn.layer.cornerRadius = 13.0f;
    _detailBtn.layer.borderWidth = 1.0;
    _detailBtn.layer.borderColor = [IMPORTANT_BACKGROUND CGColor];
    _detailBtn.layer.masksToBounds = YES;
    
    _confirmBtn.layer.cornerRadius = 13.0f;
    _confirmBtn.layer.borderWidth = 1.0;
    _confirmBtn.layer.borderColor = [WEAKER_TEXT_LEVEL_1 CGColor];
    _confirmBtn.layer.masksToBounds = YES;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)confirmAndDetailBtnVlicked:(id)sender {
    UIButton *button = (id)sender;
    if (button.tag == 0) {
        NSLog(@"确认收货");
    }
    if (button.tag == 1) {
        NSLog(@"查看详情");
    }
    
    
    
    
    
}
@end
