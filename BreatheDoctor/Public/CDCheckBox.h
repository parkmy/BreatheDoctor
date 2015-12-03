//
//  CheckBox.h
//  ComveeDoctor
//
//  Created by JYL on 14-8-1.
//  Copyright (c) 2014年 zhengjw. All rights reserved.
//复选框

#import <UIKit/UIKit.h>

@class CDCheckBox;

@protocol CDCheckBoxDelegate <NSObject>

@optional

- (void)selectCheckBox:(CDCheckBox*)checkBox CheckBoxFlag:(int)flag;

@end

@interface CDCheckBox : UIView<CDCheckBoxDelegate>

//复选框(默认未选中)
@property (nonatomic, strong)UIImageView * checkBoxImage;
//描述文字显示
@property (nonatomic, strong) UILabel * describeLable;
//复选框选中时的图片名
@property (nonatomic, strong) NSString * selectImgName;
//复选框未选中时的图片名
@property (nonatomic, strong) NSString * unSelectImgName;
//标识
@property (nonatomic, assign) int flag;
//标识是否未选中
@property (nonatomic, assign) BOOL ifSelect;
//代理
@property (nonatomic, assign) id<CDCheckBoxDelegate>delegate;

- (void)copyValueImageName:(NSString*)imgName describeLableText:(NSString*)text ifSelect:(BOOL)select intFlag:(int)flags Delegate:(id<CDCheckBoxDelegate>)delegate;

@end
