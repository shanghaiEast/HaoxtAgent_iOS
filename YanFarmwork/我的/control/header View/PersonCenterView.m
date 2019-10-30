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


@implementation PersonCenterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)createView {
    
//    [_bgView setFrame:CGRectMake(0, 0, ScreenWidth, 270)];
//    [ToolsObject gradientColor:_bgView startColor:@"#EF5F48" endColor:@"#FE4049"];
    

//    if ([[myData USR_OPR_NM] length] == 0) {
//        _nameAndPhoneLabel.text = [NSString stringWithFormat:@"%@",[myData USR_LOGIN_MBL]];
//    }else{
//        _nameAndPhoneLabel.text = [NSString stringWithFormat:@"%@  %@",[myData USR_OPR_NM],[myData USR_LOGIN_MBL]];
//    }
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.toListBtn.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerTopLeft cornerRadii:CGSizeMake(13.0, 13.0)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.toListBtn.bounds;
    maskLayer.path = maskPath.CGPath;
    self.toListBtn.layer.mask = maskLayer;
   
    
    UITapGestureRecognizer *headTouch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(puchToUserMessage)];
    [_headImageView addGestureRecognizer:headTouch];

    UITapGestureRecognizer *nameAndPhoneTouch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(puchToUserMessage)];
    [_nameAndPhoneLabel addGestureRecognizer:nameAndPhoneTouch];
  
}

//收益明细
- (IBAction)setBtnClick:(id)sender {
    NSLog(@"收益明细");
    
    ReturnsDetailedViewController *VC = [[ReturnsDetailedViewController alloc] initWithNibName:@"ReturnsDetailedViewController" bundle:nil];
    VC.hidesBottomBarWhenPushed = YES;
    [_rootVC.navigationController pushViewController:VC animated:YES];
}

//跳转个人资料
- (void)puchToUserMessage{
    NSLog(@"跳转个人资料");
    
   
}
@end
