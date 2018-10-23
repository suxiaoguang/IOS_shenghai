//
//  DKProfileHelpCell.h
//  ShengHai
//
//  Created by nanzeng liu on 2017/6/21.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DKProfileHelpViewModel;

@interface DKProfileHelpCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
                        indexPath:(NSIndexPath *)indexPath
                        viewModel:(DKProfileHelpViewModel *)viewModel;

@end
