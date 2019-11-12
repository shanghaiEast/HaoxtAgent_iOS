//
//  ConfirmSignViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/9/3.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "ConfirmSignViewController.h"


#import "LinesCerViewController.h"


@interface ConfirmSignViewController ()

@end

@implementation ConfirmSignViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [MyTools setViewController:self withNavigationBarColor:WHITECOLOR andItem:@"结果" itemColor:BLACKCOLOR haveBackBtn:NO withBackImage:defaultBarBackImage_black withBackClickTarget:self BackClickAction:@selector(popViewClick)];
    
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)popViewClick{
    
    if ([_nextBtn.currentTitle isEqualToString:@"进行提额认证"]) {
       
        [self.navigationController popToRootViewControllerAnimated:YES];
        
        return;
    }
    
    if ([_nextBtn.currentTitle isEqualToString:@"重新填写"]) {
        [self.navigationController popViewControllerAnimated:YES];
        
        return;
    }
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [ToolsObject disableTheSideslip:self];
    
    [self createView];
}

- (void)createView{
    _nextBtn.layer.cornerRadius = 2;
    _nextBtn.layer.masksToBounds = YES;
    
    _cancelBtn.layer.cornerRadius = 2;
    _cancelBtn.layer.masksToBounds = YES;
    
    //0==成功，1==失败，2==未知
    if (_payType == CER_SUCCESS) {
        _stateImageView.image = [UIImage imageNamed:@"cerSuccess.png"];
        _title_main.text = @"实名认证成功";
        _title_other.hidden = YES;
        
        [_nextBtn setTitle:@"进行提额认证" forState:UIControlStateNormal];
        [_cancelBtn setHidden:YES];
    }
    
    
    if (_payType == CER_FAilE) {
        _stateImageView.image = [UIImage imageNamed:@"cerfaile.png"];
        _title_main.text = @"认证失败，请重新填写";
        _title_other.hidden = YES;
        
        [_nextBtn setTitle:@"重新填写" forState:UIControlStateNormal];
        [_cancelBtn setHidden:YES];
    }
    
    if (_payType == SUCCESS) {
        _stateImageView.image = [UIImage imageNamed:@"cerSuccess.png"];
        _title_main.hidden = YES;
        _title_other.hidden = YES;
        
        [_nextBtn setHidden:YES];
        [_cancelBtn setHidden:YES];
    }
    
}


- (IBAction)nextBtnClick:(id)sender {
    UIButton *button = (id)sender;
    if ([button.currentTitle isEqualToString:@"进行提额认证"]) {
        LinesCerViewController *VC = [[LinesCerViewController alloc] initWithNibName:@"LinesCerViewController" bundle:nil];
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
        
        return;

    }
    
    if ([button.currentTitle isEqualToString:@"重新填写"]) {
         [self.navigationController popViewControllerAnimated:YES];
        
        return;
    }
    
    
//
//    if ([button.currentTitle isEqualToString:@"重新交易"]) {
//         [self.navigationController popToRootViewControllerAnimated:YES];
//    }
//    if ([button.currentTitle isEqualToString:@"返回首页"]) {
//        [self.navigationController popToRootViewControllerAnimated:YES];
//    }
//    if ([button.currentTitle isEqualToString:@"前去认证信用卡"]) {
//
//    }
//    if ([button.currentTitle isEqualToString:@"查看实名信息"]) {
//
//    }
//}
//- (IBAction)cancelBtnClick:(id)sender {
//    UIButton *button = (id)sender;
//
//    if ([button.currentTitle isEqualToString:@"查看实名信息"]) {
//
//
//    }
//    if ([button.currentTitle isEqualToString:@"查看我的POS机"]) {
//
//
//    }
//
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
