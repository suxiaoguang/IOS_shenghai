//
//  DKTableViewController.m
//  DKTableViewMenu
//
//  Created by Arclin on 16/5/14.
//  Copyright © 2016年 dankal. All rights reserved.
//

#import "DKMenuTableViewController.h"

static NSString *DKCellID = @"cell";

@interface DKMenuTableViewController ()



@end

@implementation DKMenuTableViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 自动调整cell高度
//    self.tableView.rowHeight = 44;

    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    //去掉底部多余的表格线
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dk_dataSorce.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DKCellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:DKCellID];
    }
    
    cell.textLabel.text = self.dk_dataSorce[indexPath.row];
//    if (self.dk_detailTextDataSoure.count > 0 && self.dk_detailArray.count > 0) {
//        cell.detailTextLabel.text = self.dk_detailTextDataSoure[indexPath.row];
//    }
    
    cell.textLabel.numberOfLines = 0;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    cell.indentationLevel = 0;
    cell.indentationWidth = 0;
    
    if ([self.dk_originArray containsObject:cell.textLabel.text]) { //如果这个cell是父选项cell
        
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = [UIColor darkGrayColor];
        cell.detailTextLabel.text = @"";
        cell.tag = 111;
        // 设置右边的箭头
        cell.accessoryView = [self setMenuAccessoryView:cell];
        
    }else{ // 如果是选项cell,设置cell的样式
        
        cell.accessoryView = nil;
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = DKColorFontGray;
        cell.tag = 222;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 点击的cell
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.tag == 111) { // 点击的是父选项cell
        
        [self.view endEditing:YES];
        [self.tableView endEditing:YES];
        
        [self tableView:tableView didSelectParentOption:indexPath];
        
        // 得到点击cell在originArray里面的位置
        NSInteger indexInOrigin = [self.dk_originArray indexOfObject:cell.textLabel.text];
        
        // 取出对应的菜单选项
        NSArray *optionArray = self.dk_optionArray[indexInOrigin];
//        NSArray *detailArray = self.dk_detailArray[indexInOrigin];
        
        // 数组最后一个元素的位置（插入行之后才会是正确的值）
        NSInteger lastIndex = [self.dk_dataSorce indexOfObject:[optionArray lastObject]];
        
        
        if ([self.dk_dataSorce containsObject:optionArray[0]]) { // 如果菜单已经展开,关闭菜单
            
            // 如果元素名是相同的
            while (self.dk_dataSorce.count > lastIndex + 1 && [[self.dk_dataSorce objectAtIndex:lastIndex] isEqualToString:[self.dk_dataSorce objectAtIndex:lastIndex + 1]]) {
                lastIndex++;
            }
            
            NSInteger arrayCount = lastIndex - indexPath.row;
            // 数组长度(应该在插入行之后计算)
            
            // 得到选项的位置
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(indexPath.row + 1, arrayCount)];
            
            // 行的位置数组
            NSMutableArray<NSIndexPath *> *indexPathsArr = [NSMutableArray array];
            for (NSInteger i = indexPath.row + 1; i <= lastIndex; i++) {
                NSIndexPath *indexP = [NSIndexPath indexPathForRow:i inSection:indexPath.section];
                [indexPathsArr addObject:indexP];
            }
            
            // 把icon换成向下的
            cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_down_grey"]];
            
            // 选项从数据源删除
            [self.dk_dataSorce removeObjectsAtIndexes:indexSet];
//            [self.dk_detailTextDataSoure removeObjectsAtIndexes:indexSet];
            
            // tableView删除行
            [tableView deleteRowsAtIndexPaths:indexPathsArr withRowAnimation:UITableViewRowAnimationFade];
            
        }else{ // 如果还没有展开菜单，打开菜单
            
            // 得到选项的位置
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(indexPath.row + 1, optionArray.count)];
        
            // 行的位置数组
            NSMutableArray<NSIndexPath *> *indexPathsArr = [NSMutableArray array];
            for (NSInteger i = indexPath.row + 1; i <= indexPath.row + optionArray.count; i++) {
                NSIndexPath *indexP = [NSIndexPath indexPathForRow:i inSection:indexPath.section];
                [indexPathsArr addObject:indexP];
            }
            
            // 把icon换成向上的
            cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_top_grey"]];
            
            // 选项插入数据源
            [self.dk_dataSorce insertObjects:optionArray atIndexes:indexSet];
//            [self.dk_detailTextDataSoure insertObjects:detailArray atIndexes:indexSet];
            
            // tableView插入行
            [tableView insertRowsAtIndexPaths:indexPathsArr withRowAnimation:UITableViewRowAnimationFade];
        }
        
        // 显示分割线
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    }else if(cell.tag == 222){
        [self tableView:tableView didSelectOption:indexPath];
    }
    
}

/**
 *  展示所有选项
 */
- (void)showAllOption
{
    // 取出所有选项插入数据源数组
    [self.dk_optionArray enumerateObjectsUsingBlock:^(NSArray * _Nonnull optionArr, NSUInteger idx, BOOL * _Nonnull stop) {
        
        // 得到要插入的数据的起始位置（选项加在父选项的下面）
        NSInteger indexInDataSorce = [self.dk_dataSorce indexOfObject:self.dk_originArray[idx]] + 1;
        
        // 要插入的数据的位置+长度
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(indexInDataSorce, optionArr.count)];
        
        // 往数据源插入数据
        [self.dk_dataSorce insertObjects:optionArr atIndexes:indexSet];
    }];
    
    // 取出所有选项插入数据源数组
//    [self.dk_detailArray enumerateObjectsUsingBlock:^(NSArray * _Nonnull detailArr, NSUInteger idx, BOOL * _Nonnull stop) {
//    
//        // 得到要插入的数据的起始位置（选项加在父选项的下面）
//        NSInteger indexInDataSorce = [self.dk_detailTextDataSoure indexOfObject:self.dk_originArray[idx]] + 1;
//        
//        // 要插入的数据的位置+长度
//        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(indexInDataSorce, detailArr.count)];
//        
//        // 往数据源插入数据
//        [self.dk_detailTextDataSoure insertObjects:detailArr atIndexes:indexSet];
//    }];
}

/**
 *  设置这个cell的accessoryView
 */
- (UIImageView *)setMenuAccessoryView:(UITableViewCell *)cell
{
    // 取出这个父cell在origin的index
    NSInteger index = [self.dk_originArray indexOfObject:cell.textLabel.text];
    
    // 取出选项数组
    NSArray *optionArr = self.dk_optionArray[index];
    
    if ([self.dk_dataSorce containsObject:optionArr[0]]) { // 如果这个父选项的菜单已经展开了
//        cell.textLabel.textColor = DKColorRed;
        return [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_top_grey"]];
    }else {
//        cell.textLabel.textColor = [UIColor darkGrayColor];
    }
    
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_down_grey"]];
}

- (void)tableView:(UITableView *)tableView didSelectOption:(NSIndexPath *)indexPath
{
//    NSLog(@"%s 这个方法需要重写一下",__func__);
}


- (void)tableView:(UITableView *)tableView didSelectParentOption:(NSIndexPath *)indexPath
{
//    NSLog(@"%s 这个方法需要重写一下",__func__);
}

- (void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}

@end
