//
//  FilterYearAndMonthView.m
//  YanFarmwork
//
//  Created by HG on 2019/9/4.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "FilterYearAndMonthView.h"

#import "PickerYearAndMonthView.h"


@interface FilterYearAndMonthView ()

@property (retain, nonatomic) PickerYearAndMonthView *myPickerView;




@property (retain, nonatomic) NSString *lastDateString;

@end

@implementation FilterYearAndMonthView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)createView{
    
    typeof(self) wSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [wSelf createDateView];
    });
    
}

- (void)createDateView{
    
    
   
    
    
    float viewH = _whiteView.frame.size.height;
    float viewW = _whiteView.frame.size.width;
    
    
    [_whiteView setFrame:CGRectMake(0, self.frame.size.height, viewW, 0)];
    
    _whiteView.hidden = NO;
    
    typeof(self)wSelf = self;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [wSelf.whiteView setFrame:CGRectMake(0, self.frame.size.height-viewH, viewW, viewH)];
        
    } completion:^(BOOL finished) {
        [self createCustomDateView];
        
    }];
}

- (void)createCustomDateView {

    _myPickerView = [[PickerYearAndMonthView alloc] initWithFrame:_dateView.bounds];
    [_myPickerView createPickerView];
    [_dateView addSubview:_myPickerView];
    _myPickerView.backYearAndMonthBlock = ^(NSString * _Nullable yearString, NSString * _Nullable monthString, BOOL isLegal) {
        NSLog(@"year: %@, monthL: %@, isLegal:%ld",yearString, monthString, isLegal);
        if (isLegal == NO) {
            [ToolsObject showMessageTitle:@"只能选择前后6个月的时间" andDelay:1 andImage:nil];
        }
    };
}

//- (NSString *)dateToday {
//    //将日期转换成需要的样式
//    NSDateFormatter* YMD = [[NSDateFormatter alloc]init];
//    [YMD setDateFormat:@"yyyy-MM"];
//    NSDate *date = [NSDate date];
//    NSString *dateString = [YMD stringFromDate:date];
//
//    NSLog(@"时间：%@",dateString);
//
//    return dateString;
//}
//
//
//- (void)dateChanged:(UIDatePicker*)sender {
//    //将日期转换成需要的样式
//    NSDateFormatter* YMD = [[NSDateFormatter alloc]init];
//    [YMD setDateFormat:@"yyyy-MM-dd"];
//    NSString *dateString = [YMD stringFromDate:_datePicker.date];
//
//    NSLog(@"时间：%@",dateString);
//
//    _lastDateString = dateString;
//
//}



- (IBAction)cancelOrConfirmBtnClick:(id)sender {
    UIButton *button = (id)sender;
    if (button.tag == 0) {
        // 取消
        self.hidden = YES;
        
    }else{
        //确定
        self.hidden = YES;
        
        if (_buttonTag == 0) {
            if (_startTimeBolck) {
                _startTimeBolck(_lastDateString);
            }
            
        }else if (_buttonTag == 1) {
            if (_endTimeBolck) {
                _endTimeBolck(_lastDateString);
            }
        }
            
        
    }
}


@end
