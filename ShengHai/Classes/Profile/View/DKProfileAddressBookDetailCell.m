//
//  DKProfileAddressBookDetailCell.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/22.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKProfileAddressBookDetailCell.h"
#import "DKProfileSuccessAlertViewController.h"

@interface DKProfileAddressBookDetailCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

@end

@implementation DKProfileAddressBookDetailCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    DKProfileAddressBookDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    cell = cell ? : DKLoadViewFromNib
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setStaffContacts:(DKStaffContacts *)staffContacts
{
    _staffContacts = staffContacts;
    self.nameLabel.text = staffContacts.staff_name;
    self.phoneLabel.text = staffContacts.staff_phone;
	self.emailLabel.text = staffContacts.staff_email;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:staffContacts.headimgurl] placeholderImage:[UIImage imageNamed:@"ic_user"]];
}

- (IBAction)copyClick:(id)sender {
	if (self.staffContacts.staff_email.length) {
		UIPasteboard *pab = [UIPasteboard generalPasteboard];
		[pab setString:self.staffContacts.staff_email];
		DKProfileSuccessAlertViewController *vc = [[DKProfileSuccessAlertViewController alloc] init];
		vc.successText = [NSString stringWithFormat:@"已复制 %@，\n可直接粘贴使用",self.staffContacts.staff_email];
		vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
		NZModalViewController(vc);
	} else {
		[DKProgressHUD showInfoWithStatus:@"邮箱信息为空"];
	}
}

- (IBAction)contactClick:(id)sender {
	NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"telprompt://%@",self.staffContacts.staff_phone];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

@end
