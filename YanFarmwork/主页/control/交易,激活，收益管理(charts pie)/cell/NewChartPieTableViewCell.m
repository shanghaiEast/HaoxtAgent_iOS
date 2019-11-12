//
//  NewChartPieTableViewCell.m
//  YanFarmwork
//
//  Created by HG on 2019/11/5.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "NewChartPieTableViewCell.h"

#import "PieView.h"



@interface NewChartPieTableViewCell ()

@property (retain, nonatomic) PieView *pieView;

@end


@implementation NewChartPieTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_rightBtn setTitle:@"趋势图  " forState:UIControlStateNormal];
    [ToolsObject buttonImageRight:_rightBtn];
    [_rightBtn setTintColor:IMPORTANT_BACKGROUND];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self createChart];
    });
    
}

- (void)createChart {
    _pieView = [[[NSBundle mainBundle] loadNibNamed:@"PieView" owner:self options:nil] lastObject];
    [_pieView setFrame:_myChartView.bounds];
    [_pieView createChart];
    [_myChartView addSubview:_pieView];

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (IBAction)rightBtnClicked:(id)sender {
}
@end
