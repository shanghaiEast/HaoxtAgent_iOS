//
//  ProductTypeView.h
//  YanFarmwork
//
//  Created by HG on 2019/11/7.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef void(^SelectLisyRowBlock)(NSDictionary * _Nullable dict);

NS_ASSUME_NONNULL_BEGIN

@interface ProductTypeView : UIView

@property (copy, nonatomic) SelectLisyRowBlock selectLisyRowBlock;


@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (retain, nonatomic)  UITableView *myTableView;





- (void) createView;

@end

NS_ASSUME_NONNULL_END
