//
//  QuerySearchViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/10/24.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "QuerySearchViewController.h"



#import <JXCategoryTitleView.h>
#import "NormalTableViewCell.h"
#import "QueryFilterViewController.h"

@interface QuerySearchViewController ()<UITableViewDelegate, UITableViewDataSource, JXCategoryViewDelegate>

@property (nonatomic) int pageSize, indexTag;
@property (retain, nonatomic) NSMutableArray *resultArray;


@property (retain, nonatomic) UIView *screenView;
@property (retain, nonatomic) UIButton *screenBtn;
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) NSArray *titles;

@end

@implementation QuerySearchViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    //    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [MyTools setViewController:self withNavigationBarColor:WHITECOLOR andItem:@"合作伙伴业绩" itemColor:BLACKCOLOR haveBackBtn:YES withBackImage:defaultBarBackImage_black withBackClickTarget:self BackClickAction:@selector(popViewClick)];
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
}
- (void)popViewClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self creatScreenView];
    
    [self createTableView];
}

- (void)creatScreenView {
    
    _screenView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 55)];
    [self.view addSubview:_screenView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _screenView.frame.size.height-10, ScreenWidth, 10)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    [_screenView addSubview:lineView];
    
    _screenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_screenBtn setFrame:CGRectMake(ScreenWidth-65-15, 10, 55, 24)];
    _screenBtn.layer.cornerRadius = 12;
    _screenBtn.layer.masksToBounds = YES;
    _screenBtn.backgroundColor = IMPORTANT_BACKGROUND;
    [_screenBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_screenBtn setTitle:@"筛选" forState:UIControlStateNormal];
    _screenBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_screenBtn addTarget:self action:@selector(screenBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_screenView addSubview:_screenBtn];
    
    
    UIView *slideView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-120, _screenView.frame.size.height-10)];
    slideView.backgroundColor = [UIColor purpleColor];
    [_screenView addSubview:slideView];
    
    
    [self slideView:slideView];
}

- (void)slideView:(UIView *)slideView {
    _titles = @[@"按日查询", @"按月查询"];
    
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
    _indexTag = index;
    
    if (_indexTag == 0) {
        
    }
    
    if (_indexTag == 1) {
        
    }
    
}

- (void)screenBtnClick{
    NSLog(@"筛选");
    
    QueryFilterViewController *VC = [[QueryFilterViewController alloc] initWithNibName:@"QueryFilterViewController" bundle:nil];
    if (_indexTag == 0) {
        VC.screenType = searchForDay;
    }
    if (_indexTag == 1) {
        VC.screenType = searchForMonth;
    }
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (void)createTableView {
    //table view
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 55, ScreenWidth, ScreenHeight-kTabBarHeight-kBottomSafeHeight-55) style:UITableViewStylePlain];
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
    return 3 + 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 2;
    }
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
         return CGFLOAT_MIN;
    }
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return [UIView new];
    }
    
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0,0,ScreenWidth,35);
    view.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];

    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(15, 0, ScreenWidth-30, 35);
    label.numberOfLines = 0;
    [view addSubview:label];
    
    NSString *dateString = @"2019年5月20日";
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:dateString attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15 weight:UIFontWeightMedium],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    
    label.attributedText = string;
    
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *nibString = @"NormalTableViewCell";
    NormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nibString];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:nibString owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0) {
        NSArray *array = @[@"终端数量", @"开通率"];
        cell.titleLabel.text = [array objectAtIndex:indexPath.row];
        cell.detailLabel.text = @"test";
        
    }else{
        NSArray *array = @[@"总交易额", @"总笔数", @"新增绑定", @"在网商户", @"户均金额", @"新增激活"];
        cell.titleLabel.text = [array objectAtIndex:indexPath.row];
        cell.detailLabel.text = @"test";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
}


@end
