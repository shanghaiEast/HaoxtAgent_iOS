//
//  MyPolicyTableViewCell.h
//  YanFarmwork
//
//  Created by HG on 2019/11/4.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyPolicyTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *topOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *topTwoLabel;

@property (weak, nonatomic) IBOutlet UITextField *TextFieldOne;
@property (weak, nonatomic) IBOutlet UITextField *TextFieldTwo;
@property (weak, nonatomic) IBOutlet UITextField *TextFieldThree;
@property (weak, nonatomic) IBOutlet UITextField *TextFieldFour;





- (void)createCell:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
