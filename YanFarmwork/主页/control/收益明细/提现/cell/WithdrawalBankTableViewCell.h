//
//  WithdrawalBankTableViewCell.h
//  YanFarmwork
//
//  Created by HG on 2019/11/4.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WithdrawalBankTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *bankImageView;

@property (weak, nonatomic) IBOutlet UILabel *bankNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bankDetailLabel;




- (void)createView:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
