//
//  LWPatientRelatedView.h
//  BreatheDoctor
//
//  Created by comv on 16/1/13.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, PatientRelatedType) {
    PatientRelatedTypediagnosis = 0, //诊断结果
    PatientRelatedTypecondition ,//基本病情
    PatientRelatedTypephoto ,//相关照片
};


@protocol LWPatientRelatedViewDelegate <NSObject>

@optional
- (void)selectItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)deleteItemWithImage:(id )objc withCollectionView:(UICollectionView *)collectionView;;

@end

@interface LWPatientRelatedView : UIView
@property (nonatomic, strong) UITextView *contentTextView;
@property (nonatomic, assign) PatientRelatedType patientRelatedType;
@property (nonatomic, strong) UIScrollView *mScrollView;
@property (nonatomic, weak) id<LWPatientRelatedViewDelegate>delegate;

- (void)setImages:(NSMutableArray *)array;
- (void)setContentTextViewText:(NSString *)text;

@end
