//
//  LWPatientRelatedCell.m
//  BreatheDoctor
//
//  Created by comv on 16/1/12.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWPatientRelatedCell.h"
#import "LWPatientRelatedPhotoView.h"
#import "UITextView+placeholder.h"

@interface LWPatientRelatedCell ()<UITextViewDelegate>
{
    CGFloat contentH;
}
@property (nonatomic, strong) UIImageView *iconImgaeView;
@property (nonatomic, strong) UILabel *relatedTitleLabel;
@property (nonatomic, strong) UIView *relatedcontentView;
@property (nonatomic, strong) LWPatientRelatedPhotoView *patientRelatedPhotoView;
@property (nonatomic, strong) UITextView *contentTextView;

@end

@implementation LWPatientRelatedCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = 0;
        
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
        _contentTextView.scrollEnabled = NO;
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
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{

    NSString *string = [NSString stringWithFormat:@"%@%@",self.contentTextView.text,text];

    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    NSLog(@"%@",self.contentTextView.text);

    CGFloat h = [self.contentTextView.text sizeWithFont:self.contentTextView.font constrainedToWidth:self.contentTextView.width].height+8;
    if (h > (115-55)) {
        self.model.rowHight = h + 55;
        if (contentH != self.model.rowHight) {
            [self.mTableView reloadData];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.contentTextView becomeFirstResponder];
            });
        }
    }else
    {
        self.model.rowHight = 115;
    }
    contentH = self.model.rowHight;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
