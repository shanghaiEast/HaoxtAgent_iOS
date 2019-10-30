//
//  QueryFilterHeaderView.h
//  YanFarmwork
//
//  Created by HG on 2019/10/24.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QueryFilterHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIButton *startTimeBtn;
@property (weak, nonatomic) IBOutlet UIButton *endTimeBtn;
- (IBAction)timeBtnClick:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;


@property (weak, nonatomic) IBOutlet UIButton *level1Btn;
@property (weak, nonatomic) IBOutlet UIButton *level2Btn;
- (IBAction)levelBtnClicked:(id)sender;


@property (weak, nonatomic) IBOutlet UIView *showView;
@property (weak, nonatomic) IBOutlet UIView *listView;



@property (nonatomic) int screenType;//0-按月; 1-按天
@property (retain, nonatomic) UIViewController *rootVC;
- (void)createView;

@end

NS_ASSUME_NONNULL_END
