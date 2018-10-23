//
//  DKProfileAddressBookDetailCell.h
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/22.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DKStaffContacts.h"

@interface DKProfileAddressBookDetailCell : UITableViewCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

/** 通讯录 */
@property (nonatomic, strong) DKStaffContacts *staffContacts;

@end
