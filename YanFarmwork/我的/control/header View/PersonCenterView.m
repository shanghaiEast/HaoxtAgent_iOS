//
//  PersonCenterView.m
//  YanFarmwork
//
//  Created by HG on 2019/9/4.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "PersonCenterView.h"

#import "SetAppViewController.h"
#import "ReturnsDetailedViewController.h"
#import "TCreditCardCerTableViewController.h"
#import "AddressManagementViewController.h"
#import "MyPolicyViewController.h"
#import "MyInfoViewController.h"


@implementation PersonCenterView

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
    
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.toListBtn.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerTopLeft cornerRadii:CGSizeMake(13.0, 13.0)];
//    CAShapeLayer *maskLayer = [CAShapeLayer layer];
//    maskLayer.frame = self.toListBtn.bounds;
//    maskLayer.path = maskPath.CGPath;
//    self.toListBtn.layer.mask = maskLayer;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [self showShadow:_bgView];
//        [self showShadow:_renZhenView];
    });
    
   
  
}

//跳转个人资料
- (IBAction)personDetailBtnClicked:(id)sender {
     NSLog(@"跳转个人资料");
    MyInfoViewController *VC = [[MyInfoViewController alloc] initWithNibName:@"MyInfoViewController" bundle:nil];
    VC.hidesBottomBarWhenPushed = YES;
    [_rootVC.navigationController pushViewController:VC animated:YES];
}

- (IBAction)listBtnClicked:(id)sender {
    UIButton *button = (id)sender;
    if (button.tag == 0) {
        NSLog(@"我的银行卡");
        //银行卡
        TCreditCardCerTableViewController *cardVC = [[TCreditCardCerTableViewController alloc] initWithNibName:@"TCreditCardCerTableViewController" bundle:nil];
        cardVC.hidesBottomBarWhenPushed = YES;
        [_rootVC.navigationController pushViewController:cardVC animated:YES];
    }
    if (button.tag == 1) {
        NSLog(@"地址管理");
        AddressManagementViewController *cardVC = [[AddressManagementViewController alloc] initWithNibName:@"AddressManagementViewController" bundle:nil];
        cardVC.hidesBottomBarWhenPushed = YES;
        [_rootVC.navigationController pushViewController:cardVC animated:YES];
    }
    if (button.tag == 2) {
        NSLog(@"我的政策");
        MyPolicyViewController *cardVC = [[MyPolicyViewController alloc] initWithNibName:@"MyPolicyViewController" bundle:nil];
        cardVC.hidesBottomBarWhenPushed = YES;
        [_rootVC.navigationController pushViewController:cardVC animated:YES];
    }
    
}
@end
