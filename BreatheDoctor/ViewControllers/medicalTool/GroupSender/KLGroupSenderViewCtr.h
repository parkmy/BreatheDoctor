//
//  KLGroupSenderViewCtr.h
//  BreatheDoctor
//
//  Created by comv on 16/4/25.
//  Copyright © 2016年 lwh. All rights reserved.
// 群发对话界面

#import "BaseViewController.h"
@class KLGroupSenderPatientListModel;
/**
 *  进入类型
 */
typedef NS_ENUM(NSInteger, PUSHTYPE) {
    /**
     *  患者列表
     */
    PUSHTYPELIST = 0,
    /**
     *  再次发
     */
    PUSHTYPEAGAIN,
};
@interface KLGroupSenderViewCtr : BaseViewController

@property (nonatomic, assign) PUSHTYPE pushType;

- (instancetype)initWithGroupSenderPatientListModel:(KLGroupSenderPatientListModel *)listModel;
- (void)guoupSenderSuccess;

@end
