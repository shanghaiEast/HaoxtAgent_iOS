//
//  WithdrawalListFilterViewController.h
//  YanFarmwork
//
//  Created by HG on 2019/10/24.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef enum :NSInteger {
    filterType_shouyi   =  0,
    filterType_liebiao  =  1,
    
}filterType;

NS_ASSUME_NONNULL_BEGIN

@interface WithdrawalListFilterViewController : UIViewController


@property (retain, nonatomic) UITableView *myTableView;
@property (nonatomic) int filterType;

@end

NS_ASSUME_NONNULL_END
