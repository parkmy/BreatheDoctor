//
//  LWBasePatientRelatedCell.m
//  BreatheDoctor
//
//  Created by comv on 16/3/23.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWBasePatientRelatedCell.h"
#define headerHeight 50
#define MAXCELLHEIGHT 150
#define CELLHEIGHT (120*MULTIPLEVIEW)

@interface LWBasePatientRelatedCell ()<UITextViewDelegate>


@end

@implementation LWBasePatientRelatedCell

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
    }
    return _iconImageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = kNSPXFONT(32);
        _titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    }
    return _titleLabel;
}
- (UIView *)mContentView
{
    if (!_mContentView) {
        _mContentView = [UIView new];
    }
    return _mContentView;
}
- (UITextView *)mContentTextView
{
    if (!_mContentTextView) {
        _mContentTextView = [UITextView new];
        _mContentTextView.font = [UIFont systemFontOfSize:kNSPXFONTFLOAT(30)];
        _mContentTextView.textColor = [UIColor colorWithHexString:@"#999999"];
        _mContentTextView.delegate = self;
    }
    return _mContentTextView;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = 0;
        
        UIView *headerView = ({
            UIView *view = [UIView new];
            [self addSubview:view];
            view;
        });
        UIView *line = [UIView allocAppLineView];

        [headerView addSubview:self.iconImageView];
        [headerView addSubview:self.titleLabel];
        [headerView addSubview:line];
        
        
        [self addSubview:self.mContentView];
        [self.mContentView addSubview:self.mContentTextView];
        
        headerView.sd_layout.leftSpaceToView(self,0).topSpaceToView(self,0).rightSpaceToView(self,0).heightIs(headerHeight);
        UIImage *image = kImage(@"zhaopian");
        self.iconImageView.sd_layout.widthIs(image.size.width).heightIs(image.size.height).centerYEqualToView(headerView).leftSpaceToView(headerView,10);
        line.sd_layout.leftSpaceToView(headerView,10).bottomSpaceToView(headerView,0).rightSpaceToView(headerView,0).heightIs(1);
        self.titleLabel.sd_layout.leftSpaceToView(self.iconImageView,10).rightSpaceToView(headerView,0).bottomSpaceToView(headerView,1).topSpaceToView(headerView,0);
        
        self.mContentView.sd_layout.topSpaceToView(headerView,0).leftSpaceToView(self,0).rightSpaceToView(self,0).bottomSpaceToView(self,0);
        self.mContentTextView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 10, 0, 5));
        
    }
    return self;
}

- (void)setContentTextViewText:(NSString *)text
{
    self.mContentTextView.text = text;
    [self textViewDidChange:self.mContentTextView];
}


- (void)textViewDidChange:(UITextView *)textView
{
//    CGFloat h = [self.mContentTextView.text sizeWithFont:self.mContentTextView.font constrainedToWidth:self.mContentTextView.width].height;
//
//    if (CELLHEIGHT > (h+headerHeight))
//    {
//        if (MAXCELLHEIGHT > (h+headerHeight)) {
//            self.model.cellRowHeight = MAXCELLHEIGHT;
//        }else
//        {
//            self.model.cellRowHeight = (h+headerHeight);
//        }
//    }else
//    {
//        self.model.cellRowHeight = CELLHEIGHT;
//    }
//    _changeContentBlock?_changeContentBlock():nil;
    if (![self.mContentTextView.text isEqualToString:self.model.contentString]) {
        self.model.isChange = YES;
    }
    self.model.contentString = self.mContentTextView.text;
}

@end
