//
//  LWMedicationContentCell.m
//  BreatheDoctor
//
//  Created by comv on 16/3/17.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWMedicationContentCell.h"
#import "LWMedicationTypeView.h"

@interface LWMedicationContentCell ()
{
    LWMedicationTypeView *morningTypeView;
    LWMedicationTypeView *eveningTypeView;
    UILabel              *dateLabel;
    UIView               *dateView;
}

@end

@implementation LWMedicationContentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = 0;
        
        UIView *contenView = [UIView new];
        [self addSubview:contenView];
        contenView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 10, 0, 10));
        
 
        
         dateView = ({
            UIView *bg = [UIView new];
            bg.backgroundColor = [UIColor whiteColor];
            [contenView addSubview:bg];
            bg.sd_layout.leftSpaceToView(contenView,0).topSpaceToView(contenView,0).bottomSpaceToView(contenView,0).widthRatioToView(contenView,.25);

            UIView *line = [UIView new];
            line.backgroundColor = [LWThemeManager shareInstance].navBackgroundColor;
            [bg addSubview:line];
            line.sd_layout.leftSpaceToView(bg,0).topSpaceToView(bg,10).bottomSpaceToView(bg,10).widthIs(4);

            dateLabel = [UILabel new];
            dateLabel.text = @"2016-03-16";
            dateLabel.font = kNSPXFONT(22);
            dateLabel.textColor = [UIColor colorWithHexString:@"#666666"];
            dateLabel.textAlignment = 1;
            [bg addSubview:dateLabel];
            dateLabel.sd_layout.leftSpaceToView(line,0).topSpaceToView(bg,10).bottomSpaceToView(bg,10).rightSpaceToView(bg,0);

            bg;
        });
        
        
        UIView *line = [UIView allocAppLineView];
        [contenView addSubview:line];
        line.sd_layout.leftSpaceToView(dateView,0).topSpaceToView(contenView,0).bottomSpaceToView(contenView,0).widthIs(.5);
 
        morningTypeView = ({
            LWMedicationTypeView *view = [LWMedicationTypeView new];
            [view setTimerString:@"早上"];
            [contenView addSubview:view];
            view.sd_layout.leftSpaceToView(line,0).topSpaceToView(contenView,0).rightSpaceToView(contenView,0).heightRatioToView(contenView,.5);
            view;
        });
        
        eveningTypeView = ({
            LWMedicationTypeView *view = [LWMedicationTypeView new];
            [view setTimerString:@"晚上"];
            [contenView addSubview:view];
            view.sd_layout.leftSpaceToView(line,0).topSpaceToView(morningTypeView,0).rightSpaceToView(contenView,0).heightRatioToView(contenView,.5);
            view;
        });
    
        UIView *bottomline = [UIView allocAppLineView];
        [contenView addSubview:bottomline];
        bottomline.sd_layout.leftSpaceToView(contenView,0).bottomSpaceToView(contenView,0).heightIs(.5).rightSpaceToView(contenView,0);
        
        UIView *leftLine = [UIView allocAppLineView];
        [contenView addSubview:leftLine];
        UIView *rightLine = [UIView allocAppLineView];
        [contenView addSubview:rightLine];
        leftLine.sd_layout.leftSpaceToView(contenView,0).topSpaceToView(contenView,0).bottomSpaceToView(contenView,0).widthIs(.5);
        rightLine.sd_layout.rightSpaceToView(contenView,0).topSpaceToView(contenView,0).bottomSpaceToView(contenView,0).widthIs(.5);
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
