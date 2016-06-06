//
//  KLHomeItmModel.m
//  COButton
//
//  Created by liaowh on 16/6/2.
//  Copyright © 2016年 comv. All rights reserved.
//

#import "KLHomeItmModel.h"

@implementation KLHomeItmModel

+ (NSMutableArray *)getInitHomeItms{

    
    NSMutableArray *mainArray = [NSMutableArray array];
    
    for (int k = 0; k < 2; k++) {
        
        NSMutableArray *sectionArray = [NSMutableArray array];

        if (k == 0) {
        
            
            NSArray *section1Titles = @[@{@"title":@"患者咨询",@"image":@"huanzhezixun"},
                                        @{@"title":@"添加患者",@"image":@"tianjiahuanzhe"},
                                        @{@"title":@"我的日程",@"image":@"wodericheng"},
                                        @{@"title":@"医学工具",@"image":@"yixuegongju"},
                                        @{@"title":@"联系医助",@"image":@"lianxiyizhu"}];
        
            for (int section1Count = 0; section1Count < section1Titles.count; section1Count++) {
                
                KLHomeItmModel *model = [KLHomeItmModel new];
                NSDictionary *dic = section1Titles[section1Count];
                model.itmTitle = dic[@"title"];
                model.itmImage = kImage((NSString *)[dic objectForKey:@"image"]);
                [sectionArray addObject:model];
            }
            
        }else if (k == 1){
        
            for (int section2Count = 0; section2Count < 1; section2Count++) {
                
                KLHomeItmModel *model = [KLHomeItmModel new];
                [sectionArray addObject:model];
            }
        }
        [mainArray addObject:sectionArray];
    }
    
    return mainArray;
}
@end
