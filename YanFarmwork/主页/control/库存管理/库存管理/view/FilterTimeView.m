//
//  FilterTimeView.m
//  YanFarmwork
//
//  Created by HG on 2019/9/4.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "FilterTimeView.h"

@interface FilterTimeView ()

//@property (retain, nonatomic) NSArray *stateArray, *typeArray;

@property (retain, nonatomic) UIDatePicker * datePicker;

@property (retain, nonatomic) NSString *lastDateString;

@end

@implementation FilterTimeView

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
        wSelf.datePicker = [[UIDatePicker alloc]
                       initWithFrame:wSelf.dateView.bounds];
        wSelf.datePicker.locale= [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
        wSelf.datePicker.datePickerMode = UIDatePickerModeDate;
        wSelf.datePicker.backgroundColor = [UIColor whiteColor];
        [wSelf.datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
        [wSelf.dateView addSubview:wSelf.datePicker];
        
        
        NSDate * date = [NSDate date];
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        
        date = [formatter dateFromString:@"2000-01-01"];
        
        wSelf.datePicker.minimumDate = date;
        wSelf.datePicker.maximumDate= [NSDate date];//今天
        
    }];
    
    
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


- (void)dateChanged:(UIDatePicker*)sender {
    //将日期转换成需要的样式
    NSDateFormatter* YMD = [[NSDateFormatter alloc]init];
    [YMD setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [YMD stringFromDate:_datePicker.date];
    
    NSLog(@"时间：%@",dateString);
    
    _lastDateString = dateString;
    
}
//
//-(BOOL)dateCompare
//{
//    NSString *startDateString = _leftTimeBtn.currentTitle;
//    NSString *endDateString = _rightTimeBtn.currentTitle;
//
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
//    [formatter setDateFormat:@"yyyy-MM-dd"];
//
//    NSDate *startDate=[formatter dateFromString:startDateString];
//    NSDate *endDate=[formatter dateFromString:endDateString];
//    NSComparisonResult result=[endDate compare:startDate];
//
//    switch (result) {
//        case NSOrderedAscending: {
//            NSLog(@"FlyElephant:%@--时间小于---%@",startDate,endDate);
//            break;
//
//            return NO;
//        }
//        case NSOrderedSame: {
//            NSLog(@"FlyElephant:%@--时间等于---%@",startDate,endDate);
//
//            return YES;
//
//            break;
//        }
//        case NSOrderedDescending: {
//            NSLog(@"FlyElephant:%@--时间大于---%@",startDate,endDate);
//
//            return YES;
//
//            break;
//        }
//    }
//
//    return NO;
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
