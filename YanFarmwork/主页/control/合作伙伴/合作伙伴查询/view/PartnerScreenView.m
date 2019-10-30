//
//  PartnerScreenView.m
//  YanFarmwork
//
//  Created by HG on 2019/10/21.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "PartnerScreenView.h"

@implementation PartnerScreenView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)cancelBtnClick:(id)sender {
    if (_btnSelectedBlock) {
        _btnSelectedBlock(0, [NSDictionary new]);
    }
}

- (IBAction)conformBtnClick:(id)sender {
    if (_serviceNameTextField.text.length == 0) {
        [ToolsObject showMessageTitle:@"输入服务商名称进行查询" andDelay:1 andImage:nil];
        return;
    }
    if (_peopleNameTextField.text.length == 0) {
        [ToolsObject showMessageTitle:@"输入法人名称进行查询" andDelay:1 andImage:nil];
        return;
    }
    if (_phoneTextField.text.length == 0) {
        [ToolsObject showMessageTitle:@"输入机号进行查询" andDelay:1 andImage:nil];
        return;
    }
    
    if (_btnSelectedBlock) {
        NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:
                             _serviceNameTextField.text,@"key1",
                             _peopleNameTextField.text,@"key2",
                             _phoneTextField.text,@"key3",
                             nil];
        _btnSelectedBlock(1, dic);
    }
}

- (void)createView {
    UIView *serviceView = [[UIView alloc] initWithFrame:CGRectMake(5, 7, 25, 20)];
    UIImageView *serviceImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 2, 15, 15)];
    serviceImage.image = [UIImage imageNamed:@"searchIcon.png"];
    [serviceView addSubview:serviceImage];
    _serviceNameTextField.leftViewMode = UITextFieldViewModeAlways;
    _serviceNameTextField.leftView = serviceView;
    
    UIView *peopleView = [[UIView alloc] initWithFrame:CGRectMake(5, 7, 25, 20)];
    UIImageView *peopleImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 2, 15, 15)];
    peopleImage.image = [UIImage imageNamed:@"searchIcon.png"];
    [peopleView addSubview:peopleImage];
    _peopleNameTextField.leftViewMode = UITextFieldViewModeAlways;
    _peopleNameTextField.leftView = peopleView;
    
    UIView *phoneView = [[UIView alloc] initWithFrame:CGRectMake(5, 7, 25, 20)];
    UIImageView *phoneImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 2, 15, 15)];
    phoneImage.image = [UIImage imageNamed:@"searchIcon.png"];
    [phoneView addSubview:phoneImage];
    _phoneTextField.leftViewMode = UITextFieldViewModeAlways;
    _phoneTextField.leftView = phoneView;
}

@end
