//
//  SettlementManagerTableViewCell.h
//  YanFarmwork
//
//  Created by HG on 2019/10/22.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettlementManagerTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *shopStateLabel;

@property (weak, nonatomic) IBOutlet UILabel *shopPeopleLabel;

@property (weak, nonatomic) IBOutlet UILabel *level1NoLabel;

@property (weak, nonatomic) IBOutlet UIButton *setBtn;
- (IBAction)setBtnClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *detailBtn;
- (IBAction)detailBtnClick:(id)sender;


- (void)createCell:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
