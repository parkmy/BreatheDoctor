//
//  KLNavigationBarView.m
//  COButton
//
//  Created by comv on 16/5/13.
//  Copyright © 2016年 comv. All rights reserved.
//

#import "KLNavigationBarView.h"
#import "NSString+Size.h"

@implementation KLNavItm

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    if (self.imageView.image && self.titleLabel.text.length > 0) {
        
        self.imageView.yCenter = self.height/2;
        self.titleLabel.height = self.imageView.height;
        self.titleLabel.width = [self.titleLabel.text widthWithFont:self.titleLabel.font constrainedToHeight:self.titleLabel.height];
        self.titleLabel.yOrigin = self.imageView.yOrigin;

        if (self.imageLocationType == IMAGELOCATIONTYPELEFT) {
            
            self.imageView.xOrigin = 0;
            self.titleLabel.xOrigin = self.imageView.maxX + margin;
            self.width = self.titleLabel.maxX;
        }else if (self.imageLocationType == IMAGELOCATIONTYPERIGHT) {
        
            self.titleLabel.xOrigin = 0;
            self.imageView.xOrigin = self.titleLabel.maxX + margin;
            self.width = self.imageView.maxX;
        }
        
        
    }else if (self.imageView.image && self.titleLabel.text.length <= 0){
        
//        self.imageView.xOrigin = 0;
        self.width = 50;
    }else if (!self.imageView.image && self.titleLabel.text.length > 0){
        
        self.titleLabel.xOrigin = 0;
        self.width = MAX(45, [self.titleLabel.text widthWithFont:self.titleLabel.font constrainedToHeight:self.titleLabel.height]+appMargin);
    }
}

@end


@interface KLNavigationBarView ()

@property (nonatomic, strong) KLNavItm *leftItm;
@property (nonatomic, strong) KLNavItm *rightItm;

@property (nonatomic, strong) UILabel  *navTitleLabel;

@end

@implementation KLNavigationBarView

- (id)initWithFrame:(CGRect)frame{

    if ([super initWithFrame:frame]) {
       
        [self setup];
    }
    return self;
}

- (void)setup{

    _leftItm = [KLNavItm buttonWithType:UIButtonTypeCustom];
    _leftItm.titleLabel.font = kNSPXFONT(BARFONT);
    [_leftItm addTarget:self action:@selector(nav_leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    _rightItm = [KLNavItm buttonWithType:UIButtonTypeCustom];
    _rightItm.titleLabel.font = kNSPXFONT(BARFONT);
    [_rightItm addTarget:self action:@selector(nav_rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    _rightItm.imageLocationType = IMAGELOCATIONTYPERIGHT;
    
    _navTitleLabel = ({
        
        UILabel *label = [UILabel new];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = 1;
        label.font = kNSPXFONT(BARFONT);
        label;
    });
    
    [self sd_addSubviews:@[_leftItm,_rightItm,_navTitleLabel]];
    
    _leftItm.sd_layout
    .topSpaceToView(self,20)
    .bottomSpaceToView(self,0)
    .leftSpaceToView(self,0)
    .widthIs(45);
    
    _rightItm.sd_layout
    .topSpaceToView(self,20)
    .bottomSpaceToView(self,0)
    .rightSpaceToView(self,0)
    .widthIs(45);
    
    _navTitleLabel.sd_layout
    .topSpaceToView(self,20)
    .bottomSpaceToView(self,0)
    .centerXEqualToView(self)
    .widthIs(0);
}
#pragma mark -event
- (void)nav_leftButtonClick:(id)sender{

    UIButton *btn = sender;
    if (btn.imageView.image || btn.titleLabel.text.length > 0) {
        
        _leftNavBarClickBlock?_leftNavBarClickBlock(sender):nil;
    }
}
- (void)nav_rightButtonClick:(id)sender{
    
    UIButton *btn = sender;
    if (btn.imageView.image || btn.titleLabel.text.length > 0) {
        
        _rightNavBarClickBlock?_rightNavBarClickBlock(sender):nil;
    }
}

#pragma mark - seting
- (void)setLeftImage:(UIImage *)leftImage{
    
    _leftImage = leftImage;
    [self.leftItm setImage:_leftImage forState:UIControlStateNormal];
}
- (void)setLeftTitle:(NSString *)leftTitle{
    
    _leftTitle = leftTitle;
    [self.leftItm setTitle:_leftTitle forState:UIControlStateNormal];
}
- (void)setRightImage:(UIImage *)rightImage{
    
    _rightImage = rightImage;
    [self.rightItm setImage:_rightImage forState:UIControlStateNormal];
}
- (void)setRightTitle:(NSString *)rightTitle{
    
    _rightTitle = rightTitle;
    [self.rightItm setTitle:_rightTitle forState:UIControlStateNormal];
}
- (void)setNavTitle:(NSString *)navTitle{
    
    _navTitle = navTitle;
    self.navTitleLabel.text = _navTitle;
    
    if (self.navTitleLabel.text.length > 0) {
        
        CGFloat width = [self.navTitleLabel.text widthWithFont:self.navTitleLabel.font constrainedToHeight:self.navTitleLabel.height];
        self.navTitleLabel.sd_layout.widthIs(width);
    }
}
- (void)setCustomNavCenterView:(UIView *)customNavCenterView{
    
    _customNavCenterView = customNavCenterView;
    
    self.navTitleLabel.hidden = true;
    [self addSubview:_customNavCenterView];
    _customNavCenterView.sd_layout
    .topSpaceToView(self,20)
    .centerXEqualToView(self)
    .widthIs(_customNavCenterView.width)
    .heightIs(_customNavCenterView.height);
}

@end
