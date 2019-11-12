//
//  MainTopView.h
//  YanFarmwork
//
//  Created by HG on 2019/10/18.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MainTopView : UIView


@property (weak, nonatomic) IBOutlet UILabel *allMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightMoneyLabel;

@property (weak, nonatomic) IBOutlet UIView *centerView;



- (IBAction)tiXianBtnClicked:(id)sender;




@property (retain, nonatomic) UIViewController *rootVC;
- (void)createView;

@end

NS_ASSUME_NONNULL_END
