//
//  KLChatMessageInputBar.m
//  BreatheDoctor
//
//  Created by comv on 16/4/26.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLChatMessageInputBar.h"
#import "D3RecordButton.h"
#import "KLChatMessageMoreView.h"

#define kMinHeightTextView          (35*MULTIPLE)
//输入框最大高度
#define kMaxHeightTextView   (60*MULTIPLE)

@interface KLChatMessageInputBar ()<D3RecordDelegate,UITextViewDelegate>

/**
 *  @brief  输入TextView
 */
@property (nonatomic,strong)    UITextView *mInputTextView;

/**
 *  @brief  录制语音按钮
 */
@property (nonatomic,strong)    UIButton   *mVoiceBtn;

/**
 *  @brief  更多按钮
 */
@property (nonatomic,strong)    UIButton   *mMoreBtn;
/**
 *  @brief  按住说话
 */
@property (nonatomic, strong)   D3RecordButton *longButtonVoice;


@end

@implementation KLChatMessageInputBar
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (id)initWithFrame:(CGRect)frame{
    
    if ([super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *line = [UIView allocAppLineView];
        
        [self sd_addSubviews:@[self.mVoiceBtn,self.mInputTextView,self.longButtonVoice,self.mVoiceBtn,self.mMoreBtn,line,self.mMoreView]];
        
        self.mVoiceBtn.sd_layout
        .leftSpaceToView(self,10)
        .topSpaceToView(self,11)
        .widthIs(self.mVoiceBtn.imageView.image.size.width)
        .heightIs(self.mVoiceBtn.imageView.image.size.height);
        
        self.mMoreBtn.sd_layout
        .rightSpaceToView(self,10)
        .topSpaceToView(self,11)
        .widthIs(self.mMoreBtn.imageView.image.size.width)
        .heightIs(self.mMoreBtn.imageView.image.size.height);
        
        self.longButtonVoice.sd_layout
        .leftSpaceToView(self.mVoiceBtn,7)
        .rightSpaceToView(self.mMoreBtn,7)
        .topSpaceToView(self,7)
        .heightIs(kMinHeightTextView);
        
        self.mInputTextView.sd_layout
        .leftSpaceToView(self.mVoiceBtn,7)
        .rightSpaceToView(self.mMoreBtn,7)
        .topSpaceToView(self,7)
        .heightIs(kMinHeightTextView);

        
        self.mMoreView.sd_layout
        .leftSpaceToView(self,0)
        .rightSpaceToView(self,0)
        .bottomSpaceToView(self,0)
        .heightIs(0);
        
        line.sd_layout
        .leftSpaceToView(self,0)
        .rightSpaceToView(self,0)
        .topSpaceToView(self.mInputTextView,7)
        .heightIs(.5);
        
        
//        [self setupAutoWidthWithRightView:line rightMargin:5];
        
        
        /**
         *  @brief  监听键盘显示、隐藏变化，让自己伴随键盘移动
         */
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}
#pragma mark - 伴随键盘移动

-(void)keyboardChange:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardEndFrame;
    
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    
    if (notification.name == UIKeyboardWillShowNotification)
    {
        self.sd_layout.heightIs((keyboardEndFrame.size.height)+defHeight+(self.mInputTextView.height-kMinHeightTextView));
        _mMoreBtn.selected = NO;
    }else
    {
        [self removeFromMoreView];
        if (!self.mMoreBtn.selected){
            self.sd_layout.heightIs(defHeight+(self.mInputTextView.height-kMinHeightTextView));
        }
    }
    [UIView commitAnimations];
}

-(UIButton *)mMoreBtn
{
    if (_mMoreBtn) {
        return _mMoreBtn;
    }
    
    _mMoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_mMoreBtn addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _mMoreBtn.backgroundColor = [UIColor clearColor];
    
    [_mMoreBtn setImage:[UIImage imageNamed:@"doctor_qunfa_fenlei.png"] forState:UIControlStateNormal];
    [_mMoreBtn  setImage:[UIImage imageNamed:@"doctor_qunfa_fenlei.png"] forState:UIControlStateSelected];
    return _mMoreBtn;
}

- (D3RecordButton *)longButtonVoice
{
    if (!_longButtonVoice) {
        _longButtonVoice = [D3RecordButton buttonWithType:UIButtonTypeCustom];
        _longButtonVoice.backgroundColor = [UIColor whiteColor];
        _longButtonVoice.titleLabel.font  = [UIFont systemFontOfSize:14];
        [_longButtonVoice initRecord:self maxtime:10 title:@"上滑取消录音"];
        [_longButtonVoice setTitle:@"按住说话" forState:UIControlStateNormal];
        [_longButtonVoice setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        [_longButtonVoice setCornerRadius:5.0f];
        _longButtonVoice.layer.borderColor = [UIColor colorWithHexString:@"#c1c1c1"].CGColor;
        _longButtonVoice.layer.borderWidth = .5f;
        _longButtonVoice.userInteractionEnabled = YES;
        
        _longButtonVoice.hidden = YES;
    }
    return _longButtonVoice;
}
- (KLChatMessageMoreView *)mMoreView{
    
    if (!_mMoreView) {
        _mMoreView = [KLChatMessageMoreView new];
    }
    return _mMoreView;
}

-(UIButton *)mVoiceBtn
{
    if (_mVoiceBtn) {
        return _mVoiceBtn;
    }
    
    _mVoiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_mVoiceBtn addTarget:self action:@selector(voiceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _mVoiceBtn.backgroundColor = [UIColor clearColor];
    [_mVoiceBtn setImage:[UIImage imageNamed:@"doctor_qunfa_yuyin.png"] forState:UIControlStateNormal];
    [_mVoiceBtn  setImage:[UIImage imageNamed:@"keyBoard"] forState:UIControlStateSelected];
    
    return _mVoiceBtn;
}
-(UITextView *)mInputTextView
{
    if (_mInputTextView) {
        return _mInputTextView;
    }
    
    _mInputTextView = [UITextView new];
    
    _mInputTextView.delegate = self;
    _mInputTextView.layer.borderColor = [[[UIColor lightGrayColor] colorWithAlphaComponent:0.4] CGColor];
    _mInputTextView.scrollIndicatorInsets = UIEdgeInsetsMake(10.0f, 0.0f, 10.0f, 4.0f);
    _mInputTextView.contentInset = UIEdgeInsetsZero;
    _mInputTextView.scrollEnabled = NO;
    _mInputTextView.scrollsToTop = NO;
    _mInputTextView.userInteractionEnabled = YES;
    _mInputTextView.font = kNSPXFONT(30);
    _mInputTextView.textColor = [UIColor colorWithHexString:@"#333333"];
    _mInputTextView.backgroundColor = [UIColor whiteColor];
    _mInputTextView.keyboardAppearance = UIKeyboardAppearanceDefault;
    _mInputTextView.keyboardType = UIKeyboardTypeDefault;
    _mInputTextView.returnKeyType = UIReturnKeySend;
    _mInputTextView.textAlignment = NSTextAlignmentLeft;
    [_mInputTextView setCornerRadius:5.0f];
    _mInputTextView.layer.borderColor = [UIColor colorWithHexString:@"#c1c1c1"].CGColor;
    _mInputTextView.layer.borderWidth = .5f;
    return _mInputTextView;
}
#pragma mark - 点击事件处理

-(void)voiceBtnClick:(UIButton*)sender
{
    self.mMoreBtn.selected = NO;
    [self removeFromMoreView];

    if (sender.selected)
    {
        [self.mInputTextView becomeFirstResponder];
        self.longButtonVoice.hidden = YES;
        self.mInputTextView.hidden = NO;
        
    }else
    {
        [self.mInputTextView resignFirstResponder];
        self.longButtonVoice.hidden = NO;
        self.mInputTextView.hidden = YES;
        self.sd_layout.heightIs(defHeight);
    }
    sender.selected = !sender.selected;
    
    
}

- (void)removeFromMoreView
{
    if (!_mMoreBtn.selected) {
        _mMoreView.sd_layout.heightIs(0);
        _mMoreBtn.selected = NO;
        self.sd_layout.heightIs(defHeight + (self.mInputTextView.height-kMinHeightTextView));
    }
}
- (void)kl_fastReplyContent:(NSString *)content
{
    _mInputTextView.text = content;
    [self textViewDidChange:_mInputTextView];
    [_mInputTextView becomeFirstResponder];
    
}
#define MoreViewHeight 115

-(void)moreBtnClick:(UIButton*)sender
{
    
    [MobClick event:@"moreBtnClick" label:@"对话更多按钮的点击量"];
    
    sender.selected = !sender.selected;

    if (!sender.selected)
    {//隐藏更多界面，显示键盘输入
        
        _mMoreView.sd_layout.heightIs(0);
        self.sd_layout.heightIs(defHeight+(self.mInputTextView.height-kMinHeightTextView));
    }else
    {
        
        _mMoreView.sd_layout.heightIs(MoreViewHeight);
        self.sd_layout.heightIs(defHeight + MoreViewHeight + (self.mInputTextView.height-kMinHeightTextView));

        //隐藏键盘，显示更多界面
        [self.mInputTextView resignFirstResponder];
        self.mInputTextView.hidden = NO;
        self.mVoiceBtn.selected = NO;
    }
    
}
//判断用户是否点击了键盘发送按钮
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {//点击了发送按钮
        
        if (![textView.text isEqualToString:@""])
        {//输入框当前有数据才需要发送
            
            [self kl_textSenderWithText:textView.text];
            textView.text = @"";//清空输入框
            [self textViewDidChange:textView];
        }
        return NO;
    }
    
    return YES;
}

//根据输入文字多少，自动调整输入框的高度
-(void)textViewDidChange:(UITextView *)textView
{
    //计算输入框最小高度
    CGSize size =  [textView sizeThatFits:CGSizeMake(textView.contentSize.width, 0)];
    
    CGFloat contentHeight;
    
    //输入框的高度不能超过最大高度
    if (size.height > kMinHeightTextView)
    {
        if (size.height > kMaxHeightTextView) {
            contentHeight = kMaxHeightTextView;
        }else
        {
            contentHeight = size.height;
        }
        textView.scrollEnabled = YES;
    }else
    {
        contentHeight = kMinHeightTextView;
        textView.scrollEnabled = NO;
    }
    if (self.mInputTextView.height != contentHeight)
    {//如果当前高度需要调整，就调整，避免多做无用功
        self.mInputTextView.height = contentHeight;//重新设置自己的高度
        self.height = ((self.height+(contentHeight-kMinHeightTextView)));
//        self.sd_layout.heightIs((self.height+(contentHeight-kMinHeightTextView)));
    }
}
#pragma mark - delegate

- (void)recording:(float) recordTime
{
    
}
- (void)starRecord{};
- (void)endRecord{};
- (void)endRecord:(NSData *)voiceData timeCount:(NSInteger)count
{
    [_longButtonVoice setTitle:@"按住说话" forState:UIControlStateNormal];

    [self kl_voiceSenderWithVoiceData:voiceData theVoiceCount:count];
}

-(void)dragEnter{
    [_longButtonVoice setTitle:@"松开发送" forState:UIControlStateNormal];
}

#pragma mark -senderEvent
- (void)kl_voiceSenderWithVoiceData:(NSData *)data theVoiceCount:(NSInteger)count{

}
- (void)kl_textSenderWithText:(NSString *)text{

}
@end
