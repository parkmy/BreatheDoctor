//
//  KLGroupSenderChatBaseView.m
//  BreatheDoctor
//
//  Created by comv on 16/4/27.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLGroupSenderChatView.h"
#import "KLGroupSenderContentView.h"
#import "KLGroupSenderChatModel.h"

@interface KLGroupSenderChatView ()

@property (nonatomic, strong) UILabel   *listCountLabel;
@property (nonatomic, strong) UILabel   *patientListLabel;
@property (nonatomic, strong) UIView    *topLine;
@property (nonatomic, strong) UIView    *bottomLine;

@property (nonatomic, strong) UIView    *longBgView;

@end

@implementation KLGroupSenderChatView

- (id)initWithFrame:(CGRect)frame{
    
    if ([super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self setup];
        
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureEventClick:)];
        [self addGestureRecognizer:longPressGesture];
        
        UITapGestureRecognizer  *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureEventClick:)];
        [self addGestureRecognizer:tapGesture];

    }
    return self;
}
#pragma mark - event
- (void)tapGestureEventClick:(UITapGestureRecognizer *)sender{
    
    [self setupNormalMenuController];
}
- (void)longPressGestureEventClick:(UILongPressGestureRecognizer *)sender{
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        self.longBgView.frame = self.bounds;
        self.longBgView.hidden = NO;
        [self addSubview:self.longBgView];
        
        [self becomeFirstResponder];

        UIMenuController *menu = [UIMenuController sharedMenuController];
        
        UIMenuItem *removeItem = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(removeItemClicked:)];
        
        [menu setMenuItems:[NSArray arrayWithObjects:removeItem,nil]];
        
        
        CGRect menuRect = self.bounds;
        menuRect.origin.x = menuRect.size.width - 80;
        menuRect = menuRect;
        
        [menu setTargetRect:menuRect inView:self];
        
        [menu setMenuVisible:YES animated:YES];
        
    }else if (sender.state == UIGestureRecognizerStateEnded){
        self.longBgView.hidden = YES;
    }
}
- (BOOL)canBecomeFirstResponder
{
    return YES;
}
- (void)setupNormalMenuController {
    UIMenuController *menu = [UIMenuController sharedMenuController];
    if (menu.isMenuVisible) {
        [menu setMenuVisible:NO animated:YES];
    }
}
- (void)removeItemClicked:(id)sender{
    
}

- (KLGroupSenderContentView *)contentView{

    if (!_contentView) {
        _contentView = [KLGroupSenderContentView new];
    }
    return _contentView;
}

- (void)setModel:(id)model{
    
    _model = model;
    
    KLGroupSenderChatModel *chatModel = model;
    
    self.patientListLabel.text = chatModel.patientNames;
    
    self.listCountLabel.text = [NSString stringWithFormat:@"消息已发送给%@位患者",kNSNumInteger(chatModel.patientNum)];
    
    self.contentView.model = chatModel;

}

- (UIView *)longBgView{
    
    if (!_longBgView) {
        _longBgView = [UIView new];
        _longBgView.frame = self.bounds;
        _longBgView.backgroundColor = RGBA(0, 0, 0, .2);
    }
    return _longBgView;
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
        _againSenderButton.titleLabel.font = kNSPXFONT(26);
        [_againSenderButton setTitle:@"再发一条" forState:UIControlStateNormal];
        [_againSenderButton setTitleColor:[UIColor colorWithHexString:@"#9cc75e"] forState:UIControlStateNormal];
    }
    return _againSenderButton;
}
- (void)setup{
    
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
    .heightIs(42*MULTIPLE);
    
    [self setupAutoHeightWithBottomView:self.againSenderButton bottomMargin:0];
    
    
}

@end
