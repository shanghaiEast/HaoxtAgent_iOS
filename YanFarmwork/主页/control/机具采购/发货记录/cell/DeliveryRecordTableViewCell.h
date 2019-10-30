//
//  DeliveryRecordTableViewCell.h
//  YanFarmwork
//
//  Created by HG on 2019/10/28.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeliveryRecordTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *stateImageView;
@property (weak, nonatomic) IBOutlet UILabel *stateTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *paymentLabel;
@property (weak, nonatomic) IBOutlet UILabel *numbersLabel;
@property (weak, nonatomic) IBOutlet UILabel *batchNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderNoLabel;

@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;
//- (IBAction)confirmAndDetailBtnVlicked:(id)sender;





@property (retain, nonatomic) UIViewController *rootVC;
- (void)createView;




@end

NS_ASSUME_NONNULL_END
