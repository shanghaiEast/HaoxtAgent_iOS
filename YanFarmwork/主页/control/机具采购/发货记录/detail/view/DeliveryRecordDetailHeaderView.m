//
//  DeliveryRecordDetailHeaderView.m
//  YanFarmwork
//
//  Created by HG on 2019/10/28.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "DeliveryRecordDetailHeaderView.h"

@implementation DeliveryRecordDetailHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)showShadow:(UIView *)showView{
    showView.layer.cornerRadius = 5;
    showView.clipsToBounds = YES;
    
    CALayer *shadowLayer0 = [[CALayer alloc] init];
    shadowLayer0.shadowColor = [UIColor blackColor].CGColor;
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

- (void)createView {
    
    [self showShadow:_shadowView];
}
    
@end
