//
//  KLGroupSenderTableHeardView.m
//  BreatheDoctor
//
//  Created by comv on 16/4/25.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLGroupSenderTableHeardView.h"
#import "KLGroupSenderOperation.h"
#import "KLGroupSenderPatientListModel.h"

@interface KLGroupSenderTableHeardView ()
@property (nonatomic, strong) UILabel  *listCountLabel;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UILabel  *patientListLabel;
@end

@implementation KLGroupSenderTableHeardView

- (instancetype)initWithPatientListModel:(KLGroupSenderPatientListModel *)model{
    
    if ([super init]) {

        self.backgroundColor = [UIColor whiteColor];
        
        _listCountLabel = ({
            
            UILabel *label = [UILabel new];
            label.font = kNSPXFONT(26);
            label.textColor = [UIColor colorWithHexString:@"#666666"];
            label.text = [NSString stringWithFormat:@"分别发送给%@位朋友",kNSNumInteger(model.patientListCount)];
            label;
        });
        
        _addButton = ({
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
            [btn setImage:kImage(@"yishengduan.png") forState:UIControlStateNormal];
            btn;
        });
        
        _patientListLabel = ({
            
            UILabel *label = [UILabel new];
            label.font = kNSPXFONT(30);
            label.numberOfLines = 0;
            label.text = model.patientNmaes;
            label;
        });
        
        [self sd_addSubviews:@[_listCountLabel,_addButton,_patientListLabel]];
                
        _addButton.sd_layout
        .rightSpaceToView(self,20)
        .topSpaceToView(self,10)
        .widthIs(_addButton.imageView.image.size.width)
        .heightIs(_addButton.imageView.image.size.height);
        
        _listCountLabel.sd_layout
        .leftSpaceToView(self,15)
        .topSpaceToView(self,10)
        .rightSpaceToView(_addButton,5)
        .heightIs(_addButton.imageView.image.size.height);
        
        CGFloat height = [_patientListLabel.text heightWithFont:_patientListLabel.font constrainedToWidth:screenWidth-30];
        _patientListLabel.sd_layout
        .topSpaceToView(_listCountLabel,10)
        .leftSpaceToView(self,15)
        .rightSpaceToView(self,15)
        .heightIs(MAX(20, height))
        .maxHeightIs(250);
        

    }
    return self;
}
- (void)setListModel:(KLGroupSenderPatientListModel *)listModel{
    
    _listModel = listModel;
    
    _patientListLabel.text = listModel.patientNmaes;
    _listCountLabel.text = [NSString stringWithFormat:@"消息将发送给%@位朋友",kNSNumInteger(listModel.patientListCount)];
    CGFloat height = [_patientListLabel.text heightWithFont:_patientListLabel.font constrainedToWidth:screenWidth-30];

    _patientListLabel.sd_layout.heightIs(MAX(20, height));
}
- (void)backClick{

}
- (CGFloat)getHeight{
    CGFloat height = [_patientListLabel.text heightWithFont:_patientListLabel.font constrainedToWidth:screenWidth-30];
    return (_addButton.imageView.image.size.height  + 20 + MAX(20, height) + 10);
}

@end
