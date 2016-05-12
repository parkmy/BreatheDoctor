//
//  LWVoiceManager.m
//  BreatheDoctor
//
//  Created by comv on 15/11/16.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWVoiceManager.h"
#import "NSString+Contains.h"
#import "LCDownloadManager.h"
#import "KLGroupSenderChatModel.h"

@interface LWVoiceManager ()<AVAudioPlayerDelegate>
@property (nonatomic, strong) AVAudioPlayer * mm_player;
@property (nonatomic, strong) LWChatModel *chatModel;
@property (nonatomic, strong) UUMessageCell *starCell;

@property (nonatomic, strong) KLVoiceTypeView *voiceView;
@property (nonatomic, strong) KLGroupSenderChatModel *model;
@end

@implementation LWVoiceManager
+ (LWVoiceManager *)shareInstance
{
    static LWVoiceManager *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^ { instance = [[LWVoiceManager alloc] init]; });
    return instance;
}
- (void)stopVoice
{
    if (_mm_player) {
        [_mm_player stop];
        [self.starCell.btnContent stopPlay];
        [self.voiceView stopPlay];
    }
}
- (void)clearChae
{
    [[NSFileManager defaultManager] removeItemAtPath:[self downloadPath] error:nil];
}
- (void)playVoiceWithPlayModel:(KLGroupSenderChatModel *)model withPlayImageView:(KLVoiceTypeView *)voiceView;{
    /**
     *  先判断是否是同个语音 以及在播放状态 如果是停止播放
     */
    if ([self.model.sid isEqualToString:model.sid] && _mm_player.isPlaying) {
        
        model.voiceIsPlay = NO;
        [_mm_player stop];
        [voiceView stopPlay];
        return;
    }
    
    self.model = model;
    /**
     *  如果不是播放或者同个语音 停止当前播放
     */
    if (self.voiceView) {
        
        if (_mm_player.isPlaying) {
            [_mm_player stop];
        }
        [self.voiceView stopPlay];
    }
    
    self.voiceView = voiceView;
    /**
     *  开启新播放
     */
    [voiceView benginLoadVoice];
    
    model.voiceIsPlay = YES;
    /**
     *  获取本地缓存语音 如果有直接播放
     */
    NSData *data = [self voicData:[self fileName2]];

    if (data) {
        [self playWav:data];
        return;
    }
    
    /*
     ||
     || 下载
     ||
     
     */
    
    NSString *url = model.content;
    
    [self downloadFileWithUrl:url theModelSid:self.model.sid thePlayType:2];
    
}

- (void)playVoiceWithModel:(LWChatModel *)model withCell:(UUMessageCell *)cell{
    
    if ([self.chatModel.sid isEqualToString:model.sid] && _mm_player.isPlaying) //相同的取消在播放不播放
    {
        model.voiceIsPlay = NO;
        [_mm_player stop];
        [self.starCell.btnContent stopPlay];
        return;
    }
    
    self.chatModel = model;
    if (self.starCell) {  //不同的在播放取消播放 播放新的
        if (_mm_player.isPlaying) {
            [_mm_player stop];
        }
        [self.starCell.btnContent stopPlay];
    }
    self.starCell = cell;
    [cell.btnContent benginLoadVoice];  //下载圈圈
    model.voiceIsPlay = YES;
    //    NSString * saveFilePath = Account.videoFolder;
    
    NSData *data = [self voicData:[self fileName1]]; //判断如果本地有了 就直接播放
    if (data) {
        [self playWav:data];
        return;
    }
    /*
     ||
     || 下载
     ||
     
     */
    
    NSString *url = model.content;
    
    [self downloadFileWithUrl:url theModelSid:self.chatModel.sid thePlayType:1];
    
}

- (void)downloadFileWithUrl:(NSString *)url theModelSid:(NSString *)sid thePlayType:(NSInteger)type{

    
    [LCDownloadManager downloadFileWithURLString:url cachePath:[NSString stringWithFormat:@"%@%@",[CODataCacheManager shareInstance].userModel.sessionId,sid] progress:^(CGFloat progress, CGFloat totalMBRead, CGFloat totalMBExpectedToRead) {
        
        NSLog(@"Task1 -> progress: %.2f -> download: %fMB -> all: %fMB", progress, totalMBRead, totalMBExpectedToRead);
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Task1 -> Download finish");
        if (type == 1) {
            NSData *data = [self voicData:[self fileName1]];
            [self playWav:data];
        }else if (type == 2){
            NSData *data = [self voicData:[self fileName2]];
            [self playWav:data];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (error.code == -999) NSLog(@"Task1 -> Maybe you pause download.");
        [self.starCell.btnContent stopPlay];
        [self.voiceView stopPlay];
    }];

}


- (NSString *)fileName1
{
    return [NSString stringWithFormat:@"%@%@",[CODataCacheManager shareInstance].userModel.sessionId,self.chatModel.sid];
}
- (NSString *)fileName2
{
    return [NSString stringWithFormat:@"%@%@",[CODataCacheManager shareInstance].userModel.sessionId,self.model.sid];
}
- (NSData *)voicData:(NSString *)fileNmae
{
    NSString *videoDir = [NSString stringWithFormat:@"%@/%@",[self downloadPath],fileNmae];
    
    NSData *data = [NSData dataWithContentsOfFile:videoDir];
    
    return data;
}

- (NSString *)downloadPath
{
    
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    NSString *videoDir = [NSString stringWithFormat:@"%@/Download/Video",docPath];
    
    return videoDir;
}

-(void)playWav:(NSData*)wavdata
{
    [self.voiceView didLoadVoice];
    [self.starCell.btnContent didLoadVoice];

    if (wavdata.length>0)
    {
        _mm_player = nil;
        
        NSError *playerError;
        _mm_player = [[AVAudioPlayer alloc]initWithData:wavdata error:&playerError];
        [_mm_player setNumberOfLoops:0];
        _mm_player.delegate = self;
        [self.mm_player play];
    }
}
////得到第一相应并判断要下载的文件是否已经完整下载了
//- (void)WHCDownload:(WHC_Download *)download filePath:(NSString *)filePath hasACompleteDownload:(BOOL)has
//{
//
//}
////下载出错
//- (void)WHCDownload:(WHC_Download *)download error:(NSError *)error
//{
//
//}
////下载结束
//- (void)WHCDownload:(WHC_Download *)download filePath:(NSString *)filePath isSuccess:(BOOL)success
//{
//    if (success) {
//        NSData *data = [self voicData];
//        if (data.length <= 0) {
//            [self.starCell stopVocieAnimating];
//            return;
//        }
//        [self playWav:data];
//    }
//}


// 音频播放完成时
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    self.chatModel.voiceIsPlay = NO;
    self.model.voiceIsPlay = NO;
    [self.starCell.btnContent stopPlay];
    [self.voiceView stopPlay];
}
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError * __nullable)error
{
    self.chatModel.voiceIsPlay = NO;
    self.model.voiceIsPlay = NO;
    [self.starCell.btnContent stopPlay];
    [self.voiceView stopPlay];
}

@end
