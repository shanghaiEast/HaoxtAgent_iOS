//
//  MachineSearchDetailViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/10/22.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "MachineSearchDetailViewController.h"


#import "MachineSearchDetailTableViewCell.h"
#import "NormalTableViewCell.h"



@interface MachineSearchDetailViewController ()<UITableViewDelegate, UITableViewDataSource>


@property (nonatomic) int pageSize;
@property (retain, nonatomic) NSMutableArray *resultArray;

@end

@implementation MachineSearchDetailViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    //    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [MyTools setViewController:self withNavigationBarColor:WHITECOLOR andItem:@"终端详情" itemColor:BLACKCOLOR haveBackBtn:YES withBackImage:defaultBarBackImage_black withBackClickTarget:self BackClickAction:@selector(popViewClick)];
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
}
- (void)popViewClick{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self createTableView];
}


- (void)createTableView {
    //table view
    
    UIView *lineView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    [self.view addSubview:lineView];
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, ScreenWidth, ScreenHeight-kTabBarHeight-10-kBottomSafeHeight) style:UITableViewStyleGrouped];
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
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    
    if (section == 1) {
        return 0;
    }
    
    if (section == 2) {
        return 10 + 1;//第一组为头部
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return CGFLOAT_MIN;
    }
    
   
    if (section == 1) {
        int rowNum = 3;//一行显示item
        float width = (ScreenWidth-2)/rowNum;//item高
        float height  = width*0.6;//item宽
        
        return height*2+2+45;
    }
    
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 60;
    }
    
    if (indexPath.section == 1) {
        return 0;
    }
    
    if (indexPath.section == 2) {
        return 40;
    }
    
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 1) {
        int rowNum = 3;//一行显示item
        float width = (ScreenWidth-2)/rowNum;//item高
        float height  = width*0.6;//item宽
        
        UIView *headView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, height*2+2+45)];
        headView.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(15,0,ScreenWidth-30,45);
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
        label.text = @"费率信息";
        [headView addSubview:label];
        
        [self createBlockView:headView];
        
        return headView;
    }
    
    if (section == 2) {
        UIView *headView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 45)];
        headView.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(15,0,ScreenWidth-30,45);
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
        label.text = @"归属层级";
        [headView addSubview:label];
        
        return headView;
    }
    
    return [UIView new];
}

- (void)createBlockView:(UIView *)myView {
    NSArray *titleArray = @[@"借记卡费率(%)",@"支付宝费率(%)",@"闪付费率(%)",@"微信费率(%)",@"贷记卡费率(%)"];
    
    int rowNum = 3;//一行显示item
    float width = (ScreenWidth-2)/rowNum;//item高
    float height  = width*0.6;//item宽
    
    UIView *blockView = [[UIView alloc] initWithFrame:CGRectMake(0, 45, ScreenWidth, height*2+2)];
    
    [myView addSubview:blockView];
    
    
    for (int i = 0; i < titleArray.count; i ++) {
        int remainder = i%rowNum;//余数0,1,2,0,
        int integerder = i/rowNum;//整数0,0,0,1
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(width*remainder+remainder*1, height*integerder+integerder*1, width, height)];
        view.backgroundColor = [UIColor whiteColor];
        [blockView addSubview:view];
        
        UILabel *valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (height-40)/2, width, 20)];
        valueLabel.textAlignment = NSTextAlignmentCenter;
        valueLabel.font = [UIFont systemFontOfSize:16];
        valueLabel.textColor = IMPORTANT_TEXT;
        valueLabel.text = @"0.45";
        [view addSubview:valueLabel];
        
        UILabel *keyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (height-40)/2+25, width, 15)];
        keyLabel.textAlignment = NSTextAlignmentCenter;
        keyLabel.font = [UIFont systemFontOfSize:12];
        keyLabel.textColor = NORMAL_TEXT_LEVEL_1;
        keyLabel.text = [titleArray objectAtIndex:i];
        [view addSubview:keyLabel];
        
        
       
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        static NSString *nibString = @"NormalTableViewCell";
        NormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nibString];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:nibString owner:self options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
         NSArray *array = @[@"基础信息(SN)", @"绑定状态"];
        
        cell.titleLabel.text = [array objectAtIndex:indexPath.row];
        
        cell.detailTextLabel.text = @"12345";
        
        if (array.count-1 == indexPath.row) {
            cell.lineLabel.hidden = YES;
        }
        
        return cell;
    }
    
    if (indexPath.section == 1) {
        
    }
    
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            static NSString *nibString = @"MachineSearchDetailTableViewCell";
            MachineSearchDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nibString];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:nibString owner:self options:nil] lastObject];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
