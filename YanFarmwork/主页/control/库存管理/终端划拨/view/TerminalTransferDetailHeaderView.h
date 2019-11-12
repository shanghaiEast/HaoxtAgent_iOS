//
//  TerminalTransferDetailHeaderView.h
//  YanFarmwork
//
//  Created by HG on 2019/10/23.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TerminalTransferDetailHeaderView : UIView

//section one
- (IBAction)backBtnClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *headerView;

@property (weak, nonatomic) IBOutlet UIView *colorImageView;

@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (weak, nonatomic) IBOutlet UILabel *successNumberLabel;

@property (weak, nonatomic) IBOutlet UILabel *failureNumberLabel;


@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *shopNOLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *oneLabel;

@property (weak, nonatomic) IBOutlet UILabel *twoLabel;


- (IBAction)moreBtnClicked:(id)sender;





@property (retain, nonatomic) UIViewController *rootVC;
- (void)createSectionOneView:(NSDictionary *)dict;

//section two

@property (weak, nonatomic) IBOutlet UIView *footerView;

@property (weak, nonatomic) IBOutlet UIView *listView;



- (void)createSectionTwoView:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
