//
//  RegisterViewController.m
//  GanHuiYou
//
//  Created by 孙向前 on 14-9-28.
//  Copyright (c) 2014年 sunxq_xiaoruan. All rights reserved.
//

#import "RegisterViewController.h"
#import "UIImage+expanded.h"
#import "UIView+expanded.h"

@interface RegisterViewController ()<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{
    UIImage *pickImage;
    UIButton *currentBtn;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *txtUserName;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtConfirm;
@property (weak, nonatomic) IBOutlet UITextField *txtRealName;
@property (weak, nonatomic) IBOutlet UILabel *lblArea;
@property (weak, nonatomic) IBOutlet UILabel *lblHospital;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *lblMark;

@property (weak, nonatomic) IBOutlet UIView *pickView;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIPickerView *dataPicker;

@property (nonatomic, strong) NSArray *pickerDataArray;

@end

@implementation RegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLayoutSubviews{
    _scrollView.contentSize = CGSizeMake(kScreenWidth, 798);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    _scrollView.contentSize = CGSizeMake(kScreenWidth,798 + 216);//原始滑动距离加键盘高度
    CGPoint pt = [textField convertPoint:CGPointMake(0, 0) toView:_scrollView];//把当前的textField的坐标映射到scrollview上
    if(_scrollView.contentOffset.y - pt.y + kNAVIGATION_BAR_HEIGHT <= 0)//判断最上面不要去滚动
        [_scrollView setContentOffset:CGPointMake(0, pt.y - kNAVIGATION_BAR_HEIGHT) animated:YES];//滑动
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    _scrollView.contentSize = CGSizeMake(kScreenWidth,798);
    [self.view endEditing:YES];
    return YES;
}

#pragma mark - actions
//添加头像
- (IBAction)chooseHeaderButtonClicked:(UIButton *)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@""
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"相机拍摄", @"从相册选择",nil];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
}

//弹出pickerview 1.科室， 2.职称
- (IBAction)showPickerButtonClicked:(UIButton *)sender {
    currentBtn = sender;
    if (sender.tag == 1) {
        self.pickerDataArray = @[@"a",@"b",@"c",@"d"];
    } else {
        self.pickerDataArray = @[@"1",@"2",@"3",@"4"];
    }
    
    DLog(@"%f__%f__%d",_pickView.frameY,kScreenHeight,kNAVIGATION_BAR_HEIGHT)
    [UIView animateWithDuration:.3 animations:^{
        _pickView.frameY = kScreenHeight - kNAVIGATION_BAR_HEIGHT - _pickView.frameHeight;
    }];
    
    [_dataPicker reloadAllComponents];
    
}

//隐藏pickerview
- (void)hidePickerView {
    [UIView animateWithDuration:.3 animations:^{
        _pickView.frameY = kScreenHeight - kNAVIGATION_BAR_HEIGHT;
    }];
}

//取消
- (IBAction)cancelButtonClicked:(id)sender {
    [self hidePickerView];
}

//选取
- (IBAction)chooseButtonClicked:(id)sender {
    [self hidePickerView];
    
    NSInteger index = [_dataPicker selectedRowInComponent:0];
    NSString *pickValue = _pickerDataArray[index];
    NSString *title = [currentBtn titleForState:UIControlStateNormal];
    NSString *content = [title stringByAppendingFormat:@"          %@",pickValue];
    [currentBtn setTitle:content forState:UIControlStateNormal];
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.pickerDataArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.pickerDataArray[row];
}


#pragma mark - actionshet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    UIImagePickerControllerSourceType sourceType = buttonIndex ? UIImagePickerControllerSourceTypePhotoLibrary : UIImagePickerControllerSourceTypeCamera;
    //判断是否有摄像头
    if(![UIImagePickerController isSourceTypeAvailable:sourceType])
    {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;   // 设置委托
    imagePickerController.sourceType = sourceType;
    imagePickerController.allowsEditing = YES;
    [self presentViewController:imagePickerController animated:YES completion:nil];  //需要以模态的形式展示
    
}

#pragma mark - imagepickerviewcontroller delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (image == nil)
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    pickImage = [image imageByScalingProportionallyToMinimumSize:CGSizeMake(kScreenWidth, kScreenHeight)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
