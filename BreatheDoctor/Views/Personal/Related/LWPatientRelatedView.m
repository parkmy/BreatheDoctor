//
//  LWPatientRelatedView.m
//  BreatheDoctor
//
//  Created by comv on 16/1/13.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWPatientRelatedView.h"
#import "LWPatientRelatedPhotoView.h"

@interface LWPatientRelatedView ()<UITextViewDelegate,LWPatientRelatedPhotoViewDelegate>
{
    CGFloat photoContentHeight;
    CGFloat textContentH;
}
@property (nonatomic, strong) UIImageView *iconImgaeView;
@property (nonatomic, strong) UILabel *relatedTitleLabel;
@property (nonatomic, strong) UIView *relatedcontentView;
@property (nonatomic, strong) LWPatientRelatedPhotoView *patientRelatedPhotoView;

@end
@implementation LWPatientRelatedView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectZero];
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectZero];
        line1.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
        line2.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
        [self addSubview:line1];
        [self addSubview:line2];
        
        line1.sd_layout.topSpaceToView(self,0).leftSpaceToView(self,0).rightSpaceToView(self,0).heightIs(.5);
        line2.sd_layout.bottomSpaceToView(self,0).leftSpaceToView(self,0).rightSpaceToView(self,0).heightIs(.5);
        
        
        [self addSubview:self.iconImgaeView];
        [self addSubview:self.relatedTitleLabel];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectZero];
        line.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
        [self addSubview:line];
        [self addSubview:self.relatedcontentView];
        
        UIImage *image = kImage(@"zhaopian");
        
        textContentH = iconImgaeViewtop*2 + image.size.height;

        self.iconImgaeView.sd_layout.topSpaceToView(self,iconImgaeViewtop).leftSpaceToView(self,margin).widthIs(image.size.width).heightIs(image.size.height);
        self.relatedTitleLabel.sd_layout.topSpaceToView(self,iconImgaeViewtop).leftSpaceToView(self.iconImgaeView,margin).rightSpaceToView(self,5).heightIs(image.size.height);
        line.sd_layout.topSpaceToView(self.iconImgaeView,iconImgaeViewtop).leftSpaceToView(self,margin).rightSpaceToView(self,0).heightIs(.5);
        self.relatedcontentView.sd_layout.topSpaceToView(line,0).leftSpaceToView(self,margin).rightSpaceToView(self,margin).bottomSpaceToView(self,.5);
        
        [self.relatedcontentView addSubview:self.patientRelatedPhotoView];
        self.patientRelatedPhotoView.sd_layout.topSpaceToView(self.relatedcontentView,0).leftSpaceToView(self.relatedcontentView,-10).rightSpaceToView(self.relatedcontentView,0).bottomSpaceToView(self.relatedcontentView,0);
        
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
        _relatedTitleLabel.font = [UIFont systemFontOfSize:kNSPXFONTFLOAT(32)];
        _relatedTitleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    }
    return _relatedTitleLabel;
}
- (UITextView *)contentTextView
{
    if (!_contentTextView) {
        _contentTextView = [[UITextView alloc] initWithFrame:CGRectZero];
        _contentTextView.font = [UIFont systemFontOfSize:kNSPXFONTFLOAT(30)];
        _contentTextView.textColor = [UIColor colorWithHexString:@"#999999"];
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
//    [self imagesChangeHeight:array];
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
        CGFloat ih = patientRelatedView3Height;
        if (screenHeight > 570) {
            ih = _mScrollView.height-margin*3-RelatedViewHeight*2-saveViewHeight;
        }
        photoContentHeight = ih;
    }else if (_patientRelatedType == PatientRelatedTypecondition)
    {
        self.relatedTitleLabel.text = @"基本病情";
        self.iconImgaeView.image = kImage(@"bingqing");
        
    }else
    {
        self.relatedTitleLabel.text = @"诊断结果";
        self.iconImgaeView.image = kImage(@"jieguo");        
    }
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView
{
    NSLog(@"%@",self.contentTextView.text);
    
    CGFloat h = [self.contentTextView.text sizeWithFont:self.contentTextView.font constrainedToWidth:self.contentTextView.width].height+30;
    
    UIImage *image = kImage(@"zhaopian");
    CGFloat ch = iconImgaeViewtop*2 + image.size.height + h + 1;
    
    if (ch > RelatedViewHeight) {
        if (ch > RelatedViewMAXHeight) {
            self.sd_layout.heightIs(RelatedViewMAXHeight);
            ch = RelatedViewMAXHeight;
        }else{
            self.sd_layout.heightIs(ch);
        }
        _mScrollView.contentHeight =  _mScrollView.contentHeight + (ch-textContentH);
    }else
    {
        self.sd_layout.heightIs(RelatedViewHeight);
        ch = RelatedViewHeight;
        _mScrollView.contentHeight =  _mScrollView.contentHeight + (ch-textContentH);
    }
    textContentH = ch;
}
- (void)setContentTextViewText:(NSString *)text
{
    self.contentTextView.text = text;
    [self textViewDidChange:self.contentTextView];
}

#pragma mark -LWPatientRelatedPhotoViewDelegate
- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegate && [_delegate respondsToSelector:@selector(selectItemAtIndexPath:)]) {
        [_delegate selectItemAtIndexPath:indexPath];
    }
}
- (void)deleteimage:(id )object withCollectionView:(UICollectionView *)collectionView
{
    if (_delegate && [_delegate respondsToSelector:@selector(deleteItemWithImage:withCollectionView:)]) {
        [_delegate deleteItemWithImage:object withCollectionView:collectionView];
    }
}
- (void)imagesChangeHeight:(NSMutableArray *)images
{
    CGFloat wh = (Screen_SIZE.width - 30)/3 - 10;
//    layout.sectionInset = UIEdgeInsetsMake(15, 5,4, 5);
    
    int count = images.count/3 + 1;

    UIImage *image = kImage(@"zhaopian");
    CGFloat ch =  iconImgaeViewtop*2 + image.size.height + count*(wh + 15 + 5);
    
    CGFloat ih = patientRelatedView3Height;
    if (screenHeight > 570) {
        ih = _mScrollView.height-margin*3-RelatedViewHeight*2-saveViewHeight;
    }
    if (ch > ih) {
        self.sd_layout.heightIs(ch);
        _mScrollView.contentHeight =  _mScrollView.contentHeight + (ch-photoContentHeight);
    }else
    {
        self.sd_layout.heightIs(ih);
        ch = ih;
        _mScrollView.contentHeight =  _mScrollView.contentHeight + (ch-photoContentHeight);
    }
    photoContentHeight = ch;
    
}

@end
