//
//  TerminalTransferDetailHeaderView.m
//  YanFarmwork
//
//  Created by HG on 2019/10/23.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "TerminalTransferDetailHeaderView.h"

#import "BatchDetailsView.h"



@interface TerminalTransferDetailHeaderView ()

@property (retain, nonatomic) BatchDetailsView *detailView;

@end

@implementation TerminalTransferDetailHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)createSectionOneView:(NSDictionary *)dict{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self gradientColor:_colorImageView startColor:@"#F27A0F" endColor:@"#F0390D"];
        [self showShadow:_bottomView];
    });
    
  
    
    
    
    if (dict.count != 0) {
        
    }
}

- (void)createSectionTwoView:(NSDictionary *)dict {
    
    
    int numCount = 10;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self showShadow:_footerView];
        
        for (int i = 0; i < numCount; i++) {
            UILabel *listLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40*i, ScreenWidth, 40)];
            listLabel.font = [UIFont systemFontOfSize:14];
            listLabel.textColor = NORMAL_TEXT_LEVEL_1;
            listLabel.text = @"批次一:8473847384793-238473";
            [_listView addSubview:listLabel];
        }
        
        
    });
    
    
    
}



- (IBAction)backBtnClicked:(id)sender {
     [_rootVC.navigationController popViewControllerAnimated:YES];
    
    [_rootVC.navigationController setNavigationBarHidden:NO animated:NO];
    
}

- (IBAction)moreBtnClicked:(id)sender {
    NSLog(@"查看更多批次 ");
    
    AppDelegate *app =(AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    _detailView = [[[NSBundle mainBundle] loadNibNamed:@"BatchDetailsView" owner:self options:nil] lastObject];
    [_detailView setFrame:app.window.bounds];
    [_detailView.whiteView setFrame:CGRectMake(40, (ScreenHeight-(ScreenWidth-80)*1.5)/2, ScreenWidth-80, (ScreenWidth-80)*1.5)];
    [_detailView createView:[NSDictionary new]];
    [app.window addSubview:_detailView];
}



- (void)gradientColor:(UIView *)view startColor:(NSString *)startColor endColor:(NSString *)endColor {
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = view.bounds;
    gradient.colors = @[(id)[UIColor colorWithHexString:startColor].CGColor,(id)[UIColor  colorWithHexString:endColor].CGColor];
    gradient.startPoint = CGPointMake(0, 0.5);//0，0）为左上角、（1，0）为右上角、（0，1）为左下角、（1，1）为右下角，默认是值是（0.5，0）和（0.5，1）
    gradient.endPoint = CGPointMake(1, 0.5);
    //        gradient.locations = @[@(0.5f), @(1.0f)];//控制渐变发生的位置
    [view.layer addSublayer:gradient];
}


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

@end
