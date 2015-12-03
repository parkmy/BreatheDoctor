//
//  HMFileManager.m
//  HMExtents
//
//  Created by yons on 15/7/9.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "HMFileManager.h"

@implementation HMFileManager

/// 把对象归档存到沙盒里
+(void)saveObject:(id)object byFileName:(NSString*)fileName
{
    NSString *path  = [self appendFilePath:fileName];
    
    [NSKeyedArchiver archiveRootObject:object toFile:path];
    
}
/// 通过文件名从沙盒中找到归档的对象
+(id)getObjectByFileName:(NSString*)fileName
{
    
    NSString *path  = [self appendFilePath:fileName];

    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}

// 根据文件名删除沙盒中的 plist 文件
+(void)removeFileByFileName:(NSString*)fileName
{
    NSString *path  = [self appendFilePath:fileName];

    [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
}

/// 拼接文件路径
+(NSString*)appendFilePath:(NSString*)fileName
{
   
    NSString *documentsPath =[[self class] dirDoc]; ;
    
    NSString *testDirectory = [documentsPath stringByAppendingPathComponent:@"ChatLibrary"];
    
    
    // 判断存放音频、视频的文件夹是否存在，不存在则创建对应文件夹
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL isDir = FALSE;
    
    BOOL isDirExist = [fileManager fileExistsAtPath:testDirectory isDirectory:&isDir];
    
    if(!(isDirExist && isDir))
        
    {
        
        BOOL bCreateDir = [fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
        if(!bCreateDir){
            
            NSLog(@"Create Audio Directory Failed.");
        }
    }
    NSString *file = [NSString stringWithFormat:@"%@/%@.plist",testDirectory,fileName];
    
    return file;

    
}



//获取Documents目录
-(NSString *)dirDoc{
    //[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"app_home_doc: %@",documentsDirectory);
    return documentsDirectory;
}
//获取Cache目录
-(void)dirCache{
    NSArray *cacPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cacPath objectAtIndex:0];
    NSLog(@"app_home_lib_cache: %@",cachePath);
}
//获取Tmp目录
-(void)dirTmp{
    //[NSHomeDirectory() stringByAppendingPathComponent:@"tmp"];
    NSString *tmpDirectory = NSTemporaryDirectory();
    NSLog(@"app_home_tmp: %@",tmpDirectory);
}
-(void)dirHome{
    NSString *dirHome=NSHomeDirectory();
    NSLog(@"app_home: %@",dirHome);
}

@end
