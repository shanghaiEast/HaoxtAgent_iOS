//
//  WithdrawalDetailViewController.h
//  YanFarmwork
//
//  Created by HG on 2019/10/29.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WithdrawalDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;

@property (weak, nonatomic) IBOutlet UILabel *orderStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *dataLabel;
@property (weak, nonatomic) IBOutlet UILabel *NOLabel;
@property (weak, nonatomic) IBOutlet UILabel *poundageLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *remindLabel;







@property (retain, nonatomic)  UITableView *myTableView;

@property (retain, nonatomic) NSDictionary *resultDict;

@end

NS_ASSUME_NONNULL_END
