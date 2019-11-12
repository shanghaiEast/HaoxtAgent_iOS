//
//  TeamManagementTableViewCell.m
//  YanFarmwork
//
//  Created by HG on 2019/11/6.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "TeamManagementTableViewCell.h"





@implementation TeamManagementTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
   
    _lineView = [[[NSBundle mainBundle] loadNibNamed:@"LineView" owner:self options:nil] lastObject];
    [_lineView setFrame:_myChartView.bounds];
    [_lineView createChart];
    [_myChartView addSubview:_lineView];

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
