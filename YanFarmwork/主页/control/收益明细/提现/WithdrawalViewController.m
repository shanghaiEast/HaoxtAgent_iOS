//
//  WithdrawalViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/10/29.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "WithdrawalViewController.h"

#import "WithdrawalListViewController.h"

@interface WithdrawalViewController ()

@property (retain , nonatomic) NSString *allMoneyString, *otherMoneyString;

@property (retain, nonatomic) UIButton *rightBtn;

@end

@implementation WithdrawalViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    //    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [MyTools setViewController:self withNavigationBarColor:WHITECOLOR andItem:@"提现" itemColor:BLACKCOLOR haveBackBtn:YES withBackImage:defaultBarBackImage_black withBackClickTarget:self BackClickAction:@selector(popViewClick)];
    
     [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self screenView];
    
}
- (void)popViewClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [_rightBtn removeFromSuperview];
}

- (void)screenView{
    
    [_rightBtn removeFromSuperview];
    
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightBtn setFrame:CGRectMake(ScreenWidth-80-15, 13, 80, 28)];
    [_rightBtn setTitle:@"提现明细" forState:UIControlStateNormal];
    _rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_rightBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    _rightBtn.tag = 1;
    [_rightBtn addTarget:self action:@selector(screenClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:_rightBtn];
}
- (void)screenClicked {
    NSLog(@"筛选");
    
    WithdrawalListViewController *VC = [[WithdrawalListViewController alloc] initWithNibName:@"WithdrawalListViewController" bundle:nil];
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _allMoneyString = @"10000";
    _otherMoneyString = @"88";
    
    
    [self createView];
    
}

- (void)createView {
    
    _allMonetLabel.text = [NSString stringWithFormat:@"当前零钱余额%.2f元",[_allMoneyString floatValue]];
    _otherMoneyLabel.text = [NSString stringWithFormat:@"提现手续费: %.2f元/笔",[_otherMoneyString floatValue]];

    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)getAllMoneyBtnClick:(id)sender {
    
    _inputMonetTextField.text = [NSString stringWithFormat:@"%.2f",[_allMoneyString floatValue]];
}

- (IBAction)confirmBtnClicked:(id)sender {
}
@end
