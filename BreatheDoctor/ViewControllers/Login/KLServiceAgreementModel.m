//
//  KLServiceAgreementModel.m
//  BreatheDoctor
//
//  Created by comv on 16/5/18.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLServiceAgreementModel.h"

@implementation KLServiceAgreementModel

+ (NSMutableArray *)serviceAgreements{

    NSMutableArray *array = [NSMutableArray array];
    
    for (int k = 0; k < 4; k++) {
        
        KLServiceAgreementModel *model = [KLServiceAgreementModel new];
        
        switch (k) {
            case 0:
            {
                model.title = @"服务协议";
                model.content = @"本服务协议双方为康联畅享（北京）医疗科技有限公司（甲方）与呼吸卫士医生版客户端用户（乙方），协议具有合同效力。\n呼吸卫士医生版为康联畅享（北京）医疗科技有限公司研发的产品。\n本服务协议内容包括正文及甲方已经发布或将来发布的所有规则。所有规则作为本服务协议不可分割的一部分，与协议正文具有同等的法律效力。\n甲方保留对本服务协议不定时修改的权利，且拥有协议的最终解释权。";
                
            }
                break;
            case 1:
            {
                model.title = @"隐私声明";
                model.content = @"乙方在注册呼吸卫士医生版产品时，根据网站或客户端产品的要求提供个人信息。服务器会自动接收并记录乙方的个人信息。甲方承诺不向任何人泄露乙方个人信息，除非:\n1.事先得到乙方的许可；\n2.该等信息属于为提供乙方所要求的产品和服务，而必须和第三方分享的乙方个人信息；\n3.乙方符合资格的知识产权投诉人并已提供投诉，应被投诉人要求，向被投诉人披露，以便双方处理可能的权利纠纷；\n4.根据相关法律规定，应行政机关或司法机关披露；\n5.乙方出现违反中国相关法律或者网站政策的情况，需要向第三方披露；\n6.属于其他本网站根据法律或者网站政策认为合适的披露情形；\n7.乙方注册成功后，须妥善保管账号和密码，因为乙方个人原因导致信息泄露而造成的任何损失由乙方自行承担；\n8.乙方须确保注册时所提供的信息真实，完整，不得冒用他人名义，或以他人身份信息进行账号注册，由此给他人造成的损失由乙方承担责任；";
            }
                break;
            case 2:
            {
                model.title = @"免责声明";
                model.content = @"呼吸卫士医生版合理地关注了相关疾病信息的搜集和报告，仅选用经过正规医疗机构和执业医生发布的内容，有理由说明这些信息的可靠性。对于因信息的不断变化，以及任何错误、遗漏和不确切之处所引起的后果，”呼吸卫士医生版（及医生)”及合作伙伴概不承担任何责任。\n系统内所发布的信息及提供的提醒帮助只作为参考和补充，并不能替代临床诊断，也无法替代医嘱。所列的信息仅供用户参考。如果因使用了本软件所登载的信息后出现不良反应、损伤、死亡或其他不良后果，无论是直接或间接引起的，“呼吸卫士医生版（及医生)”及合作伙伴概不承担任何责任。";
            }
                break;
            case 3:
            {
                
                model.title = @"版权声明";
                model.content = @"康联畅享（北京）医疗科技有限公司享有呼吸卫士医生版客户端产品中的图标设计、界面设计和程序源代码、数据结构的全部版权。未经甲方授权，任何机构和个人无权使用康联畅享（北京）医疗科技有限公司的版权内容。\n呼吸卫士医生版客户端产品在运营过程中由用户和医生产生的文字、图片等内容信息的版权归康联畅享（北京）医疗科技有限公司享有；甲方可以在不通知用户和医生的前提下，重复使用上述信息；在使用这些信息的过程中，甲方保证用户的隐私数据安全\n康联畅享（北京）医疗科技有限公司";
            }
                break;
            default:
                break;
        }
        model.rowHight = [model.content heightWithFont:kNSPXFONT(22) constrainedToWidth:screenWidth-30]+30+105;
        [array addObject:model];
    }
    
    return array;
}
@end
