//
//  BatchDetailTableViewCell.h
//  YanFarmwork
//
//  Created by HG on 2019/10/23.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BatchDetailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *topLineLabel;

@property (weak, nonatomic) IBOutlet UILabel *bottomLineLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

NS_ASSUME_NONNULL_END
