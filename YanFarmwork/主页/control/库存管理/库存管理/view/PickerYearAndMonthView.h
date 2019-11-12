//
//  PickerYearAndMonthView.h
//  YanFarmwork
//
//  Created by HG on 2019/11/11.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BackYearAndMonthBlock)(NSString * _Nullable yearString, NSString * _Nullable monthString, BOOL isLegal);

NS_ASSUME_NONNULL_BEGIN

@interface PickerYearAndMonthView : UIView



@property (nonatomic, copy) BackYearAndMonthBlock backYearAndMonthBlock;

- (void)createPickerView;

@end

NS_ASSUME_NONNULL_END
