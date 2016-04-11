//
//  LWBaseHistoricalHeardView.h
//  BreatheDoctor
//
//  Created by comv on 16/3/15.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LWBaseHistoricalView;

typedef NS_ENUM(NSInteger , showHistoricalType) {
    showHistoricalTypePEF = 0,
    showHistoricalTypeSymptoms,
    showHistoricalTypeMedication,
};
@interface LWHistoricalHeardView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, strong) UILabel *footLabel;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LWBaseHistoricalView *baseHistoricalView;

@property (nonatomic, strong) UIView  *breadView;
@property (nonatomic, assign) showHistoricalType historicalType;

- (void)setFootLabelTitle:(NSString *)string;
- (void)setScaleCircleWithObjc:(KLPatientLogBodyModel *)objc;
- (void)setScaleCircleDateText:(NSString *)text;
@end
