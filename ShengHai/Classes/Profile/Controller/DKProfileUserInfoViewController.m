//
//  DKProfileUserInfoViewController.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/23.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKProfileUserInfoViewController.h"
#import "DKUserLoginViewController.h"
#import "JPUSHService.h"
#import "DKProfileUserInfoViewModel.h"

@interface DKProfileUserInfoViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>

@property (strong, nonatomic) IBOutlet UITapGestureRecognizer   *uploadHeadImageTap;    // 点击上传头像
@property (weak, nonatomic) IBOutlet UIButton                   *logoutButton;          // 退出登录按钮
@property (weak, nonatomic) IBOutlet UIImageView                *headImageView;         // 头像
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *workNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *arraLabel;
@property (weak, nonatomic) IBOutlet UILabel *workClassLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel; // 邮箱

@property (nonatomic, strong) UIActionSheet *actionSheet;                               // 图片选择
@property (nonatomic, strong) UIImage       *selectImage;                               // 选择的图片

@property (nonatomic, strong) DKProfileUserInfoViewModel *vm;

@end

@implementation DKProfileUserInfoViewController
#pragma mark - setters && getters
DKRegisterViewModel(vm, DKProfileUserInfoViewModel)

#pragma mark - lifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setUpView];
    [self event];
}

- (void)setUpView
{
    self.navigationItem.title = @"个人信息";
    [self loadBaseInfo];
}

- (void)loadBaseInfo
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:DKUserInfoCache.headimgurl] placeholderImage:[UIImage imageNamed:@"ic_user"]];
        self.nameLabel.text = DKUserInfoCache.staff_name;
        self.workNumberLabel.text = DKUserInfoCache.staff_code;
        self.phoneLabel.text = DKUserInfoCache.staff_phone;
        self.arraLabel.text = DKUserInfoCache.region_sub;
        self.workClassLabel.text = DKUserInfoCache.staff_class;
		self.emailLabel.text = DKUserInfoCache.staff_email;
    });
}

// 选择图片
- (void)selectImg
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        // 拍照 + 相册
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择", nil, nil];
    } else { // 相册
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", nil, nil];
    }

    [self.actionSheet showInView:self.view];
}

#pragma mark - events
- (void)bind
{
    @weakify(self);
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:DKUserInfoDidUpdatedNotification object:nil] subscribeNext:^(id x) {
        @strongify(self);
        [self loadBaseInfo];
    }];
    
//    [self.vm.logoutCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
//        
//    }];
    
    [self.vm.updateHeadImageCommand.executing subscribeNext:^(id x) {
        if ([x boolValue]) {
            [DKProgressHUD showLoadingToView:self.view];
        } else {
            [DKProgressHUD dismissForView:self.view];
        }
    }];
    
    [self.vm.updateHeadImageCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        [[NSNotificationCenter defaultCenter] postNotificationName:DKUserInfoDidUpdatedNotification object:nil];
        [DKProgressHUD showSuccessWithStatus:@"头像设置成功"];
    }];
}

- (void)event
{
    @weakify(self);
    [self.uploadHeadImageTap.rac_gestureSignal subscribeNext:^(id x) {
        @strongify(self);
        [self selectImg];
    }];

    [[self.logoutButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.vm.logoutCommand execute:nil];
        [UIApplication sharedApplication].keyWindow.rootViewController = [[DKNavigationController alloc] initWithRootViewController:[[DKUserLoginViewController alloc] init]];
        [DKProgressHUD showSuccessWithStatus:@"退出成功"];
        [JPUSHService setAlias:@"0" callbackSelector:nil object:nil];
    }];
}

#pragma mark - UIImagePickerControllerDelegate
/** 选择照片完成的时候调用 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary <NSString *, id> *)info
{
    // 获取选中的图片
    UIImage *image = info[UIImagePickerControllerEditedImage];

    self.selectImage = image;
    [self dismissViewControllerAnimated:YES completion:nil];

    @weakify(self);
    [DKQiNiuShareManager uploadQiNiuWithImage:self.selectImage callback:^(NSString *key, NSError *error) {
        @strongify(self);
        self.vm.headImageUrl = [NSString dk_stringWithFormat:@"%@%@",DKQiNiuShareManager.configInfo.domain,key];
        [self.vm.updateHeadImageCommand execute:nil];
    }];
}

#pragma mark - <UIActionSheetDelegate>

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

    // 判断是否支持相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        switch (buttonIndex) {
            case 0:
                // 来源相机
                sourceType = UIImagePickerControllerSourceTypeCamera;
                break;

            case 1:
                // 来源相册
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                break;

            case 2:
                return;
        }
    } else {
        if (buttonIndex == 1) {
            return;
        } else {
            sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }
    }

    // 跳转到相机或相册页面
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = sourceType;

    [self presentViewController:imagePickerController animated:YES completion:nil];
}

@end
