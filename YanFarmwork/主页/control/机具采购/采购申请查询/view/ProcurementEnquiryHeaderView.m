//
//  ProcurementEnquiryHeaderView.m
//  YanFarmwork
//
//  Created by HG on 2019/10/25.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "ProcurementEnquiryHeaderView.h"

#import "TimeView.h"

@interface ProcurementEnquiryHeaderView ()

@property (retain, nonatomic) TimeView *timeView;

@property (retain, nonatomic) NSString *startDateString, *endDataString;

@end

@implementation ProcurementEnquiryHeaderView


- (void)createView{

    [self initView];
   
}

- (void)initView {
    if ([_typeOneBtn.currentTitle isEqualToString:@"请选择"]) {
        [_typeOneBtn setTitleColor:WEAKER_TEXT_LEVEL_1 forState:UIControlStateNormal];
    }else{
        [_typeOneBtn setTitleColor:IMPORTANT_TEXT forState:UIControlStateNormal];
    }
    
    if ([_typeTwoBtn.currentTitle isEqualToString:@"请选择"]) {
        [_typeTwoBtn setTitleColor:WEAKER_TEXT_LEVEL_1 forState:UIControlStateNormal];
    }else{
        [_typeTwoBtn setTitleColor:IMPORTANT_TEXT forState:UIControlStateNormal];
    }
    
    if ([_timeBtn.currentTitle isEqualToString:@"提交时间 ~ 结束时间"]) {
        [_timeBtn setTitleColor:WEAKER_TEXT_LEVEL_1 forState:UIControlStateNormal];
    }else{
        [_timeBtn setTitleColor:IMPORTANT_TEXT forState:UIControlStateNormal];
    }
    
    
    
    [ToolsObject buttonImageRight:_typeOneBtn];
    [ToolsObject buttonImageRight:_typeTwoBtn];
}



- (IBAction)chooseTypeClicked:(id)sender {
    UIButton *button = (id)sender;
    if (button.tag == 0) {
        NSLog(@"订单状态");
    }
    
    if (button.tag == 1) {
        NSLog(@"采购类型");
    }
}

- (IBAction)timeBtnClick:(id)sender {
    NSLog(@"提交时间");
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.timeView = [[[NSBundle mainBundle] loadNibNamed:@"TimeView" owner:self options:nil] lastObject];
    [ self.timeView setFrame:app.window.bounds];
    [ self.timeView createView];
    [app.window addSubview: self.timeView];
    self.timeView.timeBolck = ^(NSDictionary * _Nonnull dict) {
        NSLog(@"返回的数据：%@",dict);
        
        self.startDateString = [dict objectForKey:@"startTime"];
        self.endDataString = [dict objectForKey:@"endTime"];
        
        [self.timeBtn setTitle:[NSString stringWithFormat:@"%@ ~ %@",[dict objectForKey:@"startTime"],[dict objectForKey:@"endTime"]] forState:UIControlStateNormal];
        
        [self initView];
    };
}

- (IBAction)confirmBtnClicked:(id)sender {
    NSLog(@"ProcurementEnquiryHeaderView   提交");
    
    
}
@end
