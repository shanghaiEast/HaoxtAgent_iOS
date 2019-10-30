//
//  TerminalTransferHeaderView.h
//  YanFarmwork
//
//  Created by HG on 2019/10/22.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^AddBatchBlock)(BOOL clickBool);
NS_ASSUME_NONNULL_BEGIN

@interface TerminalTransferHeaderView : UIView

@property (copy, nonatomic) AddBatchBlock addBatchBlock;


//+新增批次
- (IBAction)addBatchBtnClick:(id)sender;



//添加业务员
@property (weak, nonatomic) IBOutlet UIButton *addSaleMan;
- (IBAction)addSalemanClick:(id)sender;

//返回
- (IBAction)backBtnClicked:(id)sender;


//明细
- (IBAction)detailListBtnClick:(id)sender;




@property (retain, nonatomic) UIViewController *rootVC;
- (void)createView;

@end

NS_ASSUME_NONNULL_END
