//
//  InventoryManagementMainTableViewCell.h
//  YanFarmwork
//
//  Created by HG on 2019/10/23.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InventoryManagementMainTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *stateLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *companyLabel;



@end

NS_ASSUME_NONNULL_END
