//
//  LogStr.m
//  Station
//
//  Created by jax on 2019/8/8.
//  Copyright © 2019 ict-luxshare. All rights reserved.
//

#import "LogStr.h"

#define filePathKey @"filePathKey.station.ict.log"


//首先定义一个全局静态变量，不让外界访问
static LogStr *_instance;
@implementation LogStr


//对外界提供一个友好的接口
+(instancetype)shareTools {
    //    此处用self主要是考虑到如果有子类继承
    return [[self alloc] init];
}
//重写关键方法
+(instancetype)allocWithZone:(struct _NSZone *)zone {
    @synchronized(self) {
        if (_instance == nil) {
            _instance = [super allocWithZone:zone];
        }
        return _instance;
    }
}
//严谨起见
-(id)copyWithZone:(NSZone *)zone {
    return _instance;
}
-(id)mutableCopyWithZone:(NSZone *)zone {
    return _instance;
}


//同步日志输出配置
- (BOOL)syncLogSetting{
    
    NSString * path1 = [self cmd:@"cd ~/Desktop/; pwd"];
    NSString * path2 = [path1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSString * path = [NSString stringWithFormat:@"%@/loginfo.log",path2];
    
   
    
    
    NSFileManager * manager = [NSFileManager defaultManager];
    
    if (![manager fileExistsAtPath:path]) {
        //文件不存在，则创建
       BOOL res =  [manager createFileAtPath:path contents:nil attributes:nil];
        if(res){
            [[NSUserDefaults standardUserDefaults]setObject:path forKey:filePathKey];
            [[NSUserDefaults standardUserDefaults]synchronize];
             logstr(@"初始化默认配置成功");
             [self logVersion];
        }else{
            logstr(@"初始化默认配置失败");
        }
       return  res;
        
    }else{
        [[NSUserDefaults standardUserDefaults]setObject:path forKey:filePathKey];
        [[NSUserDefaults standardUserDefaults]synchronize];
        logstr(@"初始化默认配置成功");
         [self logVersion];
        return YES;
    }
    
    
    
    
    
}








- (NSString *)path{
    
    NSString * path = [[NSUserDefaults standardUserDefaults] objectForKey:filePathKey];
    if (path != nil && [path isKindOfClass:[NSString class]] && ![path isEqualToString:@""] && path.length >0) {
        return path;
    }
    return @"";
    
}

//设置log日志输出位置
- (BOOL)settingLogPath:(NSString *)path{
    
    NSArray * array = [path componentsSeparatedByString:@"/"];
    
    NSMutableArray * pathArray = [array mutableCopy];
    [pathArray removeLastObject];
    NSString * path1 = [pathArray componentsJoinedByString:@"/"];
    
    
    NSFileManager * manager = [NSFileManager defaultManager];
    
    if (![manager fileExistsAtPath:path]) {
        //文件不存在，则创建
        NSError *errMsg;
        BOOL res =  [manager createDirectoryAtPath:path1 withIntermediateDirectories:YES attributes:nil error:&errMsg];
        
        if(!res){
            
            logstr(@"初始化自定义配置失败");
            return res;
        }
        
        BOOL res1 =  [manager createFileAtPath:path contents:nil attributes:nil];
        if(res1){
            [[NSUserDefaults standardUserDefaults]setObject:path forKey:filePathKey];
            [[NSUserDefaults standardUserDefaults]synchronize];
            logstr(@"初始化自定义配置成功");
             [self logVersion];
        }else{
            logstr(@"初始化自定义配置失败");
        }
        return  res1;
        
    }else{
        [[NSUserDefaults standardUserDefaults]setObject:path forKey:filePathKey];
        [[NSUserDefaults standardUserDefaults]synchronize];
        logstr(@"初始化自定义配置成功");
        [self logVersion];
        return YES;
    }
    
    return NO;
    
}


- (NSString *)cmd:(NSString *)cmd
{
    // 初始化并设置shell路径
    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath: @"/bin/bash"];
    // -c 用来执行string-commands（命令字符串），也就说不管后面的字符串里是什么都会被当做shellcode来执行
    NSArray *arguments = [NSArray arrayWithObjects: @"-c", cmd, nil];
    [task setArguments: arguments];
    
    // 新建输出管道作为Task的输出
    NSPipe *pipe = [NSPipe pipe];
    [task setStandardOutput: pipe];
    
    // 开始task
    NSFileHandle *file = [pipe fileHandleForReading];
    [task launch];
    
    // 获取运行结果
    NSData *data = [file readDataToEndOfFile];
    return [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
}


- (void)logVersion{
    logstr(@"------------------------------------------");
    logstr(@"--------------logstr加载成功-version:1.0---------------------------");
    logstr(@"------------------------------------------");
}


//#define vags [NSString stringWithFormat:(s),##__VA_ARGS__]

void ZCLog(NSString *str){
    
    
    //    NSString * s = [NSString stringWithFormat:(s),##__VA_ARGS__];
    
    
    LogStr * ins = [LogStr shareTools];
    
    
    @try {
        
        
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:ins.path];
        if (fileHandle){
            [fileHandle seekToEndOfFile];
            [fileHandle writeData:[@"\n" dataUsingEncoding:NSUTF8StringEncoding]];
            
            [fileHandle writeData:[[NSString stringWithFormat:@"%@:: ", [NSDate date]] dataUsingEncoding:NSUTF8StringEncoding]];
            [fileHandle writeData:[str dataUsingEncoding:NSUTF8StringEncoding]];
            [fileHandle closeFile];
        }
    } @catch(NSException * e) {
        
        NSLog(@"%@",e.description);
        
    }
    
    
}


void logstr(NSString *str) {
    
    LogStr * ins = [LogStr shareTools];
    
    @try {
        NSLog(@"%@", str);
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:ins.path];
        if (fileHandle){
            [fileHandle seekToEndOfFile];
            [fileHandle writeData:[@"\n" dataUsingEncoding:NSUTF8StringEncoding]];
            
            [fileHandle writeData:[[NSString stringWithFormat:@"%@:: ", [NSDate date]] dataUsingEncoding:NSUTF8StringEncoding]];
            [fileHandle writeData:[str dataUsingEncoding:NSUTF8StringEncoding]];
            [fileHandle closeFile];
        }
    } @catch(NSException * e) {
        
        NSLog(@"%@",e.description);
        
    }
}

@end
