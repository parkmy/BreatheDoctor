//
//  LWHistoricalLogCell.m
//  BreatheDoctor
//
//  Created by comv on 16/3/18.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWHistoricalLogCell.h"
#import "LWLogStateView.h"
#import "LWScaleCircleView.h"
#import "LWHistoricalLogModel.h"
#import "NSDate+Extension.h"

@interface LWHistoricalLogCell ()
{
    UILabel *dateLabel;
    UILabel *timeFrame;
    UIView  *contentBreadView;
    LWLogStateView *symptomsState;
    LWLogStateView *medicationState;
}
@property (nonatomic, strong) LWScaleCircleView *scaleCircleView;

@end
@implementation LWHistoricalLogCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = 0;
        
        dateLabel = ({
            UILabel *label = [UILabel new];
            label.font = kNSPXFONT(24);
            label.textColor = [UIColor colorWithHexString:@"#999999"];
            [self addSubview:label];
            label;
        });
        dateLabel.text = @"0日/00月 0000";
        
        timeFrame = ({
            UILabel *label = [UILabel new];
            label.font = kNSPXFONT(24);
            label.textColor = [UIColor colorWithHexString:@"#333333"];
            [self addSubview:label];
            label;
        });
        timeFrame.text = @"上午";
        
        contentBreadView = ({
            UIView *view = [UIView new];
            [self addSubview:view];
            view;
        });
        [contentBreadView addSubview:self.scaleCircleView];
        
        contentBreadView.backgroundColor = [UIColor whiteColor];
        
        UIView *line = [UIView allocAppLineView];
        [self addSubview:line];
        
        symptomsState = [LWLogStateView new];
//        symptomsState.backgroundColor = [UIColor redColor];
        [symptomsState setStateIconImageName:@"jizhengzhuang"];
        [symptomsState setStateTitleName:@"记症状"];
        [self addSubview:symptomsState];
        
        UIView *line2 = [UIView allocAppLineView];
        [self addSubview:line2];
        
        medicationState = [LWLogStateView new];
        [medicationState setStateIconImageName:@"jiyongyao"];
        [medicationState setStateTitleName:@"记用药"];
        [self addSubview:medicationState];
        
        dateLabel.sd_layout.leftSpaceToView(self,10).topSpaceToView(self,10).widthIs(100).heightIs(20*MULTIPLEVIEW);
        timeFrame.sd_layout.leftSpaceToView(dateLabel,0).topSpaceToView(self,17).widthIs(100).heightIs(13*MULTIPLEVIEW);
        contentBreadView.sd_layout.leftSpaceToView(self,10).topSpaceToView(dateLabel,5).rightSpaceToView(self,10).heightIs(220*MULTIPLEVIEW/2);
        line.sd_layout.leftSpaceToView(self,10).topSpaceToView(contentBreadView,0).rightSpaceToView(self,10).heightIs(.5);
        medicationState.sd_layout.leftSpaceToView(self,10).bottomSpaceToView(self,5).rightSpaceToView(self,10).heightIs(70*MULTIPLEVIEW);
        line2.sd_layout.leftSpaceToView(self,50).rightSpaceToView(self,0).bottomSpaceToView(medicationState,0).heightIs(.5);
        symptomsState.sd_layout.leftSpaceToView(self,10).topSpaceToView(line,0).rightSpaceToView(self,13).bottomSpaceToView(line2,0);
        self.scaleCircleView.sd_layout.widthIs(182*MULTIPLEVIEW/2).heightIs(182*MULTIPLEVIEW/2).centerXEqualToView(contentBreadView).centerYEqualToView(contentBreadView);
        
        
    }
    return self;
}
- (LWScaleCircleView *)scaleCircleView
{
    if (!_scaleCircleView) {
        _scaleCircleView = [LWScaleCircleView new];
        _scaleCircleView.centerLabelColor = [UIColor colorWithHexString:@"#999999"];
        _scaleCircleView.isFourth = YES;
    }
    return _scaleCircleView;
}
- (void)changeDate:(NSString *)date
{
    NSArray *array = [stringJudgeNull(date) componentsSeparatedByString:@"/"];
    NSString *str1 = array[0];
    NSString *str2 = nil;
    if (array.count > 1) {
        str2 =array[1];
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:date];
    [attributedString addAttributes:@{NSFontAttributeName:kNSPXFONT(24),NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#333333"]} range:NSMakeRange(str1.length-1, 1)];
    [attributedString addAttributes:@{NSFontAttributeName:kNSPXFONT(40),NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#333333"]} range:NSMakeRange(0, str1.length-1)];
    dateLabel.attributedText = attributedString;
    dateLabel.sd_layout.widthIs([dateLabel.text sizeWithFont:kNSPXFONT(30) constrainedToHeight:20].width);
}

- (void)setObjc:(id)objc
{
    _objc = objc;
    LWHistoricalLogModel *model = _objc;
    
    if (model.logModel.timeFrame == 1) {
        timeFrame.text = @"早上";
    }else{
        timeFrame.text = @"晚上";
    }
    
    symptomsState.dataArray = model.symptoms;
    medicationState.dataArray = model.medication;
    
//    model.rowHeight = (286-60)*MULTIPLEVIEW + [medicationState collectionViewContentHeight] + [symptomsState collectionViewContentHeight];
//    NSLog(@"------%f",[medicationState collectionViewContentHeight]);
    self.scaleCircleView.isShowBottomLabel = YES;
    self.scaleCircleView.lineWith = 3.0f;
    self.scaleCircleView.animation_time = 0;
    self.scaleCircleView.centerLable.text = kNSString(kNSNumDouble(model.pefValue));
    self.scaleCircleView.firstScale = model.pefValue/model.pefPredictedValue;
    self.scaleCircleView.secondScale = (model.pefPredictedValue - model.pefValue)/model.pefPredictedValue;;
    [self.scaleCircleView setdateText:@"最佳值"];
    
    [self changeDate:[NSDate stringWithDate:[NSDate dateWithString:model.recordDt format:[NSDate ymdFormat]] format:@"dd日/MM月 yyyy"]];
    
    if (model.historicalLogType == HistoricalLogTypeTheBest)
    {
        self.scaleCircleView.firstColor = [LWHistoricalLogModel theBestDeepColor];
        self.scaleCircleView.secondColor = [LWHistoricalLogModel theBestShallowColor];
        
        self.scaleCircleView.fourthColor = [LWHistoricalLogModel theBestShallowColor];
        self.scaleCircleView.centerLable.textColor = [LWHistoricalLogModel theBestDeepColor];
    }else if (model.historicalLogType == HistoricalLogTypeGeneral)
    {
        self.scaleCircleView.firstColor = [LWHistoricalLogModel generalDeepColor];
        self.scaleCircleView.secondColor = [LWHistoricalLogModel generalShallowColor];

        self.scaleCircleView.fourthColor = [LWHistoricalLogModel generalShallowColor];
        self.scaleCircleView.centerLable.textColor = [LWHistoricalLogModel generalDeepColor];
    }else
    {
        self.scaleCircleView.firstColor = [LWHistoricalLogModel poorDeepColor];
        self.scaleCircleView.secondColor = [LWHistoricalLogModel poorShallowColor];

        self.scaleCircleView.fourthColor = [LWHistoricalLogModel poorShallowColor];
        self.scaleCircleView.centerLable.textColor = [LWHistoricalLogModel poorDeepColor];
    }
    [self.scaleCircleView setNeedsDisplay];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
