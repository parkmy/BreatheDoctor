//
//  KLGuideModel.h
//  BreatheDoctor
//
//  Created by liaowh on 16/6/6.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  单元格类型
 */
typedef NS_ENUM(NSInteger,GuideCellType) {
    /**
     *  文字
     */
    GuideCellTypeText = 0,
    /**
     *  图文
     */
    GuideCellTypeImageText = 1,
};
@interface KLGuideModel : NSObject

@property (nonatomic, assign) GuideCellType type;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) UIImage *contentImage;

+ (NSMutableArray *)getInitGuideDoctorPatientModels;
+ (NSMutableArray *)getInitGuidePlatformServicesModels;

+ (void)setAttributedStringWithLabel:(UILabel *)label;

@end
