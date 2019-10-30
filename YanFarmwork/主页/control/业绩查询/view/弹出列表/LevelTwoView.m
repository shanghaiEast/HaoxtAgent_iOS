//
//  LevelTwoView.m
//  YanFarmwork
//
//  Created by HG on 2019/10/24.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "LevelTwoView.h"


#import "LevelTwoTableViewCell.h"


@interface LevelTwoView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) int pageSize;
@property (retain, nonatomic) NSMutableArray *titleArray, *selectRowArray;

@end


@implementation LevelTwoView


- (void)createView {
//    typeof(self) wSelf = self;
    _selectRowArray = [[NSMutableArray alloc] init];
    _titleArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 10; i ++) {
        NSDictionary *tempDict = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"text:%d",i],@"test", nil];
        [_titleArray addObject:tempDict];
    }
  
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self createTableView];
    });
    
    
}

- (void)createTableView {
    //table view
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, _listView.frame.size.width, _listView.frame.size.height-40) style:UITableViewStylePlain];
    _myTableView.backgroundColor = [UIColor whiteColor];
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.sectionFooterHeight = CGFLOAT_MIN;
    _myTableView.tableFooterView = [UIView new];
    [_listView addSubview:_myTableView];
    
    if (@available(iOS 11.0, *)) {
        _myTableView.estimatedRowHeight = 0;
        _myTableView.estimatedSectionFooterHeight = 0;
        _myTableView.estimatedSectionHeaderHeight = 0;
        _myTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
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
    
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *nibString = @"LevelTwoTableViewCell";
    LevelTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nibString];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:nibString owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.titlelabel.text = [NSString stringWithFormat:@"%@",[[_titleArray objectAtIndex:indexPath.row] objectForKey:@"test"]];
    
    if ([self checkHaveRow:(int)indexPath.row canEdit:NO] == YES) {
        cell.dianImageView.backgroundColor = IMPORTANT_BACKGROUND;
    }else{
         cell.dianImageView.backgroundColor = WHITECOLOR;
    }

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    [self checkHaveRow:(int)indexPath.row canEdit:YES];
    
    
    [_myTableView reloadData];
    
    
    
   
//    if (_rowClickedBlock) {
//        _rowClickedBlock([_titleArray objectAtIndex:indexPath.row]);
//    }
//
//    [self removeFromSuperview];
    
}

//检查是否选h中，及选中后是否可编辑
- (BOOL)checkHaveRow:(int)index canEdit:(BOOL)editBool{
    BOOL haveSelectRow = NO;
    for (int i = 0; i < _selectRowArray.count; i ++) {
        int selectRowInt = [[_selectRowArray objectAtIndex:i] intValue];
        if (selectRowInt == (int)index) {
            haveSelectRow = YES;
            
            if (editBool == YES) {
                [_selectRowArray removeObjectAtIndex:i];
            }
            
            break;
        }
    }
    
    if (haveSelectRow == NO) {
        if (editBool == YES) {
             [_selectRowArray addObject:[NSString stringWithFormat:@"%d",index]];
        }
       
    }
    NSLog(@"_selectRowArray: %@", _selectRowArray);
    
    return haveSelectRow;
}

- (IBAction)cancelBtnOrConfireBtnClicked:(id)sender {
    
    UIButton *button = (id)sender;
    if (button.tag == 0) {
        [_selectRowArray removeAllObjects];
        [self removeFromSuperview];
        
    }else{
        if (_selectRowArray.count == 0) {
            [ToolsObject showMessageTitle:@"您没有选中列表数据" andDelay:1 andImage:nil];
            return;
        }
        
        if (_confirmClickedBlock) {
            _confirmClickedBlock(_selectRowArray);
        }
        
         [self removeFromSuperview];
    }
    
}
@end
