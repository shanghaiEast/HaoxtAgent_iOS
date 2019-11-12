//
//  ShopManagerViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/10/22.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "ShopManagerViewController.h"

#import <JXCategoryTitleView.h>

#import "ShopManagerTableViewCell.h"
#import "ShopNewSearchViewController.h"
#import "ShopManagerDetailViewController.h"
#import "LinesCerViewController.h"


@interface ShopManagerViewController ()<UITableViewDelegate, UITableViewDataSource, JXCategoryViewDelegate>


@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (retain, nonatomic) UIView *titleView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic) int moduleIndex;//切换的标签


@property (retain, nonatomic) UIView *searchView;
@property (retain, nonatomic) UITextField *searchTextField;
@property (retain, nonatomic) UIButton *searchBtn, *bgBtn;


@property (nonatomic) int pageSize;
@property (retain, nonatomic) NSMutableArray *resultArray;



@end

@implementation ShopManagerViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    //    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [MyTools setViewController:self withNavigationBarColor:WHITECOLOR andItem:@"" itemColor:WHITECOLOR haveBackBtn:YES withBackImage:defaultBarBackImage_black withBackClickTarget:self BackClickAction:@selector(popViewClick)];
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self.navigationController.navigationBar addSubview:[self searchViewCreate]];
}
- (void)popViewClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [_searchView removeFromSuperview];
    
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
    [_searchView addSubview:_searchBtn];
    
    
    UIView *phoneView = [[UIView alloc] initWithFrame:CGRectMake(5, 7, 25, 20)];
    UIImageView *searchImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 2, 15, 15)];
    searchImage.image = [UIImage imageNamed:@"searchIcon.png"];
    [phoneView addSubview:searchImage];
    
    _searchTextField.leftViewMode = UITextFieldViewModeAlways;
    _searchTextField.leftView = phoneView;
    
    
    
    
    _bgBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
    [_bgBtn setFrame:_searchView.bounds];
    [_bgBtn addTarget:self action:@selector(puchToSearcView) forControlEvents:UIControlEventTouchUpInside];
    [_searchView addSubview:_bgBtn];
    
    return _searchView;
}

- (void)puchToSearcView {
    ShopNewSearchViewController *pnSerchVC = [[ShopNewSearchViewController alloc] initWithNibName:@"ShopNewSearchViewController" bundle:nil];
    pnSerchVC.searchType = SEARCH_SHOP;
    pnSerchVC.jumpType = _jumpType;
    pnSerchVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:pnSerchVC animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self slideView];
    
    [self createTableView];
}

- (void)slideView {
    
    _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 45)];
    [self.view addSubview:_titleView];
    
    //    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _searchView.frame.size.height-10, ScreenWidth, 10)];
    //    lineView.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    //    [_searchView addSubview:lineView];
    
    UIView *slideView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, _titleView.frame.size.height)];
    slideView.backgroundColor = [UIColor purpleColor];
    [_titleView addSubview:slideView];
    
    
    _titles = @[@"已开通", @"已关闭"];
    
    _categoryView = [[JXCategoryTitleView alloc] initWithFrame:slideView.bounds];
    self.categoryView.titles = self.titles;
    self.categoryView.backgroundColor = [UIColor whiteColor];
    self.categoryView.delegate = self;
    self.categoryView.titleSelectedColor = IMPORTANT_BACKGROUND;
    self.categoryView.titleColor = NORMAL_TEXT_LEVEL_2;
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.titleSelectedFont = [UIFont systemFontOfSize:17 weight:UIFontWeightBold];
    self.categoryView.titleFont = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    self.categoryView.titleLabelZoomEnabled = YES;
    self.categoryView.titleLabelZoomEnabled = YES;
    [slideView addSubview:self.categoryView];
    
}
#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    NSLog(@"JXCategoryViewDelegate === %ld",index); self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
    
    if (_moduleIndex == index) {
        return;
    }
    _moduleIndex = index;
    
    [_myTableView reloadData];
}


- (void)createTableView {
    //table view
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, ScreenWidth, ScreenHeight-kTabBarHeight-kBottomSafeHeight-45) style:UITableViewStylePlain];
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
    
    _myTableView.ly_emptyView = [LYEmptyView emptyViewWithImage:[UIImage imageNamed:@"emptycell.png"] titleStr:@"暂无消息…" detailStr:@""];
    
    _myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeader)];
    _myTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upDown)];
    
    [self refreshTableView];
}
#pragma mark  -----  Refresh
-(void)refreshTableView
{
    [self refreshHeader];
}
- (void)refreshHeader
{
    _pageSize = 1;
    
    [self mjRefreshStopWhenTen];
}
- (void)upDown
{
    _pageSize ++;
    
    [self mjRefreshStopWhenTen];
}
- (void)tableEndRefresh
{
    [_myTableView.mj_header endRefreshing];
    [_myTableView.mj_footer endRefreshing];
}
- (void)mjRefreshStopWhenTen
{
    typeof(self) wSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [wSelf.myTableView.mj_header endRefreshing];
        [wSelf.myTableView.mj_footer endRefreshing];
    });
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    return 172;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *nibString = @"ShopManagerTableViewCell";
    ShopManagerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nibString];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:nibString owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    [cell createCell:nil];
    
    cell.setBtn.tag = indexPath.row;
    [cell.setBtn addTarget:self action:@selector(level2Set:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.detailBtn.tag = indexPath.row;
    [cell.detailBtn addTarget:self action:@selector(listDetail:) forControlEvents:UIControlEventTouchUpInside];
    
    if (_jumpType == SALEMAN) {
        [cell.setBtn setHidden:YES];
    }
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
}

- (void)level2Set:(UIButton *)button {
    NSLog(@"level2Set tag :%ld",button.tag);
    LinesCerViewController *detailVC = [[LinesCerViewController alloc] initWithNibName:@"LinesCerViewController" bundle:nil];
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}
- (void)listDetail:(UIButton *)button {
    NSLog(@"listDetail tag :%ld",button.tag);
    
    ShopManagerDetailViewController *detailVC = [[ShopManagerDetailViewController alloc] initWithNibName:@"ShopManagerDetailViewController" bundle:nil];
    detailVC.jumpType = _jumpType;
    detailVC.editBool = CANT_EDIT;
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
}
@end

