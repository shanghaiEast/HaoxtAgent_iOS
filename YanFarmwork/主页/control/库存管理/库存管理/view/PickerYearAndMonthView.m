//
//  PickerYearAndMonthView.m
//  YanFarmwork
//
//  Created by HG on 2019/11/11.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "PickerYearAndMonthView.h"

@interface PickerYearAndMonthView ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSMutableArray *yearArray, *monthArray;
@property (nonatomic, assign) int yearInt, monthInt;
@property (nonatomic, strong) NSString *yearString, *monthString;


@end

@implementation PickerYearAndMonthView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)getMonth{
    
    // 获取代表公历的NSCalendar对象
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // 获取当前日期
    NSDate* dt = [NSDate date];
    // 定义一个时间字段的旗标，指定将会获取指定年、月、日、时、分、秒的信息
    unsigned unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |  NSCalendarUnitDay |
    NSCalendarUnitHour |  NSCalendarUnitMinute |
    NSCalendarUnitSecond | NSCalendarUnitWeekday;
    // 获取不同时间字段的信息
    NSDateComponents* comp = [gregorian components: unitFlags fromDate:dt];
    // 获取各时间字段的数值
    NSLog(@"现在是%ld年" , comp.year);
    NSLog(@"现在是%ld月 " , comp.month);
    NSLog(@"现在是%ld日" , comp.day);
    NSLog(@"现在是%ld时" , comp.hour);
    NSLog(@"现在是%ld分" , comp.minute);
    NSLog(@"现在是%ld秒" , comp.second);
    NSLog(@"现在是星期%ld" , comp.weekday);
    
    [self createDataYear:(int)comp.year withMomth:(int)comp.month];
    
//    // 再次创建一个NSDateComponents对象
//    NSDateComponents* comp2 = [[NSDateComponents alloc]
//                               init];
//    // 设置各时间字段的数值
//    comp2.year = 2013;
//    comp2.month = 4;
//    comp2.day = 5;
//    comp2.hour = 18;
//    comp2.minute = 34;
//    // 通过NSDateComponents所包含的时间字段的数值来恢复NSDate对象
//    NSDate *date = [gregorian dateFromComponents:comp2];
//    NSLog(@"获取的日期为：%@" , date);
}

- (void)createDataYear:(int)yearInt withMomth:(int)monthInt {
    
    _yearInt = yearInt;
    _monthInt = monthInt;
    
    _yearString = [NSString stringWithFormat:@"%d",yearInt];
     _monthString = [NSString stringWithFormat:@"%d",monthInt];
    
    _yearArray = [[NSMutableArray alloc] init];
    _monthArray = [[NSMutableArray alloc] init];
    
    if (_backYearAndMonthBlock) {
        _backYearAndMonthBlock(_yearString, _monthString, YES);
    }
    
    for (int a = 1; a <= 12; a ++) {
        [_monthArray addObject:[NSString stringWithFormat:@"%d",a]];
    }
    
    [_yearArray addObject:[NSString stringWithFormat:@"%d",yearInt]];
    if (monthInt-6 < 0 ) {
        [_yearArray insertObject:[NSString stringWithFormat:@"%d",yearInt-1] atIndex:0];
    }
    
    if (monthInt+6 > 12 ) {
        [_yearArray insertObject:[NSString stringWithFormat:@"%d",yearInt+1] atIndex:_yearArray.count];
    }
    
    NSLog(@"_monthArray :%@",_monthArray);
    NSLog(@"_yearArray :%@",_yearArray);
    
    for (int a = 0; a < _yearArray.count; a++) {
        if ([[_yearArray objectAtIndex:a] isEqualToString:[NSString stringWithFormat:@"%d",yearInt]]) {
            [_pickerView selectRow:a inComponent:0 animated:YES];
        }
    }
    
    for (int a = 0; a < _monthArray.count; a++) {
        if ([[_monthArray objectAtIndex:a] isEqualToString:[NSString stringWithFormat:@"%d",monthInt]]) {
            [_pickerView selectRow:a inComponent:1 animated:YES];
        }
    }
    
    
    [_pickerView reloadAllComponents];
}


- (void)createPickerView {
    
    _pickerView = [[UIPickerView alloc] initWithFrame:self.bounds];
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    [self addSubview:_pickerView];
    
     [self getMonth];
    

}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return _yearArray.count;
    }else{
        return _monthArray.count;
    }
    return  0;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component==0) {
        return [NSString stringWithFormat:@"%@月",[_yearArray objectAtIndex:row]];
    }else{
        return [NSString stringWithFormat:@"%@日",[_monthArray objectAtIndex:row]];;
    }
    return @"";
}
//切换省份后，城市刷新
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        _yearString = [_yearArray objectAtIndex:row];
    }
    
    if (component == 1) {
        _monthString = [_monthArray objectAtIndex:row];
    }
    
    if (_backYearAndMonthBlock) {
        _backYearAndMonthBlock(_yearString, _monthString, [self check]);
    }
}

//前后6个月判断
- (BOOL)check {
    
    float selectYearInt = [_yearString intValue];
    float selectMonthInt = [_monthString intValue];
    
    if (_yearInt == selectYearInt) {
        if (abs((_monthInt-selectMonthInt)) <= 6) {
            return YES;
        }
    }
    
    if (_yearInt > selectYearInt) {
        if ((12-selectMonthInt+_yearInt) <= 6) {
            return YES;
        }
    }
    
    if (_yearInt < selectYearInt) {
        if ((selectMonthInt+12-_yearInt) <= 6) {
            return YES;
        }
    }
    
    return NO;
}


@end

