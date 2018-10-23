#import <UIKit/UIKit.h>

/** 服务器IP */
FOUNDATION_EXPORT NSString * const DKAPIDomain;
/** API根路径 */
FOUNDATION_EXPORT NSString * const DKAPIBaseURL;

/** 分页每页数量 */
FOUNDATION_EXPORT NSInteger const DKPageSize;

/** 通用的间距值 */
FOUNDATION_EXPORT CGFloat const DKMargin;
/** 通用的小间距值 */
FOUNDATION_EXPORT CGFloat const DKSmallMargin;
/** Group Style tableView top inset */
FOUNDATION_EXPORT CGFloat const DKGroupTableViewInsetTop;

/** 网络异常 */
FOUNDATION_EXPORT NSString * const DKNetworkError;
/** 未登录 */
FOUNDATION_EXPORT NSString * const DKUnLoginError;
/** 个人信息更新通知 */
FOUNDATION_EXPORT NSNotificationName const DKUserInfoDidUpdatedNotification;
/** 推送跳转通知 */
FOUNDATION_EXPORT NSNotificationName const DKNoticeJumpNotification;
