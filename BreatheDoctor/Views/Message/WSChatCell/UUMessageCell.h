//
//  UUMessageCell.h
//  UUChatDemoForTextVoicePicture
//
//  Created by shake on 14-8-27.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UUMessageContentButton.h"
#import "UIResponder+Router.h"

@class UUMessageFrame;
@class UUMessageCell;
@class LWCardView;
@class LWChatLoadingView;

@protocol UUMessageCellDelegate <NSObject>
@optional
- (void)headImageDidClick:(UUMessageCell *)cell userId:(NSString *)userId;

@end


@interface UUMessageCell : UITableViewCell

@property (nonatomic, retain)UILabel *labelTime;
//@property (nonatomic, retain)UILabel *labelNum;
@property (nonatomic, retain)UIButton *btnHeadImage;

@property (nonatomic, strong)UIView  *agreedView;

//@property (nonatomic, strong) LWChatLoadingView *chatLoadingView;

@property (nonatomic, retain)UUMessageContentButton *btnContent;

@property (nonatomic, retain)UUMessageFrame *messageFrame;

@property (nonatomic, assign)id<UUMessageCellDelegate>delegate;

@property (nonatomic, strong)LWCardView *cardView;
@end

