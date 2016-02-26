//
//  UUMessageCell.m
//  UUChatDemoForTextVoicePicture
//
//  Created by shake on 14-8-27.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#import "UUMessageCell.h"
#import "UUMessageFrame.h"
#import "LWCardView.h"
#import "LWChatModel.h"
#import <UIButton+WebCache.h>
#import <UIImageView+WebCache.h>
#import "LWChatLoadingView.h"
#import "LWChatConventionCardView.h"

@interface UUMessageCell ()
{
    UIView *headImageBackView;
    LWChatConventionCardView *chatConventionCardView;
}
@end

@implementation UUMessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 0、创建同意请求类型
        
        self.agreedView = [[UIView alloc] initWithFrame:CGRectZero];
        self.agreedView.backgroundColor = RGBA(0, 0, 0, .2);
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.textColor = [UIColor whiteColor];
        label.text = @"您已通过患者请求，可以开始交流啦";
        label.font = [UIFont systemFontOfSize:13];
        [self.agreedView addSubview:label];
        CGFloat w = [label.text sizeWithFont:[UIFont systemFontOfSize:13] constrainedToHeight:30].width + 20;
        self.agreedView.bounds = CGRectMake(0, 0, w, 30);
        label.frame = CGRectMake(10, 0, w, 30);
        [self.agreedView setCornerRadius:5.0f];
        [self.contentView addSubview:self.agreedView];
        
        // 1、创建时间
        self.labelTime = [[UILabel alloc] init];
        self.labelTime.textAlignment = NSTextAlignmentCenter;
        self.labelTime.textColor = [UIColor grayColor];
        self.labelTime.font = ChatTimeFont;
        [self.contentView addSubview:self.labelTime];
        
        // 2、创建头像
        headImageBackView = [[UIView alloc]init];
        headImageBackView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:headImageBackView];
        self.btnHeadImage = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnHeadImage.layer.cornerRadius = 3.0;
        self.btnHeadImage.layer.masksToBounds = YES;
        [self.btnHeadImage addTarget:self action:@selector(btnHeadImageClick:)  forControlEvents:UIControlEventTouchUpInside];
        [headImageBackView addSubview:self.btnHeadImage];
        
        //        // 3、创建头像下标
        //        self.labelNum = [[UILabel alloc] init];
        //        self.labelNum.textColor = [UIColor grayColor];
        //        self.labelNum.textAlignment = NSTextAlignmentCenter;
        //        self.labelNum.font = ChatTimeFont;
        //        [self.contentView addSubview:self.labelNum];
        
        // 4、创建内容
        self.btnContent = [UUMessageContentButton buttonWithType:UIButtonTypeCustom];
        [self.btnContent setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.btnContent.titleLabel.font = ChatContentFont;
        self.btnContent.titleLabel.numberOfLines = 0;
        [self.btnContent addTarget:self action:@selector(btnContentClick)  forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.btnContent];
        
        _cardView = [[LWCardView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:_cardView];
        
        chatConventionCardView = [[LWChatConventionCardView alloc] initWithFrame:self.bounds];
        [self addSubview:chatConventionCardView];
//        
//        _chatLoadingView = [[LWChatLoadingView alloc] initWithFrame:CGRectZero];
//        [self.contentView addSubview:_chatLoadingView];
        
    }
    return self;
}

//头像点击
- (void)btnHeadImageClick:(UIButton *)button{
    //    if ([self.delegate respondsToSelector:@selector(headImageDidClick:userId:)])  {
    //        [self.delegate headImageDidClick:self userId:self.messageFrame.message.strId];
    //    }
}
- (void)layoutSubviews
{
    self.cardView.frame = self.bounds;
    self.agreedView.xCenter = self.xCenter;
    self.agreedView.yCenter = self.yCenter + 15;
    
    chatConventionCardView.frame = self.bounds;
}
- (void)setMessageFrame:(UUMessageFrame *)messageFrame
{
    _messageFrame = messageFrame;
    
    LWChatModel *model = messageFrame.model;
    
    self.cardView.hidden = YES;
    self.btnContent.hidden = YES;
    self.btnHeadImage.hidden = YES;
    headImageBackView.hidden = YES;
    self.agreedView.hidden = YES;
    chatConventionCardView.hidden = YES;

    // 1、设置时间
    self.labelTime.text = model.insertDt;
    self.labelTime.frame = messageFrame.timeF;
    
    
    // 2、设置头像
    headImageBackView.frame = messageFrame.iconF;
    self.btnHeadImage.frame = CGRectMake(2, 2, ChatIconWH-4, ChatIconWH-4);
    
    [self.btnContent setTitle:@"" forState:UIControlStateNormal];
    self.btnContent.voiceBackView.hidden = YES;
    self.btnContent.backImageView.hidden = YES;
    self.btnContent.frame = messageFrame.contentF;
    
//    self.chatLoadingView.frame = CGRectMake(self.btnContent.xCenter - self.btnContent.width/2 - 25, self.btnContent.yCenter-20, 40, 40);
    
    if (model.ownerType) {
        self.btnContent.isMyMessage = YES;
        [self.btnContent setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.btnContent.contentEdgeInsets = UIEdgeInsetsMake(ChatContentTop, ChatContentRight, ChatContentBottom, ChatContentLeft);
        [self.btnHeadImage sd_setBackgroundImageWithURL:[NSURL URLWithString:model.headImgUrl] forState:UIControlStateNormal placeholderImage:kImage(@"yishengzhushou_35")];

    }else{
        self.btnContent.isMyMessage = NO;
        [self.btnContent setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.btnContent.contentEdgeInsets = UIEdgeInsetsMake(ChatContentTop, ChatContentLeft, ChatContentBottom, ChatContentRight);
        [self.btnHeadImage sd_setBackgroundImageWithURL:[NSURL URLWithString:model.headImgUrl] forState:UIControlStateNormal placeholderImage:kImage(@"yishengzhushousy_03")];

    }
    
    //背景气泡图
    UIImage *normal;//jiankangzixun_57@2x
    if (model.ownerType) {
        normal = [UIImage imageNamed:@"jiankangzixun_57"];
        normal = [normal resizableImageWithCapInsets:UIEdgeInsetsMake(18, 13, 16, 20)];
        
        self.btnContent.voice.image = kImage(@"jiankangzixun_62-06.png");
        self.btnContent.voice.animationImages = [NSMutableArray arrayWithObjects:
                                                 [UIImage imageNamed:@"jiankangzixun_62-08.png"],
                                                 [UIImage imageNamed:@"jiankangzixun_62-07.png"],
                                                 [UIImage imageNamed:@"jiankangzixun_62-06.png"],
                                                 nil];
    }
    else{//yuyin-2_22@2x
        normal = [UIImage imageNamed:@"yuyin-2_22"];
        normal = [normal resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 16, 13)];
        self.btnContent.voice.image = kImage(@"jiankangzixun_62-05.png");
        self.btnContent.voice.animationImages = [NSMutableArray arrayWithObjects:
                                                 [UIImage imageNamed:@"jiankangzixun_62-09.png"],
                                                 [UIImage imageNamed:@"jiankangzixun_62-10.png"],
                                                 [UIImage imageNamed:@"jiankangzixun_62-11.png"],
                                                 nil];
    }
    [self.btnContent setBackgroundImage:normal forState:UIControlStateNormal];
    [self.btnContent setBackgroundImage:normal forState:UIControlStateHighlighted];
    
    
//    self.chatLoadingView.hidden = NO;
    
    switch (model.chatCellType) {
        case WSChatCellType_Text:
            self.btnContent.hidden = NO;
            self.btnHeadImage.hidden = NO;
            headImageBackView.hidden = NO;
            [self.btnContent setTitle:model.content forState:UIControlStateNormal];
            break;
        case WSChatCellType_Image:
        {
            self.btnContent.hidden = NO;
            self.btnHeadImage.hidden = NO;
            headImageBackView.hidden = NO;
            self.btnContent.backImageView.hidden = NO;
            [self.btnContent.backImageView  sd_setImageWithURL:kNSURL(model.content) placeholderImage:kImage(@"defaultIconImage")];
            self.btnContent.backImageView.frame = CGRectMake(0, 0, self.btnContent.frame.size.width, self.btnContent.frame.size.height);
            [self makeMaskView:self.btnContent.backImageView withImage:normal];
        }
            break;
        case WSChatCellType_Audio:
        {
            self.btnContent.hidden = NO;
            self.btnHeadImage.hidden = NO;
            headImageBackView.hidden = NO;
            self.btnContent.voiceBackView.hidden = NO;
            self.btnContent.second.text = [NSString stringWithFormat:@"%@'s",kNSNumDouble(model.voiceMin)];
            if (_messageFrame.model.voiceIsPlay) {
                [self.btnContent didLoadVoice];
            }else
            {
                [self.btnContent stopPlay];
            }
        }
            break;
        case WSChatCellType_Card:
        {
//            self.chatLoadingView.hidden = YES;
            if (_messageFrame.model.chatMessageType == WSChatMessageType_conventionDan) {
                chatConventionCardView.hidden = NO;
                self.cardView.hidden = YES;
                [chatConventionCardView setModel:_messageFrame.model.content];

            }else
            {
                chatConventionCardView.hidden = YES;
                self.cardView.hidden = NO;
                self.cardView.modelFram = _messageFrame;
            }
            self.btnContent.hidden = YES;
            self.btnHeadImage.hidden = YES;
            headImageBackView.hidden = YES;
        }
            break;
        case WSChatCellType_Agreed:
        {
//            self.chatLoadingView.hidden = YES;
            self.btnContent.hidden = YES;
            self.cardView.hidden = YES;
            self.btnHeadImage.hidden = YES;
            headImageBackView.hidden = YES;
            self.agreedView.hidden = NO;
            
        }
            break;
        default:
            break;
    }
}

- (void)makeMaskView:(UIView *)view withImage:(UIImage *)image
{
    UIImageView *imageViewMask = [[UIImageView alloc] initWithImage:image];
    imageViewMask.frame = CGRectInset(view.frame, 0.0f, 0.0f);
    view.layer.mask = imageViewMask.layer;
}
- (void)btnContentClick{
    
    //play audio
    if (self.messageFrame.model.chatCellType == WSChatCellType_Audio) {
        [self routerEventWithType:EventChatCellTypeVoicePlayEvent userInfo:@{kModelKey:self.messageFrame.model,@"self":self}];
    }
    //show the picture
    else if (self.messageFrame.model.chatCellType == WSChatCellType_Image)
    {
        [self routerEventWithType:EventChatCellImageTapedEvent userInfo:@{kModelKey:self.messageFrame.model,@"self":self}];
    }
    // show text and gonna copy that
    else if (self.messageFrame.model.chatCellType == WSChatCellType_Text)
    {
        [self.btnContent becomeFirstResponder];
        UIMenuController *menu = [UIMenuController sharedMenuController];
        [menu setTargetRect:self.btnContent.frame inView:self.btnContent.superview];
        [menu setMenuVisible:YES animated:YES];
    }
}

@end



