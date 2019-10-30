//
//  ReturnsDetailedViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/10/30.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "ReturnsDetailedViewController.h"

#import <JXCategoryTitleView.h>
#import "ReturnsDetailedTableViewCell.h"
#import "WithdrawalListFilterViewController.h"
#import "WithdrawalDetailViewController.h"
#import "ReturnsDetailedHeaderView.h"

@interface ReturnsDetailedViewController ()<UITableViewDelegate, UITableViewDataSource, JXCategoryViewDelegate>

@property (retain, nonatomic) ReturnsDetailedHeaderView *headerView;

@property (retain, nonatomic) UIView *searchView;
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic) int moduleIndex;//切换的标签


@property (nonatomic) int pageSize;
@property (retain, nonatomic) NSMutableArray *resultArray;

@property (retain, nonatomic) UIButton *rightBtn;

@end

@implementation ReturnsDetailedViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleLightContent;
    
    //    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [MyTools setViewController:self withNavigationBarColor:IMPORTANT_BACKGROUND andItem:@"收益明细" itemColor:WHITECOLOR haveBackBtn:YES withBackImage:defaultBarBackImage_White withBackClickTarget:self BackClickAction:@selector(popViewClick)];
    
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
    [_rightBtn setFrame:CGRectMake(ScreenWidth-50-15, 13, 53, 28)];
    [_rightBtn setTitle:@"筛选" forState:UIControlStateNormal];
    _rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_rightBtn setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
    _rightBtn.tag = 1;
    [_rightBtn addTarget:self action:@selector(screenClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:_rightBtn];
}

- (void)screenClicked {
    NSLog(@"筛选");
    
    WithdrawalListFilterViewController *VC = [[WithdrawalListFilterViewController alloc] initWithNibName:@"WithdrawalListFilterViewController" bundle:nil];
    VC.filterType = filterType_shouyi;
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self creatHeaderView];
    [self createTableView];
}
- (void)creatHeaderView {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 45)];
    headerView.backgroundColor = IMPORTANT_BACKGROUND;
    [self.view addSubview:headerView];

//    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, headerView.frame.size.height-10, ScreenWidth, 10)];
//    lineView.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
//    [headerView addSubview:lineView];
    
    UIView *slideView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, headerView.frame.size.height)];
    slideView.backgroundColor = IMPORTANT_BACKGROUND;
    [headerView addSubview:slideView];
    
    
    _titles = @[@"交易分润", @"激活返现"];
    
    _categoryView = [[JXCategoryTitleView alloc] initWithFrame:slideView.bounds];
    self.categoryView.titles = self.titles;
    self.categoryView.backgroundColor = IMPORTANT_BACKGROUND;
    self.categoryView.delegate = self;
    self.categoryView.titleSelectedColor = WHITECOLOR;
    self.categoryView.titleSelectedFont = [UIFont systemFontOfSize:17 weight:UIFontWeightBold];
    self.categoryView.titleColor = WHITECOLOR;
    self.categoryView.titleColorGradientEnabled = YES;
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
    _moduleIndex = (int)index;
    [_myTableView reloadData];
}

- (void)createTableView {
    //table view
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, ScreenWidth, ScreenHeight-kTabBarHeight-kBottomSafeHeight-45) style:UITableViewStyleGrouped];
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
    
    //    _myTableView.ly_emptyView = [LYEmptyView emptyViewWithImage:[UIImage imageNamed:@"emptycell.png"] titleStr:@"暂无消息…" detailStr:@""];
    //
    //    _myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeader)];
    //    _myTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upDown)];
    //
    //    [self refreshTableView];
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
    
    return 330;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    return 80;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    _headerView = [[[NSBundle mainBundle] loadNibNamed:@"ReturnsDetailedHeaderView" owner:self options:nil] lastObject];
    [_headerView setFrame:CGRectMake(0, 0, ScreenWidth, 330)];
    _headerView.rootVC = self;
    [_headerView createView];
    
    
    return _headerView;
    
    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
//    view.backgroundColor = LINECOLOR;
//
//    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *nibString = @"ReturnsDetailedTableViewCell";
    ReturnsDetailedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nibString];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:nibString owner:self options:nil] lastObject];
    }
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    WithdrawalDetailViewController *VC = [[WithdrawalDetailViewController alloc] initWithNibName:@"WithdrawalDetailViewController" bundle:nil];
    VC.resultDict = [NSDictionary new];
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
    
}


@end
