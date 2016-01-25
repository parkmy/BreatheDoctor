//
//  LWPatientRelatedPhotoCollectionViewCell.m
//  BreatheDoctor
//
//  Created by comv on 16/1/12.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWPatientRelatedPhotoCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@interface LWPatientRelatedPhotoCollectionViewCell ()
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
- (void)setObject:(id)object
{
    _object = object;
    if ([object isKindOfClass:[UIImage class]]) {
        self.mImageView.image = (UIImage *)object;
    }else if ([object isKindOfClass:[NSString class]])
    {
        [self.mImageView sd_setImageWithURL:[NSURL URLWithString:stringJudgeNull((NSString *)object)]placeholderImage:kImage(@"defaultIconImage")];
    }

}
- (void)cnacelButtonClick:(id)sender
{
    _deleButtonimageTapBlock?_deleButtonimageTapBlock(self.object):nil;
}

- (UIImageView *)mImageView
{
    if (!_mImageView) {
        _mImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _mImageView;
}

@end
