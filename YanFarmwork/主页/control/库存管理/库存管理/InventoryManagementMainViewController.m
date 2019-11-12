//
//  InventoryManagementMainViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/10/23.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "InventoryManagementMainViewController.h"

#import <JXCategoryTitleView.h>

#import "InventoryManagementMainTableViewCell.h"
#import "InventoryManagementDetailViewController.h"
#import "FilterViewController.h"


@interface InventoryManagementMainViewController ()<UITableViewDelegate, UITableViewDataSource, JXCategoryViewDelegate>

@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (retain, nonatomic) UIView *titleView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic) int moduleIndex;//切换的标签



@property (nonatomic) int pageSize;
@property (retain, nonatomic) NSMutableArray *resultArray;

@property (retain, nonatomic) UIButton *rightBtn;

@end

@implementation InventoryManagementMainViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    //    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [MyTools setViewController:self withNavigationBarColor:WHITECOLOR andItem:@"库存管理" itemColor:BLACKCOLOR haveBackBtn:YES withBackImage:defaultBarBackImage_black withBackClickTarget:self BackClickAction:@selector(popViewClick)];
    
    [self screenView];
    
}
- (void)popViewClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [_rightBtn removeFromSuperview];
}

- (void)screenView{
    
    [_rightBtn removeFromSuperview];
    
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightBtn setFrame:CGRectMake(ScreenWidth-50-15, 13, 53, 28)];
    [_rightBtn setTitle:@"筛选" forState:UIControlStateNormal];
    _rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_rightBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    _rightBtn.tag = 1;
    [_rightBtn addTarget:self action:@selector(screenClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:_rightBtn];
}

- (void)screenClicked {
    NSLog(@"筛选");
    
    FilterViewController *VC = [[FilterViewController alloc] initWithNibName:@"FilterViewController" bundle:nil];
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)slideView {
    
    _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 55)];
    [self.view addSubview:_titleView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _titleView.frame.size.height-10, ScreenWidth, 10)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    [_titleView addSubview:lineView];
    
    UIView *slideView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, _titleView.frame.size.height-10)];
//    slideView.backgroundColor = [UIColor purpleColor];
    [_titleView addSubview:slideView];
    
    
    _titles = @[@"全部", @"已激活", @"未激活"];
    
    _categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(15, 0, 240, slideView.frame.size.height)];
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


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self slideView];
    [self createTableView];
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
    
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    return 70;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, ScreenWidth-30, 49)];
    label.textColor = NORMAL_TEXT_LEVEL_1;
    label.font = [UIFont systemFontOfSize:12];
    [view addSubview:label];
    
    NSString *numString = @"100";
    NSString *textString = [NSString stringWithFormat:@"2019-10 %@ 共计           台",numString];
    NSMutableAttributedString *textFont = [[NSMutableAttributedString alloc] initWithString:textString];
    [textFont addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17 weight:UIFontWeightMedium] range:NSMakeRange(textString.length-numString.length-1, numString.length)];
    [textFont addAttribute:NSForegroundColorAttributeName value:IMPORTANT_BACKGROUND range:NSMakeRange(textString.length-numString.length-1, numString.length)];
    label.attributedText = textFont;
    
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, 49, ScreenWidth-30, 1)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    [view addSubview:lineView];
    
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *nibString = @"InventoryManagementMainTableViewCell";;
    InventoryManagementMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nibString];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:nibString owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    InventoryManagementDetailViewController *VC = [[InventoryManagementDetailViewController alloc] initWithNibName:@"InventoryManagementDetailViewController" bundle:nil];
    if (indexPath.row%2 == 0) {
        VC.bundType = BUND;
    }else{
        VC.bundType = UN_BUND;
    }
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
}

@end

