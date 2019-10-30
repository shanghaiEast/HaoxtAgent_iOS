//
//  MachinesProcurementViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/10/23.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "MachinesProcurementViewController.h"

#import "PurchasingApplicationViewController.h"
#import "ProcurementEnquiryViewController.h"
#import "DeliveryQueryViewController.h"
#import "DeliveryRecordViewController.h"

#import "ResultQueryTableViewCell.h"

@interface MachinesProcurementViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) int pageSize;
@property (retain, nonatomic) NSArray *imageArray, *titleArray;

@end

@implementation MachinesProcurementViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    //    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [MyTools setViewController:self withNavigationBarColor:WHITECOLOR andItem:@"机具采购" itemColor:BLACKCOLOR haveBackBtn:YES withBackImage:defaultBarBackImage_black withBackClickTarget:self BackClickAction:@selector(popViewClick)];
    
}
- (void)popViewClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    _titleArray = @[@"采购申请", @"采购申请查询", @"发货申请", @"发货查询", @"还款账单查询"];
    _imageArray = @[
                    [UIImage imageNamed:@"MachinesProcurement采购申请.png"],
                    [UIImage imageNamed:@"MachinesProcurement采购申请查询"],
                    [UIImage imageNamed:@"MachinesProcurement发货申请"],
                    [UIImage imageNamed:@"MachinesProcurement发货查询"],
                    [UIImage imageNamed:@"MachinesProcurement还款账单查询"]];
    
    [self createTableView];
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
    
    return _titleArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    return 90;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *nibString = @"ResultQueryTableViewCell";
    ResultQueryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nibString];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:nibString owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.titleLabel.text = [_titleArray objectAtIndex:indexPath.row];
    cell.imageView.image = [_imageArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    //采购申请
    if (indexPath.row == 0) {
        PurchasingApplicationViewController *VC = [[PurchasingApplicationViewController alloc] initWithNibName:@"PurchasingApplicationViewController" bundle:nil];
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    //采购申请查询
    if (indexPath.row == 1) {
        ProcurementEnquiryViewController *VC = [[ProcurementEnquiryViewController alloc] initWithNibName:@"ProcurementEnquiryViewController" bundle:nil];
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    //发货申请
    if (indexPath.row == 2) {
        DeliveryRecordViewController *VC = [[DeliveryRecordViewController alloc] initWithNibName:@"DeliveryRecordViewController" bundle:nil];
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    //发货查询
    if (indexPath.row == 3) {
        DeliveryQueryViewController *VC = [[DeliveryQueryViewController alloc] initWithNibName:@"DeliveryQueryViewController" bundle:nil];
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    //还款账单查询
    if (indexPath.row == 4) {
//        DeliveryQueryViewController *VC = [[DeliveryQueryViewController alloc] initWithNibName:@"DeliveryQueryViewController" bundle:nil];
//        VC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:VC animated:YES];
    }
}

@end
