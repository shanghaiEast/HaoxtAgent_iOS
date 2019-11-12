//
//  CustomDataPickView.h
//  YanFarmwork
//
//  Created by HG on 2019/11/11.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,CustomDataPickViewType) {
    CustomDataPickViewTypeYearMonthDay,//年月日
    CustomDataPickViewTypeYearMonth//年月
};

@protocol CustomDataPickViewDelegate <NSObject>
@optional

//CustomDataPickViewTypeYearMonthDay 回调
- (void)pickViewCallBack_year:(NSString *)year month:(NSString *)month day:(NSString *)day;

//CustomDataPickViewTypeYearMonth 回调
- (void)pickViewCallBack_year:(NSString *)year month:(NSString *)month;

//滚动pickView时 回调
- (void)pickViewScroollCallBack_year:(NSString *)year month:(NSString *)month day:(NSString *)day;


@end

