//
//  DeliveryRecordDetailDetailTableViewCell.h
//  YanFarmwork
//
//  Created by HG on 2019/10/28.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeliveryRecordDetailDetailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *batchNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *numbelLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;

@property (weak, nonatomic) IBOutlet UIButton *logisticsBtn;

- (IBAction)confirmBtnClick:(id)sender;
- (IBAction)logisticsBtnClick:(id)sender;



@end

NS_ASSUME_NONNULL_END
