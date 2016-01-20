//
//  LWPatientRelatedView.m
//  BreatheDoctor
//
//  Created by comv on 16/1/13.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWPatientRelatedView.h"
#import "LWPatientRelatedPhotoView.h"
#import "UITextView+placeholder.h"

@interface LWPatientRelatedView ()<UITextViewDelegate,LWPatientRelatedPhotoViewDelegate>

@property (nonatomic, strong) UIImageView *iconImgaeView;
@property (nonatomic, strong) UILabel *relatedTitleLabel;
@property (nonatomic, strong) UIView *relatedcontentView;
@property (nonatomic, strong) LWPatientRelatedPhotoView *patientRelatedPhotoView;
@property (nonatomic, strong) UITextView *contentTextView;

@property (nonatomic, assign) CGFloat contentH;
@end
@implementation LWPatientRelatedView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _contentH = 115;
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectZero];
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectZero];
        line1.backgroundColor = RGBA(0, 0, 0, .3);
        line2.backgroundColor = RGBA(0, 0, 0, .3);
        [self addSubview:line1];
        [self addSubview:line2];
        
        line1.sd_layout.topSpaceToView(self,0).leftSpaceToView(self,0).rightSpaceToView(self,0).heightIs(.5);
        line2.sd_layout.bottomSpaceToView(self,0).leftSpaceToView(self,0).rightSpaceToView(self,0).heightIs(.5);
        
        
        [self addSubview:self.iconImgaeView];
        [self addSubview:self.relatedTitleLabel];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectZero];
        line.backgroundColor = RGBA(0, 0, 0, .3);
        [self addSubview:line];
        [self addSubview:self.relatedcontentView];
        
        
        self.iconImgaeView.sd_layout.topSpaceToView(self,15).leftSpaceToView(self,15).widthIs(18).heightIs(18);
        self.relatedTitleLabel.sd_layout.topSpaceToView(self,15).leftSpaceToView(self.iconImgaeView,15).rightSpaceToView(self,5).heightIs(20);
        line.sd_layout.topSpaceToView(self.iconImgaeView,15).leftSpaceToView(self,15).rightSpaceToView(self,0).heightIs(.5);
        self.relatedcontentView.sd_layout.topSpaceToView(line,10).leftSpaceToView(self,15).rightSpaceToView(self,15).bottomSpaceToView(self,5);
        
        [self.relatedcontentView addSubview:self.patientRelatedPhotoView];
        self.patientRelatedPhotoView.sd_layout.topSpaceToView(self.relatedcontentView,0).leftSpaceToView(self.relatedcontentView,0).rightSpaceToView(self.relatedcontentView,0).bottomSpaceToView(self.relatedcontentView,0);
        
        [self.relatedcontentView addSubview:self.contentTextView];
        self.contentTextView.sd_layout.topSpaceToView(self.relatedcontentView,0).leftSpaceToView(self.relatedcontentView,0).rightSpaceToView(self.relatedcontentView,0).bottomSpaceToView(self.relatedcontentView,0);
    }
    return self;
}

- (LWPatientRelatedPhotoView *)patientRelatedPhotoView
{
    if (!_patientRelatedPhotoView) {
        _patientRelatedPhotoView = [[LWPatientRelatedPhotoView alloc] initWithFrame:CGRectZero];
        _patientRelatedPhotoView.delegate = self;
    }
    return _patientRelatedPhotoView;
}

- (UIView *)relatedcontentView
{
    if (!_relatedcontentView) {
        _relatedcontentView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _relatedcontentView;
}


- (UILabel *)relatedTitleLabel
{
    if (!_relatedTitleLabel) {
        _relatedTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _relatedTitleLabel.font = [UIFont systemFontOfSize:16];
        _relatedTitleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    }
    return _relatedTitleLabel;
}
- (UITextView *)contentTextView
{
    if (!_contentTextView) {
        _contentTextView = [[UITextView alloc] initWithFrame:CGRectZero];
        _contentTextView.font = [UIFont systemFontOfSize:14];
        _contentTextView.delegate = self;
    }
    return _contentTextView;
}
- (UIImageView *)iconImgaeView
{
    if (!_iconImgaeView) {
        _iconImgaeView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _iconImgaeView;
}
- (void)setImages:(NSMutableArray *)array
{
    self.patientRelatedPhotoView.images = array;
}
- (void)setPatientRelatedType:(PatientRelatedType)patientRelatedType
{
    _patientRelatedType = patientRelatedType;
    
    
    self.contentTextView.hidden = NO;
    self.patientRelatedPhotoView.hidden = YES;
    if (_patientRelatedType == PatientRelatedTypephoto)
    {
        self.patientRelatedPhotoView.hidden = NO;
        self.contentTextView.hidden = YES;
        self.relatedTitleLabel.text = @"相关照片";
        self.iconImgaeView.image = kImage(@"zhaopian");
        
    }else if (_patientRelatedType == PatientRelatedTypecondition)
    {
        self.contentTextView.placeholder = @"请描述患者基本病情...";
        self.relatedTitleLabel.text = @"基本病情";
        self.iconImgaeView.image = kImage(@"bingqing");
        
    }else
    {
        self.contentTextView.placeholder = @"请填写诊断结果...";
        self.relatedTitleLabel.text = @"诊断结果";
        self.iconImgaeView.image = kImage(@"jieguo");
        
        
    }
    
}


#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView
{
    NSLog(@"%@",self.contentTextView.text);
    
    CGFloat h = [self.contentTextView.text sizeWithFont:self.contentTextView.font constrainedToWidth:self.contentTextView.width].height+8;
    
    CGFloat ch = 15 + 15 + 20 + h;
    
    if (ch > 115) {
        if (ch > 220) {
            self.sd_layout.heightIs(220);
            ch = 220;
        }else{
            self.sd_layout.heightIs(ch);
        }
        _mScrollView.contentHeight =  _mScrollView.contentHeight + (ch-_contentH);
    }else
    {
        self.sd_layout.heightIs(115);
        ch = 115;
        _mScrollView.contentHeight =  _mScrollView.contentHeight + (ch-_contentH);
    }
    _contentH = ch;
}

#pragma mark -LWPatientRelatedPhotoViewDelegate
- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegate && [_delegate respondsToSelector:@selector(selectItemAtIndexPath:)]) {
        [_delegate selectItemAtIndexPath:indexPath];
    }
}
- (void)deleteimage:(UIImage *)image withCollectionView:(UICollectionView *)collectionView;
{
    if (_delegate && [_delegate respondsToSelector:@selector(deleteItemWithImage:withCollectionView:)]) {
        [_delegate deleteItemWithImage:image withCollectionView:collectionView];
    }
}


@end
