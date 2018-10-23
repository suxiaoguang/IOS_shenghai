//
//  DKProfileCell.h
//  YouYunBao
//
//  Created by nanzeng liu on 2017/5/15.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DKProfileViewModel;

@interface DKProfileCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
                        indexPath:(NSIndexPath *)indexPath
                        viewModel:(DKProfileViewModel *)viewModel;

@end
