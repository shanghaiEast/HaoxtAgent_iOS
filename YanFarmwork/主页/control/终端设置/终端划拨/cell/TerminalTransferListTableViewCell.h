//
//  TerminalTransferListTableViewCell.h
//  YanFarmwork
//
//  Created by HG on 2019/10/23.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TerminalTransferListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *successCountLabel;

@property (weak, nonatomic) IBOutlet UILabel *failureCountLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *salemanNOLabel;

@property (weak, nonatomic) IBOutlet UIButton *detailBtn;
- (IBAction)detailBtnClicked:(id)sender;



@property (retain, nonatomic) NSDictionary *detailDict;
@property (retain, nonatomic)UIViewController *root;
-(void)createView:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
