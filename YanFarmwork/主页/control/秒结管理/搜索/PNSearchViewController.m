//
//  PNSearchViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/10/21.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "PNSearchViewController.h"

#import "SettlementManagerTableViewCell.h"



@interface PNSearchViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (retain, nonatomic) NSMutableArray *resultArrar;


@property (retain, nonatomic) UIView *searchView;
@property (retain, nonatomic) UITextField *searchTextField;
@property (retain, nonatomic) UIButton *searchBtn;

@end

@implementation PNSearchViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    [MyTools setViewController:self withNavigationBarColor:WHITECOLOR andItem:@"" itemColor:BLACKCOLOR haveBackBtn:YES withBackImage:defaultBarBackImage_black withBackClickTarget:self BackClickAction:@selector(popViewClick)];
    
    [self.navigationController.navigationBar addSubview:[self searchViewCreate]];
    
}
- (void)popViewClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [_searchView removeFromSuperview];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self createTableView];
}

- (UIView *)searchViewCreate{
    NSLog(@"搜索");
    
    _searchView = [[UIView alloc] initWithFrame:CGRectMake(55, 0, ScreenWidth-30-55, 44)];
    
    float searchViewHeight = _searchView.frame.size.height;
    float searchViewWidth = _searchView.frame.size.width;
    
    _searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 7, searchViewWidth-65, 30)];
    _searchTextField.font = [UIFont systemFontOfSize:14];
    _searchTextField.placeholder = @"请输入业务员编号/名称";
    //        searchField.borderStyle = UITextBorderStyleNone;
    //        searchField.background = [UIImage imageNamed:@"ic_top"];
    _searchTextField.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    _searchTextField.leftViewMode=UITextFieldViewModeNever;
    _searchTextField.textColor=[UIColor whiteColor];
    _searchTextField.layer.cornerRadius = 15;
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
    
    
    _searchBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
    [_searchBtn setFrame:CGRectMake(searchViewWidth-50, 7, 50, 30)];
    _searchBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_searchBtn setTitleColor:IMPORTANT_TEXT forState:UIControlStateNormal];
    [_searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
     [_searchBtn addTarget:self action:@selector(searchBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_searchView addSubview:_searchBtn];
   
    
    
    UIView *phoneView = [[UIView alloc] initWithFrame:CGRectMake(5, 7, 25, 20)];
    UIImageView *searchImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 2, 15, 15)];
    searchImage.image = [UIImage imageNamed:@"searchIcon.png"];
    [phoneView addSubview:searchImage];
    
    _searchTextField.leftViewMode = UITextFieldViewModeAlways;
    _searchTextField.leftView = phoneView;
    
    return _searchView;
}

- (void)searchBtn:(UIButton *)sender {
    NSLog(@"搜索");
    [_searchTextField resignFirstResponder];
}

- (void)createTableView {
    //table view
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-kTabBarHeight-kBottomSafeHeight) style:UITableViewStylePlain];
    _myTableView.backgroundColor = [UIColor whiteColor];
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.sectionFooterHeight = CGFLOAT_MIN;
    _myTableView.tableFooterView = [UIView new];
    [self.view addSubview:_myTableView];
    
    if (@available(iOS 11.0, *)) {
        _myTableView.estimatedRowHeight = 0;
        _myTableView.estimatedSectionFooterHeight = 0;
        _myTableView.estimatedSectionHeaderHeight = 0;
        _myTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
    //    return _resultArrar.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    return 193;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *topCell = @"SettlementManagerTableViewCell";
    
    SettlementManagerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:topCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:topCell owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell createCell:nil];
    
    cell.setBtn.tag = indexPath.row;
    [cell.setBtn addTarget:self action:@selector(level2Set:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.detailBtn.tag = indexPath.row;
    [cell.detailBtn addTarget:self action:@selector(listDetail:) forControlEvents:UIControlEventTouchUpInside];
    
    if (_jumpType == 1) {
        [cell.setBtn setHidden:YES];
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
}

- (void)level2Set:(UIButton *)button {
    NSLog(@"level2Set tag :%ld",button.tag);
    
}
- (void)listDetail:(UIButton *)button {
    NSLog(@"listDetail tag :%ld",button.tag);
    
}

@end
