//
//  LinesCerTableViewCell.m
//  YanFarmwork
//
//  Created by HG on 2019/9/5.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "LinesCerTableViewCell.h"

#import "UserShopDetailTableViewController.h"

#import "CWCommon.h"
#import "CWBankCardModel.h"
#import "CWBankCardCaptureController.h"

#import "CityChooseView.h"

#import "BankSelectViewController.h"
#import "ConfirmSignViewController.h"


#import "AreaPickerView.h"


@interface LinesCerTableViewCell ()<cwDetectCardEdgesDelegate>

@property(nonatomic,strong)CWBankCardCaptureController * cvctrl;

@property(strong, nonatomic) AreaPickerView *areaPickerView;

@property(nonatomic,retain) CityChooseView *cityChooseView;

@property(nonatomic) BOOL bankCardPicBool;

@property(nonatomic,retain) NSDictionary *proviceDict, *cityDict, *headBankDict, *footBankDict;


@end

@implementation LinesCerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _bankCardPicBool = NO;
    
    [self createHeaderView];
}

- (void)createHeaderView {
    
//    [_accountNameTextField setValue:[UIColor colorWithHexString:@"#9C9C9C"] forKeyPath:@"_placeholderLabel.textColor"];
//    
//     [_accountNoTextField setValue:[UIColor colorWithHexString:@"#9C9C9C"] forKeyPath:@"_placeholderLabel.textColor"];
    
    
    _bankCardImageView.tag = 1;
    UITapGestureRecognizer *touch_bankCard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectPhoto:)];
    [_bankCardImageView addGestureRecognizer:touch_bankCard];
    
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)nextBtnClick:(id)sender {
    
    ConfirmSignViewController *VC = [[ConfirmSignViewController alloc] initWithNibName:@"ConfirmSignViewController" bundle:nil];
    VC.payType = SUCCESS;
    VC.hidesBottomBarWhenPushed = YES;
    [_rootVC.navigationController pushViewController:VC animated:YES];
    
    return;
    
    
    if (_bankCardPicBool == NO) {
        [ToolsObject showMessageTitle:@"请先上传银行卡照片" andDelay:1 andImage:nil];
        
        return;
    }
    
    if (_accountNoTextField.text.length == 0) {
        [ToolsObject showMessageTitle:@"请先输入信用卡卡号" andDelay:1 andImage:nil];
        return;
    }
    
    if (_accountNameTextField.text.length == 0) {
        [ToolsObject showMessageTitle:@"请先输入持卡人姓名" andDelay:1 andImage:nil];
        return;
    }
    
    if (_idCardTextField.text.length == 0) {
        [ToolsObject showMessageTitle:@"请先输入持卡人身份证号" andDelay:1 andImage:nil];
        return;
    }
    
    if (_phoneTextField.text.length == 0) {
        [ToolsObject showMessageTitle:@"请先输入银行预留手机号" andDelay:1 andImage:nil];
        return;
    }
    
   
    [self requestCommit];
}



//-----------------------以下为银行卡识别ocr
-(void)selectPhoto:(UITapGestureRecognizer *)tapGesture{
    _cvctrl = [[CWBankCardCaptureController alloc]init];
    
    _cvctrl.delegate = self;
    
    _cvctrl.isRotate =    [[CWCommon getValueForKey:@"PortritBankCard"] boolValue];//是否支持竖版银行卡识别
    _cvctrl.cardType = CWBankCardTypeFront;
    //图片清晰度分数阈值 推荐为0.65
    _cvctrl.cardQuality = 0.65f;
    
    //授权码
    _cvctrl.authCodeStr = AuthCodeString;
    
    [_rootVC presentViewController:_cvctrl animated:YES completion:NULL];
    
}

-(void)cwBankCardDetectDeleagte:(CWBankCardModel *)cardModel {
    
//    @property(nonatomic,strong) NSString   * cardNum;//银行卡号//6217560800027564300
//
//    @property(nonatomic,strong) NSString   * bankName;//银行名称//中国银行
//    @property(nonatomic,strong) NSString   * cardName;//银行卡名称
//    @property(nonatomic,strong) NSString   * cardType;//银行类型（借记卡/贷记卡/...)
//
//    @property(nonatomic,strong)UIImage *  cardImage;//银行卡图片
    
    NSLog(@"%@",cardModel);
    
    _bankCardImageView.image = cardModel.cardImage;
    
    _accountNameTextField.text = [NSString stringWithFormat:@"%@",cardModel.bankName];
    
    _accountNoTextField.text = [NSString stringWithFormat:@"%@",cardModel.cardNum];
    
    
    [self requestCommitPic:@"3" withImage:cardModel.cardImage];
}

- (void)requestCommitPic:(NSString *)typeStr withImage:(UIImage *)image {
    
    [ToolsObject SVProgressHUDShowStatus:nil WithMask:YES];
    typeof(self) wSelf = self;
    
    
    //UIImage转换为NSData
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0) ;
    NSString *base64String = [ToolsObject dataWitbBase64ToStrimg:imageData];
    
    NSDictionary *parametDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                                base64String,@"file",
                                typeStr,@"FILE_TYPE",
                                nil];
    
    [YanNetworkOBJ postWithURLString:pub_uploadFile parameters:parametDic success:^(id  _Nonnull responseObject) {
        [ToolsObject SVProgressHUDDismiss];
        if ([[responseObject objectForKey:@"rspCd"] intValue] == 000000) {
            
            wSelf.bankCardPicBool = YES;
    
            
            [ToolsObject showMessageTitle:[responseObject objectForKey:@"rspInf"] andDelay:1.0f andImage:nil];
        }else{
            //filed
            [ToolsObject showMessageTitle:[responseObject objectForKey:@"rspInf"] andDelay:1.0f andImage:nil];
        }
        
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"test filed ");
        [ToolsObject SVProgressHUDDismiss];
    }];
    
}

- (void)requestCommit {
    
    /*                            nil];
     STL_CARD_NO    结算卡
     STL_BANK_NAME_HO    结算卡总行名称
     STL_BANK_NUM_HO    结算卡总行联行号
     STL_BANK_NAME_SUB    结算卡支行名称
     STL_BANK_NUM_SUB    结算卡支行联行号
     STL_BANK_PROV    结算卡归属省
     STL_BANK_CITY    结算卡归属市
     */
    
//    [ToolsObject SVProgressHUDShowStatus:nil WithMask:YES];
//    typeof(self) wSelf = self;
//
//    NSDictionary *parametDic = [[NSDictionary alloc] initWithObjectsAndKeys:
//                                _accountNoTextField.text,@"STL_CARD_NO",
//                                [_headBankDict objectForKey:@"fldExp"],@"STL_BANK_NAME_HO",
//                                [_headBankDict objectForKey:@"fldVal"],@"STL_BANK_NUM_HO",
//                                 [_footBankDict objectForKey:@"lbnkNm"],@"STL_BANK_NAME_SUB",
//                                [_footBankDict objectForKey:@"lbnkNo"],@"STL_BANK_NUM_SUB",
//                                [_proviceDict objectForKey:@"VALUE"],@"STL_BANK_PROV",
//                                [_cityDict objectForKey:@"VALUE"],@"STL_BANK_CITY",
//                                nil];
//
//    [YanNetworkOBJ postWithURLString:stl_addStlBankInfo parameters:parametDic success:^(id  _Nonnull responseObject) {
//        [ToolsObject SVProgressHUDDismiss];
//        if ([[responseObject objectForKey:@"rspCd"] intValue] == 000000) {
//
//            [self requestCommitAll];
//
//        }else{
//            //filed
//            [ToolsObject showMessageTitle:[responseObject objectForKey:@"rspInf"] andDelay:1.0f andImage:nil];
//        }
//
//    } failure:^(NSError * _Nonnull error) {
//        NSLog(@"test filed ");
//        [ToolsObject SVProgressHUDDismiss];
//    }];
    
}


- (void)requestCommitAll {
    
    [ToolsObject SVProgressHUDShowStatus:nil WithMask:YES];
    typeof(self) wSelf = self;
    
//    MERC_NM    商户名称        N
//    PARENT_MCC    所属行业-大类        Y    默认当日
//    MCC_CD    所属行业-明细
//    PROVINCE    省
//    CITY    市
//    STL_CYCLE    结算周期            0-D0 1-T1
//    ACO_TYP_LIST    账户类型            0-对公，1-对私
    
    
//    NSDictionary *parametDic = [[NSDictionary alloc] init];
//
//    [YanNetworkOBJ postWithURLString:usr_open parameters:parametDic success:^(id  _Nonnull responseObject) {
//        [ToolsObject SVProgressHUDDismiss];
//        if ([[responseObject objectForKey:@"rspCd"] intValue] == 000000) {
//
//            ConfirmSignViewController *confirmSignVC = [[ConfirmSignViewController alloc] initWithNibName:@"ConfirmSignViewController" bundle:nil];
//            confirmSignVC.payType = TYPE_REALNAME;
//            confirmSignVC.hidesBottomBarWhenPushed = YES;
//            [_rootVC.navigationController pushViewController:confirmSignVC animated:YES];
//
//        }else{
//            //filed
//            [ToolsObject showMessageTitle:[responseObject objectForKey:@"rspInf"] andDelay:1.0f andImage:nil];
//        }
//
//    } failure:^(NSError * _Nonnull error) {
//        NSLog(@"test filed ");
//        [ToolsObject SVProgressHUDDismiss];
//    }];
//
}

@end
