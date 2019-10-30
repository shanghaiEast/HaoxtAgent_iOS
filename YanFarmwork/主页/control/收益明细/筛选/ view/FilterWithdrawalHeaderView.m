//
//  FilterWithdrawalHeaderView.m
//  YanFarmwork
//
//  Created by HG on 2019/10/24.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "FilterWithdrawalHeaderView.h"

#import "FilterTimeView.h"


@interface FilterWithdrawalHeaderView ()

@property (retain, nonatomic) FilterTimeView *timeView;

@end

@implementation FilterWithdrawalHeaderView

//单边边框(底边)
- (void)createBtnBottomBorder:(UIButton *)button {
    CALayer *BtnBorder = [CALayer layer];
    float height=button.frame.size.height;
    float width=button.frame.size.width;
    BtnBorder.frame = CGRectMake(0, height, width, 2);
    BtnBorder.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"].CGColor;
    [button.layer addSublayer:BtnBorder];
}
- (NSString *)dateToday {
    //将日期转换成需要的样式
    NSDateFormatter* YMD = [[NSDateFormatter alloc]init];
    [YMD setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [NSDate date];
    NSString *dateString = [YMD stringFromDate:date];
    
    NSLog(@"时间：%@",dateString);
    
    return dateString;
}

- (void)createView {
    typeof(self) wSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self createBtnBottomBorder:wSelf.startTimeBtn];
        [self createBtnBottomBorder:wSelf.endTimeBtn];
        [wSelf createStateBtn];
        [wSelf createAgentBtn];
    });

    
    [_startTimeBtn setTitle:[self dateToday] forState:UIControlStateNormal];
    [_endTimeBtn setTitle:[self dateToday] forState:UIControlStateNormal];
    
}

//靠边等距排列
- (void)createStateBtn{
    
    NSArray *stateArray = @[@"全选",@"交易分润",@"激活返现",@"快提返现"];
    float btnWidth = 70;
    float btnHeight = 30;
    float clearanceWidth = (_stateView.frame.size.width-btnWidth*4)/3;
    
    for (int i = 0; i < stateArray.count; i ++) {
        float a = i/4;//0,0,0,0,1,1
        float b = i%4;//0,1,2,3,0,1
        
        UIButton *stateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [stateBtn setFrame:CGRectMake(clearanceWidth*b+btnWidth*b, 20*a+btnHeight*a, btnWidth, btnHeight)];
        stateBtn.tag = i;
        stateBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [stateBtn setTitle:[stateArray objectAtIndex:i] forState:UIControlStateNormal];
        stateBtn.layer.cornerRadius = 3.0f;
        stateBtn.layer.masksToBounds = YES;
        if (_stateTag == i) {
            [stateBtn setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
            [stateBtn setBackgroundColor:[UIColor colorWithHexString:@"#FE4049"]];
        }else{
            [stateBtn setTitleColor:[UIColor colorWithHexString:@"#555555"] forState:UIControlStateNormal];
            [stateBtn setBackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"]];
        }
        [stateBtn addTarget:self action:@selector(stateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_stateView addSubview:stateBtn];
        
        
    }
}
//靠边等距排列
- (void)createAgentBtn{
    
    NSArray *stateArray = @[@"全部",@"待审核",@"审核通过",@"驳回"];
    float btnWidth = 70;
    float btnHeight = 30;
    float clearanceWidth = (_agentView.frame.size.width-btnWidth*4)/3;
    
    for (int i = 0; i < stateArray.count; i ++) {
        float a = i/4;//0,0,0,0,1,1
        float b = i%4;//0,1,2,3,0,1
        
        UIButton *stateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [stateBtn setFrame:CGRectMake(clearanceWidth*b+btnWidth*b, 20*a+btnHeight*a, btnWidth, btnHeight)];
        stateBtn.tag = i;
        stateBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [stateBtn setTitle:[stateArray objectAtIndex:i] forState:UIControlStateNormal];
        stateBtn.layer.cornerRadius = 3.0f;
        stateBtn.layer.masksToBounds = YES;
        if (_agentTag == i) {
            [stateBtn setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
            [stateBtn setBackgroundColor:[UIColor colorWithHexString:@"#FE4049"]];
        }else{
            [stateBtn setTitleColor:[UIColor colorWithHexString:@"#555555"] forState:UIControlStateNormal];
            [stateBtn setBackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"]];
        }
        [stateBtn addTarget:self action:@selector(agentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_agentView addSubview:stateBtn];
        
        
    }
}
- (void)stateBtnClick:(UIButton *)button {
    _stateTag = (int)button.tag;
    [self createStateBtn];
    
}

- (void)agentBtnClick:(UIButton *)button {
    _agentTag = (int)button.tag;
    [self createAgentBtn];

}

- (void)createDateView:(int)tag{
    typeof(self) wSelf = self;
    
    _timeView = [[[NSBundle mainBundle] loadNibNamed:@"FilterTimeView" owner:self options:nil] lastObject];
    _timeView.buttonTag = tag;
    [_timeView setFrame:_rootVC.view.bounds];
    [_timeView createView];
    [_rootVC.view addSubview:_timeView];
    _timeView.startTimeBolck = ^(NSString * _Nonnull startTimeString) {
        NSLog(@"startTimeBolck: %@",startTimeString);
        if (startTimeString.length == 0) {
            return ;
        }
        [_startTimeBtn setTitle:startTimeString forState:UIControlStateNormal];
    };
    _timeView.endTimeBolck = ^(NSString * _Nonnull endTimeString) {
        NSLog(@"endTimeBolck: %@",endTimeString);
        if (endTimeString.length == 0) {
            return ;
        }
        [_endTimeBtn setTitle:endTimeString forState:UIControlStateNormal];
    };
}


-(BOOL)dateCompare
{
    NSString *startDateString = _startTimeBtn.currentTitle;
    NSString *endDateString = _endTimeBtn.currentTitle;

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd"];

    NSDate *startDate=[formatter dateFromString:startDateString];
    NSDate *endDate=[formatter dateFromString:endDateString];
    NSComparisonResult result=[endDate compare:startDate];

    switch (result) {
        case NSOrderedAscending: {
            NSLog(@"FlyElephant:%@--时间小于---%@",startDate,endDate);
            break;

            return NO;
        }
        case NSOrderedSame: {
            NSLog(@"FlyElephant:%@--时间等于---%@",startDate,endDate);

            return YES;

            break;
        }
        case NSOrderedDescending: {
            NSLog(@"FlyElephant:%@--时间大于---%@",startDate,endDate);

            return YES;

            break;
        }
    }

    return NO;
}



- (IBAction)timeBtnClick:(id)sender {
    NSLog(@"时间选择");
    UIButton *button = (id)sender;
    [self createDateView:(int)button.tag];
}

- (IBAction)confireBtnClicked:(id)sender {
    NSLog(@"确定");
    
    if ([self dateCompare] == NO) {
        [ToolsObject showMessageTitle:@"起始时间不能小于结束时间" andDelay:1.0 andImage:nil];
        
        return;
    }
    
    
}
@end
