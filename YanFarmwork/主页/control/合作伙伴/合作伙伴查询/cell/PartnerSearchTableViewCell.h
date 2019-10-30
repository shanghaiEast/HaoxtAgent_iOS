//
//  PartnerSearchTableViewCell.h
//  YanFarmwork
//
//  Created by HG on 2019/10/21.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PartnerSearchTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIView *bgView;


@property (weak, nonatomic) IBOutlet UILabel *companyNameLabel;

@property (weak, nonatomic) IBOutlet UIButton *detailBtn;

@property (weak, nonatomic) IBOutlet UILabel *peopleNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@property (weak, nonatomic) IBOutlet UILabel *levelOneLabel;

@property (weak, nonatomic) IBOutlet UILabel *levelTwoLabel;




- (void)createCell:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
