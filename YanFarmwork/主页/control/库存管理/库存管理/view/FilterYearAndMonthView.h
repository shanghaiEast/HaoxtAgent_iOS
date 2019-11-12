//
//  FilterYearAndMonthView.h
//  YanFarmwork
//
//  Created by HG on 2019/9/4.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^StartTimeBolck)(NSString *startTimeString);
typedef void(^EndTimeBolck)(NSString *endTimeString);


@interface FilterYearAndMonthView : UIView

@property (copy, nonatomic) StartTimeBolck startTimeBolck;
@property (copy, nonatomic) EndTimeBolck endTimeBolck;

@property (weak, nonatomic) IBOutlet UIView *whiteView;
@property (weak, nonatomic) IBOutlet UIView *dateView;

- (IBAction)cancelOrConfirmBtnClick:(id)sender;



@property (nonatomic) int buttonTag;//0-起始时间;1-结束时间
- (void)createView;

@end

NS_ASSUME_NONNULL_END
