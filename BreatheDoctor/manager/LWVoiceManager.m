//
//  LWVoiceManager.m
//  BreatheDoctor
//
//  Created by comv on 15/11/16.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWVoiceManager.h"
#import "WHC_Download.h"
#import "WHC_ClientAccount.h"
#import "WHC_DownloadFileCenter.h"
#import "NSString+Contains.h"
#import "LCDownloadManager.h"
#

@interface LWVoiceManager ()<WHCDownloadDelegate,AVAudioPlayerDelegate>
@property (nonatomic, strong) AVAudioPlayer * mm_player;
@property (nonatomic, strong) LWChatModel *chatModel;
@property (nonatomic, strong) UUMessageCell *starCell;
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
    }
}
- (void)playVoiceWithModel:(LWChatModel *)model withCell:(UUMessageCell *)cell{
    
    if ([self.chatModel.sid isEqualToString:model.sid] && _mm_player.isPlaying) //相同的取消在播放不播放
    {
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
    
//    NSString * saveFilePath = Account.videoFolder;

    NSData *data = [self voicData]; //判断如果本地有了 就直接播放
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
    
    [LCDownloadManager downloadFileWithURLString:url cachePath:[NSString stringWithFormat:@"%@%@",[CODataCacheManager shareInstance].userModel.sessionId,self.chatModel.sid] progress:^(CGFloat progress, CGFloat totalMBRead, CGFloat totalMBExpectedToRead) {
        
        NSLog(@"Task1 -> progress: %.2f -> download: %fMB -> all: %fMB", progress, totalMBRead, totalMBExpectedToRead);
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Task1 -> Download finish");
        NSData *data = [self voicData];
        [self playWav:data];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (error.code == -999) NSLog(@"Task1 -> Maybe you pause download.");
        [self.starCell.btnContent stopPlay];

    }];
    
//    [WHCDownloadCenter startDownloadWithURL:[NSURL URLWithString:url] savePath:saveFilePath savefileName:[NSString stringWithFormat:@"%@%@",[CODataCacheManager shareInstance].userModel.sessionId,self.chatModel.sid] delegate:self];
    
}

- (NSString *)fileName1
{
    return [NSString stringWithFormat:@"%@%@",[CODataCacheManager shareInstance].userModel.sessionId,self.chatModel.sid];
}
- (NSString *)fileName2
{
    return [NSString stringWithFormat:@"%@%@",[CODataCacheManager shareInstance].userModel.sessionId,self.chatModel.sid];
}
- (NSData *)voicData
{
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    NSString *videoDir = [NSString stringWithFormat:@"%@/Download/Video/%@",docPath,[self fileName1]];
    
    NSData *data = [NSData dataWithContentsOfFile:videoDir];

    return data;
}
-(void)playWav:(NSData*)wavdata
{
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
    [self.starCell.btnContent stopPlay];
}
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError * __nullable)error
{
    [self.starCell.btnContent stopPlay];
}

@end
