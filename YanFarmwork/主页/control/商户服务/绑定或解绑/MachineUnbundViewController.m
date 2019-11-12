//
//  MachineUnbundViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/10/22.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "MachineUnbundViewController.h"

#import "ShopSearchViewController.h"

@interface MachineUnbundViewController ()

@end

@implementation MachineUnbundViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    //    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    NSString *titleStr;
    if (_bundType == IS_UN_BUND) {
        titleStr = @"机具解绑";
    }else{
        titleStr = @"机具绑定";
    }
    
    [MyTools setViewController:self withNavigationBarColor:WHITECOLOR andItem:titleStr itemColor:BLACKCOLOR haveBackBtn:YES withBackImage:defaultBarBackImage_black withBackClickTarget:self BackClickAction:@selector(popViewClick)];
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
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
    if (_bundType == IS_UN_BUND) {
        _noLabel.text = @"解绑机具号";
        [_confirmBtn setTitle:@"确定解绑" forState:UIControlStateNormal];
    }else{
        _noLabel.text = @"绑定机具号";
        [_confirmBtn setTitle:@"确定绑定" forState:UIControlStateNormal];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)nextBtnClicked:(id)sender {
     NSLog(@"商户信息查询");
    
    ShopSearchViewController *VC = [[ShopSearchViewController alloc] initWithNibName:@"ShopSearchViewController" bundle:nil];
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (IBAction)scanBtnClicked:(id)sender {
    NSLog(@"扫描");
}

- (IBAction)confirmBtnClicked:(id)sender {
    NSLog(@"确定");
    
}
@end
