//
//  PurchasingApplicationHeaderView.m
//  YanFarmwork
//
//  Created by HG on 2019/10/25.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "PurchasingApplicationHeaderView.h"


#import "UploadPicCollectionViewCell.h"

#import "MLImageCrop.h"

static float maxImageCount = 8;

@interface PurchasingApplicationHeaderView ()<UICollectionViewDelegate,UICollectionViewDataSource, UIImagePickerControllerDelegate, MLImageCropDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>

@property (retain, nonatomic) UICollectionViewFlowLayout *titleFlowLayout;
@property (retain, nonatomic) UICollectionView *titleCollectionView;

@property (retain, nonatomic) NSMutableArray *imageArray;

@property (nonatomic) int imageCount;

@end

@implementation PurchasingApplicationHeaderView




- (void)createView{
    
    _imageArray = [[NSMutableArray alloc] init];
    
    _imageCount = (int)_imageArray.count+1;
    
    [self initView];
    
    [self createCollection];
}

- (void)initView {
    if ([_typeOneBtn.currentTitle isEqualToString:@"请选择"]) {
        [_typeOneBtn setTitleColor:WEAKER_TEXT_LEVEL_1 forState:UIControlStateNormal];
    }else{
        [_typeOneBtn setTitleColor:IMPORTANT_TEXT forState:UIControlStateNormal];
    }
    
    if ([_typeTwoBtn.currentTitle isEqualToString:@"请选择机具型号"]) {
        [_typeTwoBtn setTitleColor:WEAKER_TEXT_LEVEL_1 forState:UIControlStateNormal];
    }else{
        [_typeTwoBtn setTitleColor:IMPORTANT_TEXT forState:UIControlStateNormal];
    }
    
    [ToolsObject buttonImageRight:_typeOneBtn];
    [ToolsObject buttonImageRight:_typeTwoBtn];
}

- (void)createCollection {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self createCollectionView];
    });
    
}
- (void)createCollectionView{
    
    float width = (_listView.frame.size.width - 80)/4;
    
    _titleFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    [_titleFlowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    _titleFlowLayout.minimumLineSpacing = 10.0f;
    _titleFlowLayout.minimumInteritemSpacing = 10.0f;
    _titleFlowLayout.itemSize = CGSizeMake(width, width);
    
    [_titleCollectionView removeFromSuperview];
    _titleCollectionView = [[UICollectionView alloc] initWithFrame:_listView.bounds collectionViewLayout:_titleFlowLayout];
    _titleCollectionView.delegate = self;
    _titleCollectionView.dataSource = self;
    _titleCollectionView.allowsMultipleSelection = NO;
    [_titleCollectionView setBackgroundColor:[UIColor clearColor]];
    _titleCollectionView.showsHorizontalScrollIndicator = NO;
    _titleCollectionView.showsVerticalScrollIndicator = NO;
    _titleCollectionView.pagingEnabled = NO;
    
    static NSString *cityHistoryCell = @"UploadEmptyPicCollectionViewCell";
    [_titleCollectionView registerNib:[UINib nibWithNibName:@"UploadEmptyPicCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cityHistoryCell];
    
    static NSString *cityHistoryCell2 = @"UploadPicCollectionViewCell";
    [_titleCollectionView registerNib:[UINib nibWithNibName:@"UploadPicCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cityHistoryCell2];
    
    [_listView addSubview:_titleCollectionView];
}
#pragma mark - UICollectionDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _imageCount;
}

//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    CGSize size = [ToolsObject getText:[_dataArr objectAtIndex:indexPath.row] withTextSize:CGSizeMake(self.frame.size.width, _myHeight) withTextFont:16];
//
//    return CGSizeMake(size.width+10, _myHeight);
//}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *collectionID;
    if (indexPath.row == _imageCount-1 && _imageCount != maxImageCount) {
        collectionID = @"UploadEmptyPicCollectionViewCell";
    }else{
        collectionID = @"UploadPicCollectionViewCell";
    }
  
    UploadPicCollectionViewCell *cell = (UploadPicCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:collectionID forIndexPath:indexPath];
    
    
    cell.layer.cornerRadius = 3.0f;
    cell.layer.masksToBounds = YES;
    
    
    if (indexPath.row == _imageCount-1 && _imageCount != maxImageCount) {
       
    }else{
        cell.showImageView.image = [_imageArray objectAtIndex:indexPath.row];
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == _imageCount-1 && _imageCount != maxImageCount) {
        [self chooseImageActionSheet];
    }else{
        [_imageArray removeObjectAtIndex:(int)indexPath.row];
        _imageCount = (int)_imageArray.count+1;
        
        [_titleCollectionView reloadData];
    }
}


//***********************选择图片***********************
- (void)chooseImageActionSheet
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"相机" otherButtonTitles:@"相册", nil];
    [actionSheet showInView:_rootVC.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"buttonIndex === %ld",(long)buttonIndex);
    
    NSUInteger soureceType = UIImagePickerControllerSourceTypePhotoLibrary;
    if (buttonIndex == 0) {
        //相机
        soureceType = UIImagePickerControllerSourceTypeCamera;
        //照相机不行，则访问相册
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            soureceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.sourceType = soureceType;
        //imagePickerController.allowsEditing = YES;
        [_rootVC presentViewController:imagePickerController animated:YES completion:nil];
        
    }else if (buttonIndex == 1) {
        //相册
        soureceType  = UIImagePickerControllerSourceTypePhotoLibrary;
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.sourceType = soureceType;
        //imagePickerController.allowsEditing = YES;
        [_rootVC presentViewController:imagePickerController animated:YES completion:nil];
    }
}

#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    
    [_rootVC dismissViewControllerAnimated:YES completion:^{
        
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        MLImageCrop *imageCrop = [[MLImageCrop alloc]init];
        imageCrop.delegate = self;
        imageCrop.ratioOfWidthAndHeight = ScreenWidth/ScreenWidth;
        imageCrop.image = image;
        [imageCrop showWithAnimation:YES];
        
        
    }];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [_rootVC dismissViewControllerAnimated:YES completion:nil];
}

- (void)cropImage:(UIImage*)cropImage forOriginalImage:(UIImage*)originalImage
{
    UIImage *myImage = [ToolsObject imageByScalingAndCroppingForSize:CGSizeMake(ScreenWidth, ScreenWidth) withImage:cropImage];
    
    [_imageArray addObject:myImage];
    _imageCount = (int)_imageArray.count +1;
    [_titleCollectionView reloadData];
    
//    NSData *imageData = UIImagePNGRepresentation(myImage);
//
//    _imageDataStr = [ToolsObject dataWitbBase64ToStrimg:imageData];
//    _typeStr = @"0";
    
}

//**********************************************





- (IBAction)chooseTypeClicked:(id)sender {
    UIButton *button = (id)sender;
    if (button.tag == 0) {
        NSLog(@"采购类型");
    }
    
    if (button.tag == 1) {
        NSLog(@"采购机具类型");
    }
}

- (IBAction)confirmBtnClicked:(id)sender {
    NSLog(@"PurchasingApplicationHeaderView   提交");
    
    
}
@end
