//
//  CheckBox.m
//  ComveeDoctor
//
//  Created by JYL on 14-8-1.
//  Copyright (c) 2014年 zhengjw. All rights reserved.
//

#import "CDCheckBox.h"
#import "CDMacro.h"
#import "CDCommontConvenient.h"

@implementation CDCheckBox
@synthesize describeLable;
@synthesize checkBoxImage;
@synthesize selectImgName;
@synthesize unSelectImgName;
@synthesize flag;
@synthesize ifSelect;

- (void)dealloc
{
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        checkBoxImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,self.frame.size.height, self.frame.size.height)];
        
        [self addSubview:checkBoxImage];

        describeLable = [CommentConvenient creatLable:CGRectMake(checkBoxImage.frame.size.width+5, 0,
                                                          self.frame.size.width-checkBoxImage.frame.size.width, self.frame.size.height) text:nil Color:[UIColor blackColor] Font:[UIFont systemFontOfSize:20] textAliment:0 Sv:self];
        describeLable.numberOfLines = 0;
        describeLable.lineBreakMode = NSLineBreakByTruncatingTail;
        
        
      
    }
    return self;
}

- (void)copyValueImageName:(NSString*)imgName describeLableText:(NSString*)text ifSelect:(BOOL)select intFlag:(int)flags Delegate:(id<CDCheckBoxDelegate>)delegate
{
    describeLable.text = text;
    checkBoxImage.image = [UIImage imageNamed:imgName];
    ifSelect = select;
    flag = flags;
    self.delegate = delegate;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
        if (ifSelect == NO)
        {
            checkBoxImage.image = [UIImage imageNamed:selectImgName];
            ifSelect = YES;
        }
        else
        {
            checkBoxImage.image = [UIImage imageNamed:unSelectImgName];
            ifSelect = NO;
        }
        
       [self.delegate selectCheckBox:self CheckBoxFlag:flag];
   
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
