//
//  DeliveryRecordDetailDetailTableViewCell.m
//  YanFarmwork
//
//  Created by HG on 2019/10/28.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "DeliveryRecordDetailDetailTableViewCell.h"

@implementation DeliveryRecordDetailDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self showShadow:_bgView];
    });
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)showShadow:(UIView *)showView{
    showView.layer.cornerRadius = 5;
    showView.clipsToBounds = YES;
    
    CALayer *shadowLayer0 = [[CALayer alloc] init];
    shadowLayer0.shadowColor = [UIColor lightGrayColor].CGColor;
    shadowLayer0.shadowOpacity = 0.3;//alpha
    shadowLayer0.shadowOffset = CGSizeMake(0, 0);
    shadowLayer0.shadowRadius = 5;
    CGFloat shadowSize0 = 0;
    CGRect shadowSpreadRect0 = CGRectMake(-shadowSize0, -shadowSize0, showView.bounds.size.width+shadowSize0*2, showView.bounds.size.height+shadowSize0*2);
    CGFloat shadowSpreadRadius0 =  showView.layer.cornerRadius == 0 ? 0 : showView.layer.cornerRadius+shadowSize0;
    UIBezierPath *shadowPath0 = [UIBezierPath bezierPathWithRoundedRect:shadowSpreadRect0 cornerRadius:shadowSpreadRadius0];
    shadowLayer0.shadowPath = shadowPath0.CGPath;
    //重要
    shadowLayer0.frame = showView.frame;
    [showView.superview.layer insertSublayer:shadowLayer0 below:showView.layer];
}

- (IBAction)confirmBtnClick:(id)sender {
    NSLog(@"确认收货");
}

- (IBAction)logisticsBtnClick:(id)sender {
    NSLog(@"收货信息");
}
@end
