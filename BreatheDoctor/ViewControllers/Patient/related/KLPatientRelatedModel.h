//
//  KLPatientRelatedModel.h
//  BreatheDoctor
//
//  Created by comv on 16/3/24.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LWPatientRelatedModel.h"

@interface KLPatientRelatedModel : NSObject

@property (nonatomic, copy)     NSString *contentString;
@property (nonatomic, copy)     NSString *placeholder;
@property (nonatomic, assign)   CGFloat cellRowHeight;
@property (nonatomic, copy)     NSString *iconImageNmae;
@property (nonatomic, copy)     NSString *titleNmae;

@property (nonatomic, copy)     NSString *imagesString;
@property (nonatomic, strong)   NSMutableArray *images;

@property (nonatomic, assign)   BOOL   isChange;

+ (NSMutableArray *)patientRelatedModels;
+ (NSMutableArray *)patientRelatedModelsWithModel:(LWPatientRelatedModel *)model andArray:(NSMutableArray *)array;

- (void)updateImagesString:(NSMutableArray *)updateImages;
- (void)addImages:(NSArray *)array;
- (void)deleteImage:(id)objc;
- (void)imagesChangeHeight:(NSMutableArray *)images;

@end
