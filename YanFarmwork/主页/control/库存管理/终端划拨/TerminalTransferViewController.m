//
//  TerminalTransferViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/10/22.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "TerminalTransferViewController.h"


#import "TerminalTransferTableViewCell.h"
#import "TerminalTransferHeaderView.h"



@interface TerminalTransferViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) int pageSize;
@property (retain, nonatomic) NSMutableArray *resultArray;
@property (retain, nonatomic) NSArray *numberArray;

@property (nonatomic) int batchCount;


@property (retain, nonatomic) TerminalTransferHeaderView *headerView;


@end

@implementation TerminalTransferViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
   
}
- (void)popViewClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
     [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _numberArray = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"十"];
    _batchCount = 1;
    
    [self createTableView];
}


- (void)createTableView {
    //table view
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-kBottomSafeHeight) style:UITableViewStyleGrouped];
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
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return _batchCount;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        if (_terminalType == terminal_qianyi) {
            return 288+kTopBarSafeHeight;
        }
        
        return 205+kTopBarSafeHeight;
    }
    return 120;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (section == 0) {
        if (_batchCount >= 10) {
            return CGFLOAT_MIN;
        }
        return 80;
    }
 
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    return 216;
   
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        
        if (_terminalType == terminal_qianyi) {
            _headerView = [[[NSBundle mainBundle] loadNibNamed:@"TerminalTransferQYHeaderView" owner:self options:nil] lastObject];
            [_headerView setFrame:CGRectMake(0, 0, ScreenWidth, 288+kTopBarSafeHeight)];
            _headerView.rootVC = self;
            [_headerView createView];
            
            
            return _headerView;
        }
        
        _headerView = [[[NSBundle mainBundle] loadNibNamed:@"TerminalTransferHeaderView" owner:self options:nil] lastObject];
        [_headerView setFrame:CGRectMake(0, 0, ScreenWidth, 205+kTopBarSafeHeight)];
        _headerView.rootVC = self;
        [_headerView createView];
        
        
        return _headerView;
    }
    
     if (section == 1) {
         UIView *confirmView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 120)];
         
         UIButton *confirmBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
         [confirmBtn setFrame:CGRectMake(20, 33, ScreenWidth-40, 55)];
         confirmBtn.layer.cornerRadius = 3;
         confirmBtn.layer.masksToBounds = YES;
         confirmBtn.titleLabel.font = [UIFont systemFontOfSize:20];
         confirmBtn.backgroundColor = IMPORTANT_BACKGROUND;
         [confirmBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
         [confirmBtn setTitle:@"确  定" forState:UIControlStateNormal];
         [confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
         [confirmView addSubview:confirmBtn];
         
         return confirmView;
     }
    
    
    return [UIView new];
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
     if (section == 0) {
         if (_batchCount == 10) {
             return [UIView new];
         }
         
         typeof(self) wSelf = self;
         _headerView = [[[NSBundle mainBundle] loadNibNamed:@"AddBatchView" owner:self options:nil] lastObject];
         [_headerView setFrame:CGRectMake(0, 0, ScreenWidth, 80)];
         _headerView.addBatchBlock = ^(BOOL clickBool) {
             
             if (wSelf.batchCount == 10) {
                 [ToolsObject showMessageTitle:@"已到达最多十级" andDelay:1 andImage:nil];
                 wSelf.headerView.hidden = YES;
                 return ;
             }
             
             wSelf.batchCount ++;
             
             [wSelf insertOrDelectCell:YES];
             
             //        [wSelf.myTableView reloadData];
             
         };
         
         return _headerView;
     }
    
    return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *nibString = @"TerminalTransferTableViewCell";
    TerminalTransferTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nibString];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:nibString owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    if ( indexPath.row == _batchCount-1 && _batchCount < 10) {
//        [cell.delectOrAddBtn setTitle:@"添加" forState:UIControlStateNormal];
//    }else{
//         [cell.delectOrAddBtn setTitle:@"删除" forState:UIControlStateNormal];
//    }
    
//    if (_batchCount == 1) {
//        cell.delectOrAddBtn.hidden = YES;
//    }
    
    cell.titleLabel.text = [NSString stringWithFormat:@"划拨批次%@",[_numberArray objectAtIndex:indexPath.row]];
    
    cell.delectOrAddBtn.tag = indexPath.row;
    [cell.delectOrAddBtn addTarget:self action:@selector(delectOrAddbtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.reductBtn.tag = indexPath.row;
    [cell.reductBtn addTarget:self action:@selector(reductBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.addBtn.tag = indexPath.row;
    [cell.addBtn addTarget:self action:@selector(addBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.numberLabelChangeBlock = ^(NSInteger num) {
        NSLog(@"台数变化block返回：%ld", num);
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
}

//删除或添加
- (void)delectOrAddbtnClicked:(UIButton *)button {
    NSLog(@"台数删除或添加");
    if ( [button.currentTitle isEqualToString:@"添加"]) {
        _batchCount ++;
        
        [self insertOrDelectCell:YES];
       
    }else{
        _batchCount --;
        
         [self insertOrDelectCell:NO];
    }
    
//    [_myTableView reloadData];
}
- (void)insertOrDelectCell:(BOOL)addCellBool {
//    if (addCellBool == YES) {
//        //数据源添加后 给tableView 指定行添加数据
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_batchCount-2 inSection:0];
//        [_myTableView insertRowsAtIndexPaths:@[indexPath]  withRowAnimation:UITableViewRowAnimationBottom];
//        // 滚动到最后一行
//        [_myTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
//
//    }else{
//        //数据源添加后 给tableView 指定行删除数据
//        if (_batchCount-1 < 0) {
//            [_myTableView reloadData];
//            return;
//        }
//
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_batchCount-1 inSection:0];
//        [_myTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
//        // 滚动到最后一行
//        [_myTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
//    }
    
    
    [_myTableView reloadData];
    
}

//台数加
- (void)addBtnClicked:(UIButton *)button {
    NSLog(@"台数加");
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:button.tag inSection:0];
    TerminalTransferTableViewCell *cell =(TerminalTransferTableViewCell *)[self.myTableView cellForRowAtIndexPath:indexPath];

    int numC = [cell.numberLabel.text intValue];
    cell.numberLabel.text = [NSString stringWithFormat:@"%d",numC+1];
}

//台数减
- (void)reductBtnClicked:(UIButton *)button {
    NSLog(@"台数减");
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:button.tag inSection:0];
    TerminalTransferTableViewCell *cell =(TerminalTransferTableViewCell *)[self.myTableView cellForRowAtIndexPath:indexPath];
    
    int numC = [cell.numberLabel.text intValue];
    if (numC == 0) {
        [ToolsObject showMessageTitle:@"不能再减了" andDelay:1 andImage:nil];
        return;
    }
    cell.numberLabel.text = [NSString stringWithFormat:@"%d",numC-1];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//确     定
- (void)confirmBtnClick {
    NSLog(@"确     定");
}

@end
