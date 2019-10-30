//
//  DeliveryRecordViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/10/28.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "DeliveryRecordViewController.h"

#import <JXCategoryTitleView.h>
#import "DeliveryRecordTableViewCell.h"
#import "DeliveryRecordDetailViewController.h"

@interface DeliveryRecordViewController ()<UITableViewDelegate, UITableViewDataSource, JXCategoryViewDelegate>

@property (retain, nonatomic) UIView *searchView;
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic) int moduleIndex;//切换的标签

@property (nonatomic) int pageSize;
@property (retain, nonatomic) NSMutableArray *resultArrar;

@property (retain, nonatomic) NSArray *keyArray, *hoderArray, *valueArray;



@end

@implementation DeliveryRecordViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    //    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [MyTools setViewController:self withNavigationBarColor:WHITECOLOR andItem:@"发货记录" itemColor:BLACKCOLOR haveBackBtn:YES withBackImage:defaultBarBackImage_black withBackClickTarget:self BackClickAction:@selector(popViewClick)];
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
}
- (void)popViewClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)creatHeaderView {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 55)];
    [self.view addSubview:headerView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, headerView.frame.size.height-10, ScreenWidth, 10)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    [headerView addSubview:lineView];
    
    UIView *slideView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, headerView.frame.size.height-10)];
    slideView.backgroundColor = [UIColor purpleColor];
    [headerView addSubview:slideView];
    
    
    _titles = @[@"全部状态", @"待发货", @"待发货",@"已收货"];
    
    _categoryView = [[JXCategoryTitleView alloc] initWithFrame:slideView.bounds];
    self.categoryView.titles = self.titles;
    self.categoryView.backgroundColor = [UIColor whiteColor];
    self.categoryView.delegate = self;
    self.categoryView.titleSelectedColor = IMPORTANT_TEXT;
    self.categoryView.titleSelectedFont = [UIFont systemFontOfSize:17 weight:UIFontWeightBold];
    self.categoryView.titleColor = NORMAL_TEXT_LEVEL_1;
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


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self creatHeaderView];
    [self createTableView];
}

- (void)createTableView {
    //table view
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 55, ScreenWidth, ScreenHeight-kTabBarHeight-55-kBottomSafeHeight) style:UITableViewStylePlain];
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
//    return [[_keyArray objectAtIndex:section] count];
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
   
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
   
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    return 230;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *topCell = @"DeliveryRecordTableViewCell";
    DeliveryRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:topCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DeliveryRecordTableViewCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (_moduleIndex == 0) {
        cell.confirmBtn.hidden = YES;
        cell.stateImageView.image = [UIImage imageNamed:@"dai.png"];
        cell.stateTitleLabel.text = @"待发货";
    }
    
    if (_moduleIndex == 1) {
        cell.confirmBtn.hidden = YES;
        cell.stateImageView.image = [UIImage imageNamed:@"dai.png"];
        cell.stateTitleLabel.text = @"待发货";
    }
    
    if (_moduleIndex == 2) {
        cell.confirmBtn.hidden = NO;
        cell.stateImageView.image = [UIImage imageNamed:@"shou.png"];
        cell.stateTitleLabel.text = @"待收货 ";
    }
    
    if (_moduleIndex == 3) {
        cell.confirmBtn.hidden = YES;
        cell.stateImageView.image = [UIImage imageNamed:@"yi.png"];
        cell.stateTitleLabel.text = @"已收货";
    }
    
    cell.confirmBtn.tag = (int)indexPath.row;
    [cell.confirmBtn addTarget:self action:@selector(confirmAndDetailBtnVlicked:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.detailBtn.tag = (int)indexPath.row;
    [cell.detailBtn addTarget:self action:@selector(confirmAndDetailBtnVlicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

- (void)confirmAndDetailBtnVlicked:(UIButton *)button {
    
    if ([button.currentTitle isEqualToString:@"确认收货"]) {
        NSLog(@"确认收货");
        
    }
    if ([button.currentTitle isEqualToString:@"查看详情"]) {
        NSLog(@"查看详情");
        DeliveryRecordDetailViewController *VC = [[DeliveryRecordDetailViewController alloc] initWithNibName:@"DeliveryRecordDetailViewController" bundle:nil];
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
        
    }
}

@end
