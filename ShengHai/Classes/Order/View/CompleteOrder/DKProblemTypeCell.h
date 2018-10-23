//
//  DKProblemTypeCell.h
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/6.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DKOrderWikiFirst.h"

@interface DKProblemTypeCell : UITableViewCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

/** 一级知识库 */
@property (nonatomic, strong) DKOrderWikiFirst *orderWikiFirst;

@end
