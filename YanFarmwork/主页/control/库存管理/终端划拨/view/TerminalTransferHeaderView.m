//
//  TerminalTransferHeaderView.m
//  YanFarmwork
//
//  Created by HG on 2019/10/22.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "TerminalTransferHeaderView.h"

#import "TerminalTransferListViewController.h"
#import "ShopNewSearchViewController.h"


@interface TerminalTransferHeaderView ()

@property (retain, nonatomic) UITextField *searchTextField;
@property (retain, nonatomic) UIButton *searchBtn;

@end


@implementation TerminalTransferHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



- (void)createView {
    [ToolsObject buttonImageRight:_addFriends];
    [ToolsObject buttonImageRight:_delectFriends];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self createSearchView];
    });
}

- (void)createSearchView {
    NSLog(@"搜索");
    
//    _searchView = [[UIView alloc] initWithFrame:CGRectMake(55, 0, ScreenWidth-30-55, 44)];

    float searchViewWidth = _searchView.frame.size.width;
    
    _searchTextField = [[UITextField alloc] initWithFrame:_searchView.bounds];
    _searchTextField.font = [UIFont systemFontOfSize:14];
    _searchTextField.placeholder = @"输入好友名称/编号";
    //        searchField.borderStyle = UITextBorderStyleNone;
    //        searchField.background = [UIImage imageNamed:@"ic_top"];
    _searchTextField.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    _searchTextField.leftViewMode=UITextFieldViewModeNever;
    _searchTextField.textColor=[UIColor whiteColor];
    _searchTextField.layer.cornerRadius = 20;
    //            _textField.layer.borderWidth = 1.0f;
    //            _textField.layer.borderColor = [UIColor colorWithHexString:@""];
    _searchTextField.layer.masksToBounds = YES;
    //        _textField.delegate = self;
    _searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _searchTextField.returnKeyType = UIReturnKeySearch;
    //_textField//改变placeholder的颜色
    [_searchTextField setValue:[UIColor colorWithHexString:@"#CCCCCC"]  forKeyPath:@"_placeholderLabel.textColor"];
    [_searchView addSubview:_searchTextField];
    
    
    UIView *phoneView = [[UIView alloc] initWithFrame:CGRectMake(5, 10, 40, 20)];
    UIImageView *searchImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 2, 20, 20)];
    searchImage.image = [UIImage imageNamed:@"searchIcon.png"];
    [phoneView addSubview:searchImage];
    
    _searchTextField.leftViewMode = UITextFieldViewModeAlways;
    _searchTextField.leftView = phoneView;
    
    
//    [ToolsObject showShadow:_searchTextField];
    
    _searchBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
    [_searchBtn setFrame:_searchView.bounds];
    _searchBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_searchBtn setTitleColor:IMPORTANT_TEXT forState:UIControlStateNormal];
//    [_searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [_searchBtn addTarget:self action:@selector(searchBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_searchView addSubview:_searchBtn];
   
}

- (void)searchBtn:(UIButton *)sender {
    NSLog(@"搜索");
    [_searchTextField resignFirstResponder];
    
    ShopNewSearchViewController *pnSerchVC = [[ShopNewSearchViewController alloc] initWithNibName:@"ShopNewSearchViewController" bundle:nil];
    pnSerchVC.searchType = SEARCH_TERMINAL;
    pnSerchVC.hidesBottomBarWhenPushed = YES;
    [_rootVC.navigationController pushViewController:pnSerchVC animated:YES];
}



- (IBAction)addBatchBtnClick:(id)sender {
    if (_addBatchBlock) {
        _addBatchBlock(YES);
    }
}

- (IBAction)addFriendsClick:(id)sender {
     NSLog(@"迁入好友");
}
- (IBAction)delectFriendsClick:(id)sender {
    NSLog(@"移出好友");
}

- (IBAction)backBtnClicked:(id)sender {
    [_rootVC.navigationController popViewControllerAnimated:YES];
   
    [self showNavigation];
}

- (IBAction)detailListBtnClick:(id)sender {
    NSLog(@"划拨明细");
    TerminalTransferListViewController *VC = [[TerminalTransferListViewController alloc] initWithNibName:@"TerminalTransferListViewController" bundle:nil];
    VC.hidesBottomBarWhenPushed = YES;
    [_rootVC.navigationController pushViewController:VC animated:YES];
    
     [self showNavigation];
}

- (void)showNavigation{
     [_rootVC.navigationController setNavigationBarHidden:NO animated:NO];
}

@end
