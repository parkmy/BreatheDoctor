//
//  KLPatientLisetCell.m
//  BreatheDoctor
//
//  Created by comv on 16/4/22.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLPatientLisetCell.h"
#import "KLPatientListModel.h"
#import "LWTool.h"
#import <UIImageView+WebCache.h>

@interface KLPatientLisetCell ()

@property (nonatomic, strong) UIButton *editorIcon;
@property (nonatomic, strong) UIImageView *userIcon;
@property (nonatomic, strong) UILabel     *userNameLabel;
@property (nonatomic, strong) UILabel     *groupingLabel;

@end

@implementation KLPatientLisetCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
//        self.selectionStyle = 0;
        
        //修改背景颜色
        UIView *backgroundViews = [[UIView alloc]initWithFrame:self.contentView.frame];
        backgroundViews.backgroundColor = [[UIColor colorWithHexString:@"#d4d4d4"] colorWithAlphaComponent:.7];
        self.selectedBackgroundView = backgroundViews;
        
        _editorIcon = [UIButton buttonWithType:UIButtonTypeCustom];
        _editorIcon.userInteractionEnabled = false;
        [_editorIcon setImage:kImage(@"patienList_editor_nor.png") forState:UIControlStateNormal];
        [_editorIcon setImage:kImage(@"patienList_editor_sele.png") forState:UIControlStateSelected];
        
        _userIcon   = [UIImageView new];
        _userIcon.image = kImage(@"yishengzhushousy_03.png");
        
        _userNameLabel = [UILabel new];
        _groupingLabel.font = [UIFont systemFontOfSize:kNSPXFONTFLOAT(28)];

        _groupingLabel = [UILabel new];
        _groupingLabel.font = [UIFont systemFontOfSize:kNSPXFONTFLOAT(24)];
        _groupingLabel.textColor = [UIColor whiteColor];
        _groupingLabel.textAlignment = 1;
        
        [self sd_addSubviews:@[_editorIcon,_userIcon,_userNameLabel,_groupingLabel]];

        
        _editorIcon.sd_layout
        .leftSpaceToView(self,20)
        .centerYEqualToView(self)
        .widthIs(_editorIcon.imageView.image.size.width)
        .heightIs(_editorIcon.imageView.image.size.height);
        
        _userIcon.sd_layout
        .widthIs(37*MULTIPLEVIEW)
        .heightIs(37*MULTIPLEVIEW)
        .leftSpaceToView(_editorIcon,10)
        .centerYEqualToView(self);
        
        _groupingLabel.sd_layout
        .rightSpaceToView(self,22)
        .heightIs(20*MULTIPLEVIEW)
        .centerYEqualToView(self)
        .widthIs(50);
        
        _userNameLabel.sd_layout
        .leftSpaceToView(_userIcon,7)
        .rightSpaceToView(_groupingLabel,7)
        .heightIs(20*MULTIPLEVIEW)
        .centerYEqualToView(self);
        
    }
    return self;
}
- (void)setType:(LISTTYPE)type{
    _type = type;
    if (_type == LISTTYPEDEFT) {
        _editorIcon.hidden = YES;
        _editorIcon.sd_layout.widthIs(0).leftSpaceToView(self,0);
    }else{
        _editorIcon.hidden = NO;
        _editorIcon.sd_layout.widthIs(_editorIcon.imageView.image.size.width).leftSpaceToView(self,20);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


- (void)setModel:(id)model{

    _model = model;
   
    KLPatientListModel *listModel = _model;
    
    [self.userIcon sd_setImageWithURL:kNSURL(stringJudgeNull(listModel.headImgUrl)) placeholderImage:kImage(@"yishengzhushousy_03.png")];
    
    if ([listModel.remark isEqualToString:@""] || !listModel.remark) {
        self.userNameLabel.text = stringJudgeNull(listModel.patientName);
    }else
    {
        self.userNameLabel.text = [NSString stringWithFormat:@"%@(%@)",stringJudgeNull(listModel.patientName),stringJudgeNull(listModel.remark)];
    }
    
    [LWTool atientControlLevel:listModel.controlLevel withLayoutConstraint:nil withLabel:self.groupingLabel];
    
    if (_type != LISTTYPEDEFT) {
        _editorIcon.selected = listModel.isSele;
    }
}

- (void)seteditorIconSele:(BOOL)isSele{
    
    _editorIcon.selected = isSele;
}



@end
