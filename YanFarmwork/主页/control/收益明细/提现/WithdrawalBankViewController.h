//
//  WithdrawalBankViewController.h
//  YanFarmwork
//
//  Created by HG on 2019/11/4.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BackBlock)(NSDictionary *dict);
NS_ASSUME_NONNULL_BEGIN

@interface WithdrawalBankViewController : UIViewController

@property (copy, nonatomic) BackBlock backBlock;

@property (retain, nonatomic)  UITableView *myTableView;

@end

NS_ASSUME_NONNULL_END
