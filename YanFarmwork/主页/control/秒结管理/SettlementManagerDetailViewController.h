//
//  SettlementManagerDetailViewController.h
//  YanFarmwork
//
//  Created by HG on 2019/10/22.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : BOOL {
    CAN_EDIT    =  YES,
    CANT_EDIT   =  NO,
} editBool;

NS_ASSUME_NONNULL_BEGIN

@interface SettlementManagerDetailViewController : UIViewController


@property (retain, nonatomic)  UITableView *myTableView;


@property (nonatomic) int jumpType;//0-秒结管理; 1-商户管理
@property (nonatomic) BOOL editBool;//是否可编辑

@end

NS_ASSUME_NONNULL_END
