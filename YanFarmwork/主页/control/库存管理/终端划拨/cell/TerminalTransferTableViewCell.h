//
//  TerminalTransferTableViewCell.h
//  YanFarmwork
//
//  Created by HG on 2019/10/22.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^NumberLabelChangeBlock)(NSInteger num);
NS_ASSUME_NONNULL_BEGIN

@interface TerminalTransferTableViewCell : UITableViewCell

@property (copy, nonatomic) NumberLabelChangeBlock numberLabelChangeBlock;



@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIButton *delectOrAddBtn;
- (IBAction)delectOrAddbtnClicked:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *reductBtn;
- (IBAction)reductBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
- (IBAction)addBtnClicked:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *startTextField;
@property (weak, nonatomic) IBOutlet UITextField *endTextField;

- (IBAction)scanBtnClicked:(id)sender;




@property (retain, nonatomic) UIViewController *rootVC;
- (void)createView;

@end

NS_ASSUME_NONNULL_END
