//
//  AddressEditViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/10/31.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "AddressEditViewController.h"

@interface AddressEditViewController ()

@end

@implementation AddressEditViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    //    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [MyTools setViewController:self withNavigationBarColor:WHITECOLOR andItem:@"编辑地址" itemColor:BLACKCOLOR haveBackBtn:YES withBackImage:defaultBarBackImage_black withBackClickTarget:self BackClickAction:@selector(popViewClick)];
    
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
    [ToolsObject buttonImageRight:_areaBtn];
    
    if (_editType == NO) {
        _personNameTextField.userInteractionEnabled = NO;
        [_personNameTextField setEnabled:NO];
        [_phoneTextField setEnabled:NO];
        [_detailAddressTextField setEnabled:NO];
    }
    
    if ([_areaBtn.currentTitle isEqualToString:@""]) {
        [_areaBtn setTitleColor:WEAKER_TEXT_LEVEL_1 forState:UIControlStateNormal];
    }else{
         [_areaBtn setTitleColor:IMPORTANT_TEXT forState:UIControlStateNormal];
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

- (IBAction)areaBtnClick:(id)sender {
    NSLog(@"选择地区");
    [_personNameTextField resignFirstResponder];
    [_phoneTextField resignFirstResponder];
    [_detailAddressTextField resignFirstResponder];
}
@end
