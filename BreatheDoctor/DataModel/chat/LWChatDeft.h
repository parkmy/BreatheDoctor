//
//  LWChatDeft.h
//  BreatheDoctor
//
//  Created by comv on 15/11/16.
//  Copyright © 2015年 lwh. All rights reserved.
//

#ifndef LWChatDeft_h
#define LWChatDeft_h

/**
 *  @brief  消息类型
 */

//1 普通问答 2 请求消息 3 同意消息 4、首次就诊提醒 5、首诊就诊报告6、复诊就诊报告
// 7、记录PEF提醒 8、完成ACT评估 9、完成哮喘评估 11、复诊提醒
//  12、PEF记录通知
typedef NS_OPTIONS(NSInteger,WSChatMessageType)
{
    /**
     *  @brief  普通问答
     */
    WSChatMessageType_Text = 1,
    
    /**
     *  @brief  图片消息
     */
    WSChatMessageType_Request = 2,
    
    /**
     *  @brief  同意消息
     */
    WSChatMessageType_Agreed = 3,
    
    /**
     *  @brief  首次就诊提醒
     */
    WSChatMessageType_FirstSeeDoctorRemind = 4,
    
    /**
     *  @brief  首诊就诊报告
     */
    WSChatMessageType_FirstSeeDoctorReport = 5,
    
    /**
     *  @brief  复诊就诊报告
     */
    WSChatMessageType_VisitReport  = 6,
    /**
     *  @brief  记录PEF提醒
     */
    WSChatMessageType_PEFRemind  = 7,
    /**
     *  @brief  完成ACT评估
     */
    WSChatMessageType_ACAassessment  = 8,
    /**
     *  @brief  完成哮喘评估
     */
    WSChatMessageType_AsthmaAassessment  = 9,
    /**
     *  @brief  复诊提醒
     */
    WSChatMessageType_VisitRemind  = 11,
    /**
     *  @brief  PEF记录通知
     */
    WSChatMessageType_PEFRecord  = 12,
    
};


#endif /* LWChatDeft_h */
