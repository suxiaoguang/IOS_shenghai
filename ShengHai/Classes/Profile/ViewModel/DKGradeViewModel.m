//
//  DKGradeViewModel.m
//  ShengHai
//
//  Created by nanzeng liu on 2017/7/7.
//  Copyright © 2017年 cn.dankal. All rights reserved.
//

#import "DKGradeViewModel.h"

#import "DKProfileService.h"

@interface DKGradeViewModel ()
/** 评价列表数组 */
@property (nonatomic, strong) NSArray<DKStarInfoDetail *> *starInfoDetails;
/** 获取评价列表 */
@property (nonatomic, strong) RACCommand *fetchAccountScoreListCommand;
/** 获取评价详情 */
@property (nonatomic, strong) RACCommand *fetchStarInfoDetailCommand;
@end

@implementation DKGradeViewModel

- (RACCommand *)loadDataCommand
{
    return self.fetchAccountScoreListCommand;
}

- (NSArray<RACCommand *> *)commands
{
    return @[self.fetchAccountScoreListCommand,
             self.fetchStarInfoDetailCommand
             ];
}
- (RACCommand *)fetchAccountScoreListCommand
{
    if (!_fetchAccountScoreListCommand) {
        @weakify(self);
        _fetchAccountScoreListCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [[DKProfileService fetchAccountScoreListWithPage:input num:DKPageSize] map:^id(id value) {
                if ([input integerValue] > 1) {
                    if (![value count]) [self.noMoreSubject sendNext:nil];
                    value = [self.starInfoDetails arrayByAddingObjectsFromArray:value];
                }
                return value;
            }];
        }];
    }
    return _fetchAccountScoreListCommand;
}

- (RACCommand *)fetchStarInfoDetailCommand
{
    if (!_fetchStarInfoDetailCommand) {
        @weakify(self);
        _fetchStarInfoDetailCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [DKProfileService fetchStarInfoDetailWithOrderId:self.orderId];
        }];
    }
    return _fetchStarInfoDetailCommand;
}

- (void)setup
{
    [super setup];
    @weakify(self);
    [self.fetchAccountScoreListCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        @strongify(self);
        self.starInfoDetails = x;
    }];
}

@end
