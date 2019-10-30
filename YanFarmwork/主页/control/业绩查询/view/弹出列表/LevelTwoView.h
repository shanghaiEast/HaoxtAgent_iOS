//
//  LevelTwoView.h
//  YanFarmwork
//
//  Created by HG on 2019/10/24.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^ConfirmClickedBlock)(NSArray * _Nonnull array);

NS_ASSUME_NONNULL_BEGIN

@interface LevelTwoView : UIView


@property (copy, nonatomic) ConfirmClickedBlock confirmClickedBlock;


@property (weak, nonatomic) IBOutlet UIView *listView;

- (IBAction)cancelBtnOrConfireBtnClicked:(id)sender;





@property (retain, nonatomic)  UITableView *myTableView;

@property (retain, nonatomic) UIViewController *rootVC;
- (void)createView;

@end

NS_ASSUME_NONNULL_END
