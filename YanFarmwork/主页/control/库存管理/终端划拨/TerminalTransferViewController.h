//
//  TerminalTransferViewController.h
//  YanFarmwork
//
//  Created by HG on 2019/10/22.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum: NSInteger {
    
    terminal_huabo     =  1,
    terminal_huidiao   =  2,
    terminal_qianyi    =  3,
    
    
} terminalType;

NS_ASSUME_NONNULL_BEGIN

@interface TerminalTransferViewController : UIViewController


@property (retain, nonatomic) UITableView *myTableView;


@property (nonatomic) int terminalType;


@end

NS_ASSUME_NONNULL_END
