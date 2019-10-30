//
//  LevelOneView.h
//  YanFarmwork
//
//  Created by HG on 2019/10/24.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^RowClickedBlock)(NSDictionary * _Nullable myDict);

NS_ASSUME_NONNULL_BEGIN

@interface LevelOneView : UIView


@property (copy, nonatomic) RowClickedBlock rowClickedBlock;


@property (weak, nonatomic) IBOutlet UIView *listView;




@property (retain, nonatomic)  UITableView *myTableView;

@property (retain, nonatomic) UIViewController *rootVC;
- (void)createView;

@end

NS_ASSUME_NONNULL_END
