//
//  PartnerScreenView.h
//  YanFarmwork
//
//  Created by HG on 2019/10/21.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BtnSelectedBlock)(NSInteger tag, NSDictionary *dict);

NS_ASSUME_NONNULL_BEGIN



@interface PartnerScreenView : UIView

@property (copy, nonatomic) BtnSelectedBlock btnSelectedBlock;



@property (weak, nonatomic) IBOutlet UITextField *serviceNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *peopleNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

- (IBAction)cancelBtnClick:(id)sender;

- (IBAction)conformBtnClick:(id)sender;


- (void)createView;

@end

NS_ASSUME_NONNULL_END
