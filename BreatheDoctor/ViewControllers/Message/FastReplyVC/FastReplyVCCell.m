//
//  FastReplyVCCell.m
//  ComveeDoctor
//
//  Created by JYL on 14-10-11.
//  Copyright (c) 2014年 zhengjw. All rights reserved.
//

#import "FastReplyVCCell.h"
#import "CDMacro.h"
#import "CDCommontConvenient.h"

@implementation FastReplyVCCell
@synthesize line;
@synthesize detailLable;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
      self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, screenWidth, 60);
        if (systemVersion<7)
        {
            UIView *  backgroundView =[[UIView alloc]initWithFrame:self.bounds];
            backgroundView.backgroundColor = [UIColor whiteColor];
            self.backgroundView =backgroundView;
        }

        line = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1)];
        line.backgroundColor = LineColor;
        [self.contentView addSubview:line];
        detailLable = [CommentConvenient
 creatLable:CGRectMake(15, 0, self.frame.size.width-30, self.frame.size.height) text:nil Color:[UIColor blackColor] Font:[UIFont systemFontOfSize:16] textAliment:0 Sv:self.contentView];
         detailLable.numberOfLines = 2;
         detailLable.lineBreakMode = NSLineBreakByTruncatingTail;
     
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDetailTetil:(NSString*)title
{
    detailLable.text = title;
    CGFloat height = [FastReplyVCCell calculateMethodWith:title withFont:15];
   
    if (height>60)
    {
     // detailLable.frame = CGRectMake(15,0, self.frame.size.width-30,height);
      //line.frame = CGRectMake(0, height+2, self.frame.size.width, 1);
    }

}

+ (CGFloat)calculateMethodWith:(NSString*)string withFont:(int)fonts
{    
    CGSize size= [string sizeWithFont:[UIFont systemFontOfSize:fonts] constrainedToWidth:285];
    return size.height;
}


@end
