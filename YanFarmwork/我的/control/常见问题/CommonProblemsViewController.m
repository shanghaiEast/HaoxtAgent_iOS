//
//  CommonProblemsViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/11/4.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "CommonProblemsViewController.h"

@interface CommonProblemsViewController ()

@property (retain, nonatomic) UIButton *rightBtn;

@end

@implementation CommonProblemsViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    //    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [MyTools setViewController:self withNavigationBarColor:WHITECOLOR andItem:@"常见问题" itemColor:BLACKCOLOR haveBackBtn:YES withBackImage:defaultBarBackImage_black withBackClickTarget:self BackClickAction:@selector(popViewClick)];
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self screenView];
}
- (void)popViewClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    [_rightBtn removeFromSuperview];
}
- (void)screenView{
    
    [_rightBtn removeFromSuperview];
    
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightBtn setFrame:CGRectMake(ScreenWidth-30-15, 13, 28, 28)];
    [_rightBtn setTitle:@"" forState:UIControlStateNormal];
    [_rightBtn setImage:[UIImage imageNamed:@"kefu.png"] forState:UIControlStateNormal];
    _rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_rightBtn setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
    _rightBtn.tag = 1;
    [_rightBtn addTarget:self action:@selector(screenClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:_rightBtn];
}

- (void)screenClicked {
    NSLog(@"提交地址");
    
//    AddressEditViewController *VC = [[AddressEditViewController alloc] initWithNibName:@"AddressEditViewController" bundle:nil];
//    VC.editType = edit_no;
//    VC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:VC animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)callUsClicked:(id)sender {
    
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"400-1234-5678"];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
@end
