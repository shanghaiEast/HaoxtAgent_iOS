//
//  QueryFilterViewController.h
//  YanFarmwork
//
//  Created by HG on 2019/10/24.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum :NSInteger {
    searchForMonth   =  0,
    searchForDay     =  1,
} screenType;
NS_ASSUME_NONNULL_BEGIN

@interface QueryFilterViewController : UIViewController



@property (retain, nonatomic)  UITableView *myTableView;
@property (nonatomic) int screenType;

@end

NS_ASSUME_NONNULL_END
