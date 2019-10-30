//
//  InventoryManagementDetailViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/10/23.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "InventoryManagementDetailViewController.h"

#import "NormalTableViewCell.h"
#import "MachineSearchDetailTableViewCell.h"

@interface InventoryManagementDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) int pageSize;
@property (retain, nonatomic) NSMutableArray *keyArray, *valueArray;


@end

@implementation InventoryManagementDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    //    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [MyTools setViewController:self withNavigationBarColor:WHITECOLOR andItem:@"库存详情" itemColor:BLACKCOLOR haveBackBtn:YES withBackImage:defaultBarBackImage_black withBackClickTarget:self BackClickAction:@selector(popViewClick)];
    
}
- (void)popViewClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSArray *one = @[@"机具号"];
    NSArray *two = @[@"入库时间", @"分配时间", @"激活时间"];
    NSArray *three = @[@"激活时间"];
    _keyArray = @[one, two, three];
    
    
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
    return _keyArray.count + 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section != 3) {
        return [[_keyArray objectAtIndex:section] count];
    }
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    return 70;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    view.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section != 3) {
        static NSString *nibString = @"NormalTableViewCell";;
        NormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nibString];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:nibString owner:self options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.titleLabel.text = [[_keyArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        
        return cell;
    }
    
    if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            static NSString *nibString = @"MachineSearchDetailTableViewCell";
            MachineSearchDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nibString];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:nibString owner:self options:nil] lastObject];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.headTitle_threeLabel.text = @"合作伙伴名称";
            
            return cell;
        }
        static NSString *nibString = @"MachineSearchDetailListTableViewCell";
        MachineSearchDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nibString];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:nibString owner:self options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //indexPath.row要减1
        
        return cell;
    }
    
    
    
    
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


@end
