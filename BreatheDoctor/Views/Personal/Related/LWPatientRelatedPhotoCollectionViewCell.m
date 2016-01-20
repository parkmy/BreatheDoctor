//
//  LWPatientRelatedPhotoCollectionViewCell.m
//  BreatheDoctor
//
//  Created by comv on 16/1/12.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWPatientRelatedPhotoCollectionViewCell.h"
@interface LWPatientRelatedPhotoCollectionViewCell ()
@property (nonatomic, strong) UIImageView *mImageView;
@end
@implementation LWPatientRelatedPhotoCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {

        self.contentView.backgroundColor = [UIColor whiteColor];
        
        self.mImageView.image = kImage(@"tianjia");
        [self addSubview:self.mImageView];
        
        self.mImageView.sd_layout.topSpaceToView(self,5).bottomSpaceToView(self,5).leftSpaceToView(self,5).rightSpaceToView(self,5);
        
        
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setImage:kImage(@"shanchu") forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cnacelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cancelButton];
        
        _cancelButton.sd_layout.topSpaceToView(self,-10).rightSpaceToView(self,-10).widthIs(35).heightIs(35);
        
    }
    return self;
}
- (void)setContentImage:(UIImage *)contentImage
{
    _contentImage = contentImage;
    self.mImageView.image = _contentImage;
}
- (void)cnacelButtonClick:(id)sender
{
    _deleButtonTapBlock?_deleButtonTapBlock(self.contentImage):nil;
}

- (UIImageView *)mImageView
{
    if (!_mImageView) {
        _mImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _mImageView;
}

@end
