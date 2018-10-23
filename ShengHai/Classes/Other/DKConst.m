#import <UIKit/UIKit.h>

/** 服务器IP */
NSString *const DKAPIDomain = @"https://hd.dankal.cn/";
/** API根路径 */
NSString *const DKAPIBaseURL = @"https://hd.dankal.cn/index.php/app/";
/** 分页每页数量 */
NSInteger const DKPageSize = 20;

/** 通用的间距值 */
CGFloat const DKMargin = 20;
/** 通用的小间距值 */
CGFloat const DKSmallMargin = DKMargin * 0.5;
/** Group Style tableView top inset */
CGFloat const DKGroupTableViewInsetTop = 35;

/** 网络异常 */
NSString *const DKNetworkError = @"网络异常";
/** 未登录 */
NSString *const DKUnLoginError = @"未登录";
/** 个人信息更新通知 */
NSNotificationName const DKUserInfoDidUpdatedNotification = @"DKUserInfoDidUpdatedNotification";
/** 推送跳转通知 */
NSNotificationName const DKNoticeJumpNotification = @"DKNoticeJumpNotification";
