//
//  QuerySearchViewController.h
//  YanFarmwork
//
//  Created by HG on 2019/10/24.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum :NSInteger {
    MarketingPerformance   =  0,
    TotalPerformance       =  1,
    PartnerPerformance     =  2,
} pageType;

NS_ASSUME_NONNULL_BEGIN

@interface QuerySearchViewController : UIViewController










@property (retain, nonatomic)  UITableView *myTableView;

@property (nonatomic) int pageType;



@end

NS_ASSUME_NONNULL_END
