//
//  PartnersViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/10/21.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "PartnersViewController.h"

#import "PartnersTableViewCell.h"
#import "PartnerSearchViewController.h"

@interface PartnersViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (retain, nonatomic) NSArray *titleOneArrar, *titleTwoArrar, *picturArray;

@end

@implementation PartnersViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    [MyTools setViewController:self withNavigationBarColor:WHITECOLOR andItem:@"服务商管理" itemColor:BLACKCOLOR haveBackBtn:YES withBackImage:defaultBarBackImage_black withBackClickTarget:self BackClickAction:@selector(popViewClick)];

}
- (void)popViewClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _roleInt = SALESMAN;
    
    [self createTableView];
}

- (void)createTableView {
    //table view
    
    if (_roleInt == PARTNER) {
        _titleOneArrar = @[@"邀请合作合伙伴", @"合作伙伴查询", ];
        _titleTwoArrar = @[@"一起赚钱，一起飞", @"合作伙伴信息查询并完善"];
        _picturArray = @[@"row_one.png", @"row_two.png"];
    }else{
        _titleOneArrar = @[ @"邀请业务员", @"业务员查询"];
        _titleTwoArrar = @[ @"一起发展，一起赚钱", @"业务员信息查询并完善"];
        _picturArray = @[ @"row_three.png", @"row_four.png"];
    }
    
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
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _titleOneArrar.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    return 74;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *topCell = @"PartnersTableViewCell";
    PartnersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:topCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:topCell owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.leftImageView.image = [UIImage imageNamed:[_picturArray objectAtIndex:indexPath.row]];
    
    cell.titleOneLabel.text = [NSString stringWithFormat:@"%@",[_titleOneArrar objectAtIndex:indexPath.row]];
    
     cell.titleTwoLabel.text = [NSString stringWithFormat:@"%@",[_titleTwoArrar objectAtIndex:indexPath.row]];
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
     if (_roleInt == PARTNER) {
         if (indexPath.row == 0) {
             
         }
         if (indexPath.row == 1) {
             PartnerSearchViewController *partnerSerchVC = [[PartnerSearchViewController alloc] initWithNibName:@"PartnerSearchViewController" bundle:nil];
             partnerSerchVC.roleInt = PARTNER;
             partnerSerchVC.hidesBottomBarWhenPushed = YES;
             [self.navigationController pushViewController:partnerSerchVC animated:YES];
         }
     }else{
         if (indexPath.row == 0) {
             
         }
         if (indexPath.row == 1) {
             PartnerSearchViewController *partnerSerchVC = [[PartnerSearchViewController alloc] initWithNibName:@"PartnerSearchViewController" bundle:nil];
              partnerSerchVC.roleInt = SALESMAN;
             partnerSerchVC.hidesBottomBarWhenPushed = YES;
             [self.navigationController pushViewController:partnerSerchVC animated:YES];
         }
     }
    
    
    
    
}


@end
