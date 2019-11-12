//
//  NewChartListScreenHeaderView.h
//  YanFarmwork
//
//  Created by HG on 2019/10/24.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    screen_view_LIST_JIHUO     = 0,
    screen_view_LIST_JIAOYI    = 1,
    screen_view_LIST_SHOUYI    = 2,
    screen_view_LIST_TUANDUI    = 3,
    
} screenViewType;
NS_ASSUME_NONNULL_BEGIN

@interface NewChartListScreenHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIButton *startTimeBtn;
@property (weak, nonatomic) IBOutlet UIButton *endTimeBtn;
- (IBAction)timeBtnClick:(id)sender;

- (IBAction)confireBtnClicked:(id)sender;




@property (weak, nonatomic) IBOutlet UIView *stateView;
@property (weak, nonatomic) IBOutlet UIView *typeView;
@property (weak, nonatomic) IBOutlet UIView *jiHuoView;
@property (weak, nonatomic) IBOutlet UIView *cardView;
@property (weak, nonatomic) IBOutlet UIView *agentView;

@property (weak, nonatomic) IBOutlet UIView *typeSYView;
@property (weak, nonatomic) IBOutlet UIView *timeTDView;
@property (weak, nonatomic) IBOutlet UIView *liRunView;


@property (nonatomic) int screenViewType;//

@property (retain, nonatomic) UIViewController *rootVC;
- (void)createView;

@end

NS_ASSUME_NONNULL_END
