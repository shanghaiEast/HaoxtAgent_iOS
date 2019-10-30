//
//  DeliveryRecordDetailViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/10/28.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "DeliveryRecordDetailViewController.h"

#import "DeliveryRecordDetailDetailTableViewCell.h"
#import "DeliveryRecordDetailHeaderView.h"



@interface DeliveryRecordDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (retain, nonatomic) DeliveryRecordDetailHeaderView *headerView;


@property (retain, nonatomic) UIView *searchView;

@property (nonatomic) int pageSize;
@property (retain, nonatomic) NSMutableArray *resultArrar;

@property (retain, nonatomic) UIButton *rightBtn;



@end

@implementation DeliveryRecordDetailViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleLightContent;
    
    //    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [MyTools setViewController:self withNavigationBarColor:IMPORTANT_BACKGROUND andItem:@"" itemColor:BLACKCOLOR haveBackBtn:YES withBackImage:defaultBarBackImage_White withBackClickTarget:self BackClickAction:@selector(popViewClick)];
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self screenView];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
     [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
}
- (void)popViewClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)screenView{
    
    [_rightBtn removeFromSuperview];
    
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightBtn setFrame:CGRectMake(ScreenWidth-100-15, 13, 100, 28)];
    [_rightBtn setTitle:@"历史发货信息" forState:UIControlStateNormal];
    _rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_rightBtn setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
    _rightBtn.tag = 1;
    [_rightBtn addTarget:self action:@selector(screenClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:_rightBtn];
}

- (void)screenClicked {
    NSLog(@"历史发货信息");
    
//    DeliveryRecordDetailViewController *VC = [[DeliveryRecordDetailViewController alloc] initWithNibName:@"DeliveryRecordDetailViewController" bundle:nil];
//    VC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:VC animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self createTableView];
}

- (void)createTableView {
    //table view
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"F2F2F2"];
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-kTabBarHeight-kBottomSafeHeight) style:UITableViewStyleGrouped];
    _myTableView.backgroundColor = [UIColor colorWithHexString:@"F2F2F2"];
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.sectionFooterHeight = CGFLOAT_MIN;
    _myTableView.tableFooterView = [UIView new];
    [self.view addSubview:_myTableView];
    _myTableView.bounces = NO;
    
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
    
    return 265;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    return 226;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    _headerView = [[[NSBundle mainBundle] loadNibNamed:@"DeliveryRecordDetailHeaderView" owner:self options:nil] lastObject];
    [_headerView setFrame:CGRectMake(0, 0, ScreenWidth, 265)];
    _headerView.bgView.backgroundColor = IMPORTANT_BACKGROUND;
    _headerView.rootVC = self;
    [_headerView createView];
    
    return _headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *topCell = @"DeliveryRecordDetailDetailTableViewCell";
    DeliveryRecordDetailDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:topCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:topCell owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.titleLabel.text = [NSString stringWithFormat:@"发货批次%ld",indexPath.row+1];
    
    cell.numbelLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row*20];
    
    [cell.logisticsBtn setTitle:[NSString stringWithFormat:@"发货批次%ld",indexPath.row+1] forState:UIControlStateNormal];
    
//    cell.confirmBtn.tag = (int)indexPath.row;
//    [cell.confirmBtn addTarget:self action:@selector(confirmAndDetailBtnVlicked:) forControlEvents:UIControlEventTouchUpInside];
//
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

- (void)confirmAndDetailBtnVlicked:(UIButton *)button {
    
    if ([button.currentTitle isEqualToString:@"确认收货"]) {
        NSLog(@"确认收货");
        
    }
    
}


@end
