//
//  ReturnsDetailedHeaderView.m
//  YanFarmwork
//
//  Created by HG on 2019/10/30.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "ReturnsDetailedHeaderView.h"

#import "WithdrawalViewController.h"

@implementation ReturnsDetailedHeaderView

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

- (void)showBezierPath:(UIView *)showView {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:showView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(30.0, 30.0)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = showView.bounds;
    maskLayer.path = maskPath.CGPath;
    showView.layer.mask = maskLayer;
}

- (void)createView {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self showBezierPath:_bgView];
        [self showShadow:_whiteView];
    });

    self.bgView.backgroundColor = IMPORTANT_BACKGROUND;
    
    
    
    
}

- (IBAction)moneyBtnClied:(id)sender {
    
    WithdrawalViewController *VC = [[WithdrawalViewController alloc] initWithNibName:@"WithdrawalViewController" bundle:nil];
    VC.hidesBottomBarWhenPushed = YES;
    [_rootVC.navigationController pushViewController:VC animated:YES];
}
@end
