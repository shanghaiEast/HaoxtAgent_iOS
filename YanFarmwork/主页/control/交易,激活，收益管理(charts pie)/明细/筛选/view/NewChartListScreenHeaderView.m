//
//  NewChartListScreenHeaderView.m
//  YanFarmwork
//
//  Created by HG on 2019/10/24.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "NewChartListScreenHeaderView.h"

#import "FilterTimeView.h"


@interface NewChartListScreenHeaderView ()

@property (retain, nonatomic) FilterTimeView *timeView;

@property ( nonatomic) int stateTag, typeTag, jiHuoTag, cardTag, agentTag, typeSYTag, timeTag, liRuntag;

@property (retain, nonatomic) NSArray *stateArray, *typeArray, *jiHuoArray, *cardArray, *agentArray, *typeSYArray, *timeArray, *liRunArray;

@end

@implementation NewChartListScreenHeaderView

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
         if (wSelf.screenViewType == screen_view_LIST_JIAOYI) {
            [wSelf createStateBtn];
            [wSelf createTypeBtn];
            [wSelf createJiHuoBtn];
            [wSelf createCardBtn];
            [wSelf createAgentBtn];
        }
        if (wSelf.screenViewType == screen_view_LIST_JIHUO) {
            [wSelf createStateBtn];
            [wSelf createTypeBtn];
        }
        if (wSelf.screenViewType == screen_view_LIST_SHOUYI) {
            [wSelf createTypeSYBtn];
        }
        if (wSelf.screenViewType == screen_view_LIST_TUANDUI) {
            [self createTimeTDBtn];
            [self createLiRunBtn];
        }
//        [wSelf createStateBtn];
//         [wSelf createTypeBtn];
//         [wSelf createJiHuoBtn];
//         [wSelf createCardBtn];
//        [wSelf createAgentBtn];
    });
    
    
    [_startTimeBtn setTitle:[self dateToday] forState:UIControlStateNormal];
    [_endTimeBtn setTitle:[self dateToday] forState:UIControlStateNormal];
    
}

//靠边等距排列
- (void)createStateBtn{
    
    _stateArray = @[@"全部",@"成功",@"失败"];
    float btnWidth = 70;
    float btnHeight = 30;
    float clearanceWidth = (_stateView.frame.size.width-btnWidth*4)/3;
    
    for (int i = 0; i < _stateArray.count; i ++) {
        float a = i/4;//0,0,0,0,1,1
        float b = i%4;//0,1,2,3,0,1
        
        UIButton *stateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [stateBtn setFrame:CGRectMake(clearanceWidth*b+btnWidth*b, 20*a+btnHeight*a, btnWidth, btnHeight)];
        stateBtn.tag = i;
        stateBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [stateBtn setTitle:[_stateArray objectAtIndex:i] forState:UIControlStateNormal];
        stateBtn.layer.cornerRadius = 3.0f;
        stateBtn.layer.masksToBounds = YES;
        if (_stateTag == i) {
            [stateBtn setTitleColor:IMPORTANT_BACKGROUND forState:UIControlStateNormal];
            [stateBtn setBackgroundColor:[UIColor colorWithHexString:@"#FEF8F8"]];
            stateBtn.layer.borderWidth = 1;
            stateBtn.layer.borderColor = [IMPORTANT_BACKGROUND CGColor];
        }else{
            [stateBtn setTitleColor:[UIColor colorWithHexString:@"#555555"] forState:UIControlStateNormal];
            [stateBtn setBackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"]];
            stateBtn.layer.borderWidth = 0;
        }
        [stateBtn addTarget:self action:@selector(stateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_stateView addSubview:stateBtn];
        
        
    }
}
//靠边等距排列
- (void)createTypeBtn{
    
    _typeArray = @[@"全部",@"刷卡",@"支付宝",@"微信",@"云闪付"];
    float btnWidth = 70;
    float btnHeight = 30;
    float clearanceWidth = (_typeView.frame.size.width-btnWidth*4)/3;
    
    for (int i = 0; i < _typeArray.count; i ++) {
        float a = i/4;//0,0,0,0,1,1
        float b = i%4;//0,1,2,3,0,1
        
        UIButton *stateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [stateBtn setFrame:CGRectMake(clearanceWidth*b+btnWidth*b, 20*a+btnHeight*a, btnWidth, btnHeight)];
        stateBtn.tag = i;
        stateBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [stateBtn setTitle:[_typeArray objectAtIndex:i] forState:UIControlStateNormal];
        stateBtn.layer.cornerRadius = 3.0f;
        stateBtn.layer.masksToBounds = YES;
        if (_typeTag == i) {
            [stateBtn setTitleColor:IMPORTANT_BACKGROUND forState:UIControlStateNormal];
            [stateBtn setBackgroundColor:[UIColor colorWithHexString:@"#FEF8F8"]];
            stateBtn.layer.borderWidth = 1;
            stateBtn.layer.borderColor = [IMPORTANT_BACKGROUND CGColor];
        }else{
            [stateBtn setTitleColor:[UIColor colorWithHexString:@"#555555"] forState:UIControlStateNormal];
            [stateBtn setBackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"]];
            stateBtn.layer.borderWidth = 0;
        }
        [stateBtn addTarget:self action:@selector(typeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_typeView addSubview:stateBtn];
        
        
    }
}
//靠边等距排列
- (void)createJiHuoBtn{
    
    _jiHuoArray = @[@"全选",@"是",@"否"];
    float btnWidth = 70;
    float btnHeight = 30;
    float clearanceWidth = (_jiHuoView.frame.size.width-btnWidth*4)/3;
    
    for (int i = 0; i < _jiHuoArray.count; i ++) {
        float a = i/4;//0,0,0,0,1,1
        float b = i%4;//0,1,2,3,0,1
        
        UIButton *stateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [stateBtn setFrame:CGRectMake(clearanceWidth*b+btnWidth*b, 20*a+btnHeight*a, btnWidth, btnHeight)];
        stateBtn.tag = i;
        stateBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [stateBtn setTitle:[_jiHuoArray objectAtIndex:i] forState:UIControlStateNormal];
        stateBtn.layer.cornerRadius = 3.0f;
        stateBtn.layer.masksToBounds = YES;
        if (_jiHuoTag == i) {
            [stateBtn setTitleColor:IMPORTANT_BACKGROUND forState:UIControlStateNormal];
            [stateBtn setBackgroundColor:[UIColor colorWithHexString:@"#FEF8F8"]];
            stateBtn.layer.borderWidth = 1;
            stateBtn.layer.borderColor = [IMPORTANT_BACKGROUND CGColor];
        }else{
            [stateBtn setTitleColor:[UIColor colorWithHexString:@"#555555"] forState:UIControlStateNormal];
            [stateBtn setBackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"]];
            stateBtn.layer.borderWidth = 0;
        }
        [stateBtn addTarget:self action:@selector(jiHuoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_jiHuoView addSubview:stateBtn];
        
        
    }
}
//靠边等距排列
- (void)createCardBtn{
    
    _cardArray = @[@"全选",@"借记卡",@"贷记卡"];
    float btnWidth = 70;
    float btnHeight = 30;
    float clearanceWidth = (_cardView.frame.size.width-btnWidth*4)/3;
    
    for (int i = 0; i < _cardArray.count; i ++) {
        float a = i/4;//0,0,0,0,1,1
        float b = i%4;//0,1,2,3,0,1
        
        UIButton *stateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [stateBtn setFrame:CGRectMake(clearanceWidth*b+btnWidth*b, 20*a+btnHeight*a, btnWidth, btnHeight)];
        stateBtn.tag = i;
        stateBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [stateBtn setTitle:[_cardArray objectAtIndex:i] forState:UIControlStateNormal];
        stateBtn.layer.cornerRadius = 3.0f;
        stateBtn.layer.masksToBounds = YES;
        if (_cardTag == i) {
            [stateBtn setTitleColor:IMPORTANT_BACKGROUND forState:UIControlStateNormal];
            [stateBtn setBackgroundColor:[UIColor colorWithHexString:@"#FEF8F8"]];
            stateBtn.layer.borderWidth = 1;
            stateBtn.layer.borderColor = [IMPORTANT_BACKGROUND CGColor];
        }else{
            [stateBtn setTitleColor:[UIColor colorWithHexString:@"#555555"] forState:UIControlStateNormal];
            [stateBtn setBackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"]];
            stateBtn.layer.borderWidth = 0;
        }
        [stateBtn addTarget:self action:@selector(cardBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_cardView addSubview:stateBtn];
        
        
    }
}
//靠边等距排列
- (void)createAgentBtn{
    
    _agentArray = @[@"全部",@"我的",@"下级"];
    float btnWidth = 70;
    float btnHeight = 30;
    float clearanceWidth = (_agentView.frame.size.width-btnWidth*4)/3;
    
    for (int i = 0; i < _agentArray.count; i ++) {
        float a = i/4;//0,0,0,0,1,1
        float b = i%4;//0,1,2,3,0,1
        
        UIButton *stateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [stateBtn setFrame:CGRectMake(clearanceWidth*b+btnWidth*b, 20*a+btnHeight*a, btnWidth, btnHeight)];
        stateBtn.tag = i;
        stateBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [stateBtn setTitle:[_agentArray objectAtIndex:i] forState:UIControlStateNormal];
        stateBtn.layer.cornerRadius = 3.0f;
        stateBtn.layer.masksToBounds = YES;
        if (_agentTag == i) {
            [stateBtn setTitleColor:IMPORTANT_BACKGROUND forState:UIControlStateNormal];
            [stateBtn setBackgroundColor:[UIColor colorWithHexString:@"#FEF8F8"]];
            stateBtn.layer.borderWidth = 1;
            stateBtn.layer.borderColor = [IMPORTANT_BACKGROUND CGColor];
        }else{
            [stateBtn setTitleColor:[UIColor colorWithHexString:@"#555555"] forState:UIControlStateNormal];
            [stateBtn setBackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"]];
            stateBtn.layer.borderWidth = 0;
        }
        [stateBtn addTarget:self action:@selector(agentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_agentView addSubview:stateBtn];
        
        
    }
}
//靠边等距排列
- (void)createTypeSYBtn{
    
    _typeSYArray = @[@"激活返现",@"交易分润",@"预支分润",@"税费",@"提现退款",@"调账",@"提现",@"提现手续费",@"转账",@"充值"];
    float btnWidth = 70;
    float btnHeight = 30;
    float clearanceWidth = (_typeSYView.frame.size.width-btnWidth*4)/3;
    
    for (int i = 0; i < _typeSYArray.count; i ++) {
        float a = i/4;//0,0,0,0,1,1
        float b = i%4;//0,1,2,3,0,1
        
        UIButton *stateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [stateBtn setFrame:CGRectMake(clearanceWidth*b+btnWidth*b, 20*a+btnHeight*a, btnWidth, btnHeight)];
        stateBtn.tag = i;
        stateBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [stateBtn setTitle:[_typeSYArray objectAtIndex:i] forState:UIControlStateNormal];
        stateBtn.layer.cornerRadius = 3.0f;
        stateBtn.layer.masksToBounds = YES;
        if (_typeSYTag == i) {
            [stateBtn setTitleColor:IMPORTANT_BACKGROUND forState:UIControlStateNormal];
            [stateBtn setBackgroundColor:[UIColor colorWithHexString:@"#FEF8F8"]];
            stateBtn.layer.borderWidth = 1;
            stateBtn.layer.borderColor = [IMPORTANT_BACKGROUND CGColor];
        }else{
            [stateBtn setTitleColor:[UIColor colorWithHexString:@"#555555"] forState:UIControlStateNormal];
            [stateBtn setBackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"]];
            stateBtn.layer.borderWidth = 0;
        }
        [stateBtn addTarget:self action:@selector(typeSYBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_typeSYView addSubview:stateBtn];
        
        
    }
}
//靠边等距排列
- (void)createTimeTDBtn{
    
    _timeArray = @[@"默认",@"有远及近",@"由近及远"];
    float btnWidth = 70;
    float btnHeight = 30;
    float clearanceWidth = (_timeTDView.frame.size.width-btnWidth*4)/3;
    
    for (int i = 0; i < _timeArray.count; i ++) {
        float a = i/4;//0,0,0,0,1,1
        float b = i%4;//0,1,2,3,0,1
        
        UIButton *stateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [stateBtn setFrame:CGRectMake(clearanceWidth*b+btnWidth*b, 20*a+btnHeight*a, btnWidth, btnHeight)];
        stateBtn.tag = i;
        stateBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [stateBtn setTitle:[_timeArray objectAtIndex:i] forState:UIControlStateNormal];
        stateBtn.layer.cornerRadius = 3.0f;
        stateBtn.layer.masksToBounds = YES;
        if (_timeTag == i) {
            [stateBtn setTitleColor:IMPORTANT_BACKGROUND forState:UIControlStateNormal];
            [stateBtn setBackgroundColor:[UIColor colorWithHexString:@"#FEF8F8"]];
            stateBtn.layer.borderWidth = 1;
            stateBtn.layer.borderColor = [IMPORTANT_BACKGROUND CGColor];
        }else{
            [stateBtn setTitleColor:[UIColor colorWithHexString:@"#555555"] forState:UIControlStateNormal];
            [stateBtn setBackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"]];
            stateBtn.layer.borderWidth = 0;
        }
        [stateBtn addTarget:self action:@selector(timeTDBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_timeTDView addSubview:stateBtn];
        
        
    }
}
//靠边等距排列
- (void)createLiRunBtn{
    
   _liRunArray = @[@"默认",@"由多到少",@"由少到多"];
    float btnWidth = 70;
    float btnHeight = 30;
    float clearanceWidth = (_liRunView.frame.size.width-btnWidth*4)/3;
    
    for (int i = 0; i < _liRunArray.count; i ++) {
        float a = i/4;//0,0,0,0,1,1
        float b = i%4;//0,1,2,3,0,1
        
        UIButton *stateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [stateBtn setFrame:CGRectMake(clearanceWidth*b+btnWidth*b, 20*a+btnHeight*a, btnWidth, btnHeight)];
        stateBtn.tag = i;
        stateBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [stateBtn setTitle:[_liRunArray objectAtIndex:i] forState:UIControlStateNormal];
        stateBtn.layer.cornerRadius = 3.0f;
        stateBtn.layer.masksToBounds = YES;
        if (_liRuntag == i) {
            [stateBtn setTitleColor:IMPORTANT_BACKGROUND forState:UIControlStateNormal];
            [stateBtn setBackgroundColor:[UIColor colorWithHexString:@"#FEF8F8"]];
            stateBtn.layer.borderWidth = 1;
            stateBtn.layer.borderColor = [IMPORTANT_BACKGROUND CGColor];
        }else{
            [stateBtn setTitleColor:[UIColor colorWithHexString:@"#555555"] forState:UIControlStateNormal];
            [stateBtn setBackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"]];
            stateBtn.layer.borderWidth = 0;
        }
        [stateBtn addTarget:self action:@selector(liRunBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_liRunView addSubview:stateBtn];
    }
}
- (void)stateBtnClick:(UIButton *)button {
    _stateTag = (int)button.tag;
    [self createStateBtn];
    
}
- (void)typeBtnClick:(UIButton *)button {
    _typeTag = (int)button.tag;
    [self createTypeBtn];
    
}
- (void)jiHuoBtnClick:(UIButton *)button {
    _jiHuoTag = (int)button.tag;
    [self createJiHuoBtn];
    
}
- (void)cardBtnClick:(UIButton *)button {
    _cardTag = (int)button.tag;
    [self createCardBtn];
    
}
- (void)agentBtnClick:(UIButton *)button {
    _agentTag = (int)button.tag;
    [self createAgentBtn];

}
- (void)typeSYBtnClick:(UIButton *)button {
    _typeSYTag = (int)button.tag;
    [self createTypeSYBtn];
    
}
- (void)timeTDBtnClick:(UIButton *)button {
    _timeTag = (int)button.tag;
    [self createTimeTDBtn];
    
}
- (void)liRunBtnClick:(UIButton *)button {
    _liRuntag = (int)button.tag;
    [self createLiRunBtn];
    
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
    
    if (_screenViewType == screen_view_LIST_JIAOYI) {
        // *stateArray, *typeArray, *jiHuoArray, *cardArray, *agentArray
    }
    if (_screenViewType == screen_view_LIST_JIHUO) {
        // *stateArray, *typeArray,
    }
    if (_screenViewType == screen_view_LIST_SHOUYI) {
        // *typeSYArray
    }
    if (_screenViewType == screen_view_LIST_TUANDUI) {
        // *timeArray, *liRunArray
    }
   
    
}
@end
