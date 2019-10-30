//
//  PartnerDetailViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/10/21.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "PartnerDetailViewController.h"

#import "PartnerDetaliTableViewCell.h"

@interface PartnerDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (retain, nonatomic) NSMutableArray *resultArrar;

@property (retain, nonatomic) NSArray *keyArray, *valueArray;

@end

@implementation PartnerDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    [MyTools setViewController:self withNavigationBarColor:WHITECOLOR andItem:@"基本信息" itemColor:BLACKCOLOR haveBackBtn:YES withBackImage:defaultBarBackImage_black withBackClickTarget:self BackClickAction:@selector(popViewClick)];
    
}
- (void)popViewClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    NSArray *sectionOneKeyArray = [[NSArray alloc] initWithObjects:@"合作伙伴名称",@"手机号",@"身份证号码", nil];
    NSArray *sectionTwoKeyArray = [[NSArray alloc] initWithObjects:@"开户银行",@"支行信息",@"银行卡号", nil];
    _keyArray = @[sectionOneKeyArray, sectionTwoKeyArray];
    
    
    [self createTableView];
}

- (void)createTableView {
    //table view
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-kTabBarHeight) style:UITableViewStylePlain];
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
    return _keyArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[_keyArray objectAtIndex:section] count];
    //    return _resultArrar.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
 
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    view.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *topCell = @"PartnerDetaliTableViewCell";
    
    PartnerDetaliTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:topCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PartnerDetaliTableViewCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
 
    cell.keyLabel.text = [[_keyArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    cell.valueTextField.userInteractionEnabled = NO;
    cell.valueTextField.enabled = NO;
    cell.valueTextField.text = @"test";
    
    
    return cell;
    
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
