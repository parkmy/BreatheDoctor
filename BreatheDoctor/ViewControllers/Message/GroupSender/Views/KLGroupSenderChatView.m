//
//  KLGroupSenderChatBaseView.m
//  BreatheDoctor
//
//  Created by comv on 16/4/27.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLGroupSenderChatView.h"
#import "KLGroupSenderContentView.h"

@interface KLGroupSenderChatView ()

@property (nonatomic, strong) UILabel   *listCountLabel;
@property (nonatomic, strong) UILabel   *patientListLabel;
@property (nonatomic, strong) UIView    *topLine;
@property (nonatomic, strong) UIView    *bottomLine;
@property (nonatomic, strong) UIButton  *againSenderButton;


@property (nonatomic, strong) KLGroupSenderContentView    *contentView;



@end

@implementation KLGroupSenderChatView

- (id)initWithFrame:(CGRect)frame{
    
    if ([super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self setCornerRadius:4.0f];
        
        [self sd_addSubviews:@[self.listCountLabel,self.patientListLabel,self.topLine,self.contentView,self.bottomLine,self.againSenderButton]];
        
        self.listCountLabel.sd_layout
        .leftSpaceToView(self,10)
        .topSpaceToView(self,15)
        .rightSpaceToView(self,10)
        .heightIs(14);
        
        self.patientListLabel.sd_layout
        .leftEqualToView(self.listCountLabel)
        .topSpaceToView(self.listCountLabel,10)
        .rightEqualToView(self.listCountLabel)
        .autoHeightRatio(0);
        
        self.topLine.sd_layout
        .leftEqualToView(self.listCountLabel)
        .topSpaceToView(self.patientListLabel,10)
        .rightEqualToView(self.listCountLabel)
        .heightIs(.5);
        
        self.contentView.sd_layout
        .leftEqualToView(self.listCountLabel)
        .rightEqualToView(self.listCountLabel)
        .topSpaceToView(self.topLine,15);
        
        self.bottomLine.sd_layout
        .leftEqualToView(self.listCountLabel)
        .topSpaceToView(self.contentView,15)
        .rightEqualToView(self.listCountLabel)
        .heightIs(.5);
        
        self.againSenderButton.sd_layout
        .leftEqualToView(self.listCountLabel)
        .topSpaceToView(self.bottomLine,0)
        .rightEqualToView(self.listCountLabel)
        .heightIs(42);
        
        self.listCountLabel.text = @"listCountLabellistCountLabellistCountLabel";
        self.patientListLabel.text = @"patientListLabelpatientListLabelpatientListLabelpatientListLabel";
        
        [self setupAutoHeightWithBottomView:self.againSenderButton bottomMargin:0];
        
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureEventClick:)];
    }
    return self;
}

- (KLGroupSenderContentView *)contentView{

    if (!_contentView) {
        _contentView = [KLGroupSenderContentView new];
    }
    return _contentView;
}




- (UILabel *)listCountLabel{
    
    if (!_listCountLabel) {
        _listCountLabel = [UILabel new];
        _listCountLabel.font = kNSPXFONT(26);
        _listCountLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    }
    return _listCountLabel;
}

- (UILabel *)patientListLabel{
    
    if (!_patientListLabel) {
        _patientListLabel = [UILabel new];
        _patientListLabel.numberOfLines = 0;
        _patientListLabel.font = kNSPXFONT(30);
        _patientListLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    }
    return _patientListLabel;
}

- (UIView *)topLine{
    
    if (!_topLine) {
        _topLine = [UIView allocAppLineView];
    }
    return _topLine;
}

- (UIView *)bottomLine{
    
    if (!_bottomLine) {
        _bottomLine = [UIView allocAppLineView];
    }
    return _bottomLine;
}

- (UIButton *)againSenderButton{
    
    if (!_againSenderButton) {
        _againSenderButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _againSenderButton.backgroundColor = [UIColor clearColor];
        [_againSenderButton setTitle:@"再发一条" forState:UIControlStateNormal];
        [_againSenderButton setTitleColor:[UIColor colorWithHexString:@"#9cc75e"] forState:UIControlStateNormal];
    }
    return _againSenderButton;
}

#pragma mark - event
- (void)longPressGestureEventClick:(UILongPressGestureRecognizer *)sender{

    if (sender.state == UIGestureRecognizerStateBegan) {
        
    }
    
}
@end
