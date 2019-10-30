//
//  MainTopView.m
//  YanFarmwork
//
//  Created by HG on 2019/10/18.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "MainTopView.h"

#import "PartnersViewController.h"
#import "TradingViewController.h"
#import "SettlementManagerViewController.h"
#import "TerminalMainViewController.h"
#import "MachinesProcurementViewController.h"


@implementation MainTopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)createView {
    NSArray *titleArray = @[@"合作伙伴",@"商户查询",@"终端管理",@"交易管理",@"机具采购",@"秒结管理"];
//    NSArray *imageArray = @[[UIImage imageNamed:@""],[UIImage imageNamed:@""],[UIImage imageNamed:@""],[UIImage imageNamed:@""],[UIImage imageNamed:@""],[UIImage imageNamed:@""]];
    
    int rowNum = 4;//一行显示item
    float height = (320-30)/rowNum;//item高
    float width  = height;//item宽
    float spacing_width = (ScreenWidth-30-width*rowNum)/rowNum;//item间距
    float spacing_height = 15;//item间距
    
    for (int i = 0; i < titleArray.count; i ++) {
        int remainder = i%rowNum;//余数0,1,2,3,
        int integerder = i/rowNum;//整数0,0,0,0,1
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(width*remainder+spacing_width*remainder, height*integerder+spacing_height*integerder, height, width)];
//        button.backgroundColor = [UIColor orangeColor];
        [button addTarget:self action:@selector(buttonClicd:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[titleArray objectAtIndex:i]]] forState:UIControlStateNormal];
        [button setTitle:[titleArray objectAtIndex:i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button setTitleColor:NORMAL_TEXT_LEVEL_1 forState:UIControlStateNormal];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
        [_centerView addSubview:button];
        
        
        [button setTitleEdgeInsets:UIEdgeInsetsMake(button.imageView.frame.size.height+10 , -button.imageView.frame.size.width, 0.0,0.0)];
        [button setImageEdgeInsets:UIEdgeInsetsMake(0.0, 10,button.titleLabel.bounds.size.height+10, -button.titleLabel.bounds.size.width)];
    }
    
    
}

- (void)buttonClicd:(UIButton *)button{
    NSLog(@"buttonName:%@",button.currentTitle);
    
    if ([button.currentTitle isEqualToString:@"合作伙伴"]) {
        PartnersViewController *partnersVC = [[PartnersViewController alloc] initWithNibName:@"PartnersViewController" bundle:nil];
        partnersVC.hidesBottomBarWhenPushed = YES;
        [_rootVC.navigationController pushViewController:partnersVC animated:YES];
    }
    
    if ([button.currentTitle isEqualToString:@"交易管理"]) {
        TradingViewController *partnersVC = [[TradingViewController alloc] initWithNibName:@"TradingViewController" bundle:nil];
        partnersVC.hidesBottomBarWhenPushed = YES;
        [_rootVC.navigationController pushViewController:partnersVC animated:YES];
    }
    
    if ([button.currentTitle isEqualToString:@"秒结管理"]) {
        SettlementManagerViewController *partnersVC = [[SettlementManagerViewController alloc] initWithNibName:@"SettlementManagerViewController" bundle:nil];
        partnersVC.jumpType = AGENT;
        partnersVC.hidesBottomBarWhenPushed = YES;
        [_rootVC.navigationController pushViewController:partnersVC animated:YES];
    }
    
    if ([button.currentTitle isEqualToString:@"终端管理"]) {
        TerminalMainViewController *terminalVC = [[TerminalMainViewController alloc] initWithNibName:@"TerminalMainViewController" bundle:nil];
        terminalVC.hidesBottomBarWhenPushed = YES;
        [_rootVC.navigationController pushViewController:terminalVC animated:YES];
    }
    
    if ([button.currentTitle isEqualToString:@"商户查询"]) {
        SettlementManagerViewController *partnersVC = [[SettlementManagerViewController alloc] initWithNibName:@"SettlementManagerViewController" bundle:nil];
        partnersVC.jumpType = SALEMAN;
        partnersVC.hidesBottomBarWhenPushed = YES;
        [_rootVC.navigationController pushViewController:partnersVC animated:YES];
    }
    
    if ([button.currentTitle isEqualToString:@"机具采购"]) {
        MachinesProcurementViewController *partnersVC = [[MachinesProcurementViewController alloc] initWithNibName:@"MachinesProcurementViewController" bundle:nil];
        partnersVC.hidesBottomBarWhenPushed = YES;
        [_rootVC.navigationController pushViewController:partnersVC animated:YES];
    }
    
    
    
}



@end
