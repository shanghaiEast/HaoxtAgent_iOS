//
//  AddCreditCardViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/9/5.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "AddCreditCardViewController.h"


#import "CWCommon.h"
#import "CWBankCardModel.h"
#import "CWBankCardCaptureController.h"

#import "BankSelectViewController.h"
#import "AreaPickerView.h"

@interface AddCreditCardViewController ()<cwDetectCardEdgesDelegate>

@property(nonatomic,strong)CWBankCardCaptureController * cvctrl;

@property(strong, nonatomic) AreaPickerView *areaPickerView;

@property(nonatomic,strong) NSString *bankString;
@property(nonatomic,retain) NSDictionary *proviceDict, *cityDict, *headBankDict, *footBankDict;

@end

@implementation AddCreditCardViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    if (kNavBarHAbove7 == 64) {//解决OCR小屏版本bug
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    }
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [MyTools setViewController:self withNavigationBarColor:WHITECOLOR andItem:@"更改银行卡" itemColor:BLACKCOLOR haveBackBtn:YES withBackImage:defaultBarBackImage_black withBackClickTarget:self BackClickAction:@selector(popViewClick)];
    
    
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)popViewClick{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [ToolsObject buttonImageRight:_headBankBtn];
}


//-----------------------以下为银行卡识别ocr
-(void)selectPhoto{
    _cvctrl = [[CWBankCardCaptureController alloc]init];
    
    _cvctrl.delegate = self;
    
    _cvctrl.isRotate =    [[CWCommon getValueForKey:@"PortritBankCard"] boolValue];//是否支持竖版银行卡识别
    _cvctrl.cardType = CWBankCardTypeFront;
    //图片清晰度分数阈值 推荐为0.65
    _cvctrl.cardQuality = 0.65f;
    
    //授权码
    _cvctrl.authCodeStr = AuthCodeString;
    
    [self presentViewController:_cvctrl animated:YES completion:NULL];
    
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
    
   
    _bankString = [NSString stringWithFormat:@"%@",cardModel.bankName];
    
    [_headBankBtn setTitle:cardModel.cardNum forState:UIControlStateNormal];
    
    [ToolsObject buttonImageRight:_headBankBtn];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)headBankBtnClick:(id)sender {
    [_headBankBtn setTitle:@"请输入银行卡号" forState:UIControlStateNormal];
    
    [self selectPhoto];
}

- (IBAction)commitBtnClick:(id)sender {
   
    if (_headBankBtn.currentTitle.length == 0 || [_headBankBtn.currentTitle isEqualToString:@"请输入银行卡号"]) {
        [ToolsObject showMessageTitle:@"请输入银行卡号" andDelay:1 andImage:nil];
        return;
    }
    
//    if (_nameTextField.text.length == 0) {
//        [ToolsObject showMessageTitle:@"请输入姓名" andDelay:1 andImage:nil];
//        return;
//    }
//
//    if (_idCardTextField.text.length == 0) {
//        [ToolsObject showMessageTitle:@"请输入身份证号" andDelay:1 andImage:nil];
//        return;
//    }
//
//    if (_idCardTextField.text.length != 18) {
//        [ToolsObject showMessageTitle:@"身份证号输入有误" andDelay:1 andImage:nil];
//        return;
//    }
//
//    if (_phoneTextField.text.length == 0) {
//        [ToolsObject showMessageTitle:@"请输入预留手机号" andDelay:1 andImage:nil];
//        return;
//    }
//
//    if ([ToolsObject validateMobile:_phoneTextField.text] == NO) {
//        [ToolsObject showMessageTitle:@"手机号格式不正确" andDelay:1 andImage:nil];
//        return;
//    }
    
    
    
    [self requestCommit];
}


- (void)requestCommit{
    

//    [ToolsObject SVProgressHUDShowStatus:nil WithMask:YES];
//    typeof(self) wSelf = self;
//
//    NSDictionary *parametDic = [[NSDictionary alloc] initWithObjectsAndKeys:
//                                [NSString stringWithFormat:@"%@",_headBankBtn.currentTitle],@"CARD_NO",
//                                [NSString stringWithFormat:@"%@",_bankString],@"BANK_NM",
//                                [NSString stringWithFormat:@"%@",_nameTextField.text],@"NAME",
//                                [NSString stringWithFormat:@"%@",_idCardTextField.text],@"CER_NO",
//                                [NSString stringWithFormat:@"%@",_phoneTextField.text],@"BANK_PHONE",
//                                nil];
//
//    [YanNetworkOBJ postWithURLString:usr_authPromoteLimit parameters:parametDic success:^(id  _Nonnull responseObject) {
//        [ToolsObject SVProgressHUDDismiss];
//        if ([[responseObject objectForKey:@"rspCd"] intValue] == 000000) {
//
//            NSMutableDictionary *tempDict = [USER_DATA mutableCopy];
//            [tempDict setObject:@"1" forKey:@"CCARD_VALID_STS"];
//            [ToolsObject savaUserData:tempDict];
//            [LoginJsonModel infoWithDictionary:USER_DATA];
//
//
//
////            ConfirmSignViewController *confirmSignVC = [[ConfirmSignViewController alloc] initWithNibName:@"ConfirmSignViewController" bundle:nil];
////            confirmSignVC.payType = TYPE_CARDCER;
////            confirmSignVC.hidesBottomBarWhenPushed = YES;
////            [self.navigationController pushViewController:confirmSignVC animated:YES];
//
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

//开户总行
- (IBAction)bankNameBtnClick:(id)sender {
    typeof(self) wSelf = self;
    BankSelectViewController *bankVC = [[BankSelectViewController alloc] initWithNibName:@"BankSelectViewController" bundle:nil];
    bankVC.showTag = 1;
    bankVC.headBankName = @"AGTSTL_BNK_LIST";
    bankVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:bankVC animated:YES];
    bankVC.getHeadBankBlock = ^(NSDictionary * _Nonnull dict) {
        NSLog(@"开户总行dict == %@",dict);
       
        wSelf.headBankDict = dict;
//        [wSelf.headquartersBankBtn setTitle:[wSelf.headBankDict objectForKey:@"fldExp"] forState:UIControlStateNormal];
//
//        [wSelf.branchBankBtn setTitle:@"请查询开户支行" forState:UIControlStateNormal];
        
    };
}
//地址
- (IBAction)addressBtnClick:(id)sender {
    typeof(self) wSelf = self;
    _areaPickerView = [[[NSBundle mainBundle] loadNibNamed:@"AreaPickerView" owner:self options:nil] lastObject];
    [_areaPickerView setFrame:self.view.bounds];
    [_areaPickerView createPickerView];
    [self.view addSubview:_areaPickerView];
    _areaPickerView.selectProviceAndCityBlock = ^(NSDictionary * _Nonnull proviceDict, NSDictionary * _Nonnull cityDict) {
        NSLog(@"地址proviceDict: %@\ncityDict: %@",proviceDict,cityDict);
        //    proviceDict: {
        //        LABEL = "\U6cb3\U5317\U7701";
        //        VALUE = 1200;
        //    }
        //    cityDict: {
        //        LABEL = "\U8861\U6c34\U5e02";
        //        VALUE = 1480;
        //    }
        
        wSelf.proviceDict = proviceDict;
        wSelf.cityDict = cityDict;
        
//        [wSelf.provinceAddresBtn setTitle:[NSString stringWithFormat:@"%@%@",[proviceDict objectForKey:@"LABEL"],[cityDict objectForKey:@"LABEL"]] forState:UIControlStateNormal];
        
    };
}
//开户支行
- (IBAction)bankBranchClick:(id)sender {
    typeof(self) wSelf = self;
    BankSelectViewController *bankVC = [[BankSelectViewController alloc] initWithNibName:@"BankSelectViewController" bundle:nil];
    bankVC.showTag = 2;
    bankVC.headBankDict = _headBankDict;
    bankVC.proviceDict = _proviceDict;
    bankVC.cityDict = _cityDict;
    bankVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:bankVC animated:YES];
    bankVC.getFootBankBlock = ^(NSDictionary * _Nonnull dict) {
        NSLog(@"开户支行dict == %@",dict);
        
        wSelf.footBankDict = dict;
        
//        [wSelf.branchBankBtn setTitle:[wSelf.footBankDict objectForKey:@"lbnkNm"] forState:UIControlStateNormal];
        
    };
}

@end
