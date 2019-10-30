//
//  WithdrawalDetailViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/10/29.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "WithdrawalDetailViewController.h"


#import "WithdrawalListTableViewCell.h"

@interface WithdrawalDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) int pageSize;
@property (retain, nonatomic) NSArray *imageArray, *titleArray;

@property (retain, nonatomic) UIButton *rightBtn;

@end

@implementation WithdrawalDetailViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    //    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [MyTools setViewController:self withNavigationBarColor:WHITECOLOR andItem:@"提现明细详情" itemColor:BLACKCOLOR haveBackBtn:YES withBackImage:defaultBarBackImage_black withBackClickTarget:self BackClickAction:@selector(popViewClick)];
    
    
    
    
}
- (void)popViewClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self createView];
}

- (void)createView {
    [_myScrollView setContentSize:CGSizeMake(0, 568)];
    
    _orderStateLabel.text = [NSString stringWithFormat:@"%@",@"审核通过"];
    _dataLabel.text = [NSString stringWithFormat:@"%@",@"2019-09-09"];
    _NOLabel.text = [NSString stringWithFormat:@"%@",@"WY00215689745689"];
    _poundageLabel.text = [NSString stringWithFormat:@"%@元",@"1"];
    _timeLabel.text = [NSString stringWithFormat:@"%@",@"2019-07-09"];
    
    NSString *remindString = [NSString stringWithFormat:@"%@",@"念佛温暖我看是念佛的上半年快递费你搜吧难道不能送吧手动波视频"];
    _remindLabel.attributedText = [ToolsObject getStringWithRect:remindString width:_remindLabel.frame.size.width fonts:14 height:70 lineSpacing:5];
}

@end
