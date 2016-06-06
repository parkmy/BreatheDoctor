//
//  KLGuideModel.m
//  BreatheDoctor
//
//  Created by liaowh on 16/6/6.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLGuideModel.h"

@implementation KLGuideModel


+ (NSMutableArray *)getInitGuideDoctorPatientModels{
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (int sec = 0; sec < 2; sec++) {
        
        NSMutableDictionary *secDic = [NSMutableDictionary dictionary];
        
        if (sec == 0) {
            
            NSMutableArray *rowArray = [NSMutableArray array];
            
            KLGuideModel *model = [KLGuideModel new];
            model.content = @"患者绑定后，您可以对患者进行分类，更方便的开展患者院外管理并提供有偿咨询服务。";
            model.type = 0;
            
            [rowArray addObject:model];
            
            [secDic setObject:rowArray forKey:@"1.为什么要绑定患者？"];
            
        }else if (sec == 1){
            
            NSMutableArray *rowArray = [NSMutableArray array];
            
            for (int row = 0; row < 2; row++) {
                
                KLGuideModel *model = [KLGuideModel new];
                model.type = 1;
                if (row == 0) {
                    
                    model.title = @"（1）患者扫描医生二维码";
                    model.content = @"点击首页“我的名片”或者患者页面“添加患者”按钮。患者在门诊时，通过微信扫一扫可直接关注您";
                    model.contentImage = kImage(@"bangdingtop");
                }else if (row == 1){
                    
                    model.title = @"（2）患者在呼吸卫士公众号查找医生";
                    model.content = @"您在平台开通服务后，患者关注“呼吸卫士我的卫士”公众号后，点击问医生-查找医生会搜索到您，并进行付费咨询";
                    model.contentImage = kImage(@"bangdingdown");
                }
                [rowArray addObject:model];
            }
            
            [secDic setObject:rowArray forKey:@"2.如何绑定患者？"];
            
        }
        
        [array addObject:secDic];
    }
    return array;
}
+ (NSMutableArray *)getInitGuidePlatformServicesModels{
    
    NSMutableArray *array = [NSMutableArray array];
    NSMutableArray *rowArray = [NSMutableArray array];

    NSMutableDictionary *secDic = [NSMutableDictionary dictionary];
    
    for (int row = 0; row < 2; row++) {
        
        KLGuideModel *model = [KLGuideModel new];
        model.type = 1;
        if (row == 0) {
            
            model.title = @"  第一步：注册登录";
            model.content = @"注册呼吸卫士平台，需要我们的市场人员和客服人员分派给您入驻邀请码（客服电话4007-038-039），进入到平台。";
            model.contentImage = kImage(@"zhucetop");

        }else if (row == 1){
            
            model.title = @"  第二步";
            model.content = @"将您的个人信息：头像，姓名，电话，医院，科室，职称，简介，擅长，医师执照提交给您身边的代理商或拨打客服电话进行信息登记，审核通过后您的服务即可开通";
            model.contentImage = kImage(@"zhucedown");

        }
        [rowArray addObject:model];
    }
    
    [secDic setObject:rowArray forKey:@"怎样开通平台服务？"];
    
    [array addObject:secDic];
    
    return array;
}
+ (void)setAttributedStringWithLabel:(UILabel *)label{
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
    
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:label.text attributes:@{NSFontAttributeName:label.font,NSForegroundColorAttributeName : label.textColor, NSParagraphStyleAttributeName: paragraphStyle}];
    
    label.attributedText = string;
}
@end
