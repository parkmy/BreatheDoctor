//
//  KLPatientRelatedModel.m
//  BreatheDoctor
//
//  Created by comv on 16/3/24.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLPatientRelatedModel.h"
#define photoCellRowHeight (screenHeight-64-(120*MULTIPLEVIEW)*2-75-20)

@implementation KLPatientRelatedModel

+ (NSMutableArray *)patientRelatedModels
{
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 0; i < 3; i++)
    {
        KLPatientRelatedModel *model = [KLPatientRelatedModel new];
        if (i == 0) {
            model.titleNmae=@"诊断结果";
            model.iconImageNmae = @"jieguo";
            model.placeholder = @"请填写诊断结果...";
            model.cellRowHeight = 120*MULTIPLEVIEW;
        }else if (i == 1)
        {
            model.titleNmae=@"基本病情";
            model.iconImageNmae = @"bingqing";
            model.placeholder = @"请描述患者基本病情...";
            model.cellRowHeight = 120*MULTIPLEVIEW;

        }else
        {
            model.titleNmae=@"相关照片";
            model.iconImageNmae = @"zhaopian";
            model.placeholder = @"";
            model.images = [NSMutableArray array];
            model.cellRowHeight = photoCellRowHeight;
        }
        [array addObject:model];
    }
    
    return array;
}
+ (NSMutableArray *)patientRelatedModelsWithModel:(LWPatientRelatedModel *)model andArray:(NSMutableArray *)array
{
    
    for (int i = 0; i < array.count; i++)
    {
        KLPatientRelatedModel *patientRelatedModel = array[i];
        if (i == 0) {
            patientRelatedModel.contentString = model.treatmentResult;

        }else if (i == 1)
        {
            patientRelatedModel.contentString = model.basicCondition;
            
        }else
        {
            patientRelatedModel.imagesString = model.images;
            NSMutableString *imagesMutableString = [[NSMutableString alloc] initWithString:stringJudgeNull(model.images)];
            [patientRelatedModel.images removeAllObjects];
            if (imagesMutableString.length > 0) {
                for (NSString *url in [NSMutableArray arrayWithArray:[stringJudgeNull(imagesMutableString) componentsSeparatedByString:@"|"]])
                {
                    if (url.length > 0) {
                        [patientRelatedModel.images addObject:url];
                    }
                }
            }
        }
    }
    
    return array;
}

- (void)updateImagesString:(NSMutableArray *)updateImages
{
    NSMutableString *string = [[NSMutableString alloc] initWithString:@""];
    for (id objc in self.images) {
        if ([objc isKindOfClass:[NSString class]]) {
            [string appendString:[NSString stringWithFormat:@"%@|",objc]];
        }
    }
    for (NSString *url in updateImages) {
        [string appendString:[NSString stringWithFormat:@"%@|",url]];
    }
    if (string.length > 0) {
        if ([[string substringWithRange:NSMakeRange(string.length-1, 1)] isEqualToString:@"|"]) {
            [string deleteCharactersInRange:NSMakeRange(string.length-1, 1)];
        }
    }
    self.imagesString = string;

}
- (void)addImages:(NSArray *)array
{
    [self.images addObjectsFromArray:array];
    if (array.count > 0) {
        self.isChange = YES;
    }
    [self imagesChangeHeight:self.images];
}
- (void)deleteImage:(id)objc
{
    if (!objc) {
        return;
    }
    [self.images removeObject:objc];
    self.isChange = YES;
    [self imagesChangeHeight:self.images];
}
- (void)imagesChangeHeight:(NSMutableArray *)images
{
    CGFloat wh = (Screen_SIZE.width - 30)/3 - 10;
    
    int count = images.count/3 + 1;
    
    CGFloat ch =  50 + count*(wh + 15 + 5);
    
    if (ch > photoCellRowHeight) {
        self.cellRowHeight = ch;
    }else
    {
        self.cellRowHeight = photoCellRowHeight
        ;
    }
}

@end
