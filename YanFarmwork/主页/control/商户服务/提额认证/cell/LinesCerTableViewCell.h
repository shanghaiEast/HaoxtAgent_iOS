//
//  LinesCerTableViewCell.h
//  YanFarmwork
//
//  Created by HG on 2019/9/5.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LinesCerTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *bankCardImageView;

@property (weak, nonatomic) IBOutlet UITextField *accountNoTextField;
@property (weak, nonatomic) IBOutlet UITextField *accountNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *idCardTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

- (IBAction)nextBtnClick:(id)sender;





@property (retain, nonatomic) UIViewController *rootVC;
- (void)createHeaderView;

@end

NS_ASSUME_NONNULL_END
