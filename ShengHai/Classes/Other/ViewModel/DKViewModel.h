//
//  DKViewModel.h
//  TYGoods
//
//  Created by 庄槟豪 on 2017/3/20.
//  Copyright © 2017年 TY. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DKSubscribeErrors \
@weakify(self); \
[self.vm.errors subscribeNext:^(NSError *error) { \
    @strongify(self); \
    DKLog(@"%@,%@",NSStringFromClass([self class]), error.localizedDescription); \
    [DKProgressHUD showErrorWithStatus:error.localizedDescription]; \
}];

@interface DKViewModel : NSObject

/** Errors */
@property (nonatomic, strong, readonly) RACSubject *errors;

/** NoMoreData Subject */
@property (nonatomic, strong, readonly) RACSubject *noMoreSubject;

/** table loadData Command */
@property (nonatomic, strong, readonly) RACCommand *loadDataCommand;

/** Commands */
- (NSArray<RACCommand *> *)commands;

/** setup */
- (void)setup;

@end
