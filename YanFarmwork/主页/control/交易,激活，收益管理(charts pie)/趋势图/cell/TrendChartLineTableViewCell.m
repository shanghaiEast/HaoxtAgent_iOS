//
//  TrendChartLineTableViewCell.m
//  YanFarmwork
//
//  Created by HG on 2019/11/6.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "TrendChartLineTableViewCell.h"





@implementation TrendChartLineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _leftBtn.layer.borderWidth = 1.0;
    _leftBtn.layer.borderColor = [IMPORTANT_BACKGROUND CGColor];
    _leftBtn.layer.masksToBounds = YES;
    
    typeof(self)wSelf = self;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
        _lineView = [[[NSBundle mainBundle] loadNibNamed:@"LineView" owner:self options:nil] lastObject];
        [_lineView setFrame:_myChartView.bounds];
        [_lineView createChart];
        [_myChartView addSubview:_lineView];

//    });
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)buttonSelected:(id)sender {
    UIButton *button = (id)sender;
    button.selected = !button.selected;
    
    if (button == _leftBtn) {
        _rightBtn.selected = !_leftBtn.selected;
        
        if (button.selected == YES) {
            _leftBtn.layer.borderWidth = 1.0;
            _leftBtn.layer.borderColor = [IMPORTANT_BACKGROUND CGColor];
            _leftBtn.backgroundColor = [UIColor colorWithHexString:@"#FEF8F8"];
           
            _rightBtn.layer.borderWidth = 0.0;
             _rightBtn.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
        }else{
            _leftBtn.layer.borderWidth = 0.0;
            _leftBtn.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
        }
         _leftBtn.layer.masksToBounds = YES;
        
    }
    
    if (button == _rightBtn) {
        _leftBtn.selected = !_rightBtn.selected;
        
        if (button.selected == YES) {
            _rightBtn.layer.borderWidth = 1.0;
            _rightBtn.layer.borderColor = [IMPORTANT_BACKGROUND CGColor];
            _rightBtn.backgroundColor = [UIColor colorWithHexString:@"#FEF8F8"];
            
            _leftBtn.layer.borderWidth = 0.0;
            _leftBtn.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
        }else{
            _rightBtn.layer.borderWidth = 0.0;
            _rightBtn.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
        }
        _rightBtn.layer.masksToBounds = YES;
    }
    
}
@end
