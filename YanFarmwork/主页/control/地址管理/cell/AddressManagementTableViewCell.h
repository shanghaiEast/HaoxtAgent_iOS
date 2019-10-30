//
//  AddressManagementTableViewCell.h
//  YanFarmwork
//
//  Created by HG on 2019/10/30.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddressManagementTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
- (IBAction)leftBtnClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
- (IBAction)rightBtnClicked:(id)sender;





@end

NS_ASSUME_NONNULL_END
