//
//  LogStr.h
//  Station
//
//  Created by jax on 2019/8/8.
//  Copyright © 2019 ict-luxshare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "util.h"


#define ICTLog(s,...) [LogStr function: (char *)__FUNCTION__ lineNumber:__LINE__ format:(s),##__VA_ARGS__]


NS_ASSUME_NONNULL_BEGIN

/******Log 初始化***********
#import <LogStr/LogStr.h>
 
 
 //打印log初始化配置
 LogStr * log = [LogStr shareTools];
 //下面两种2选1
 
 NSDate * date = [NSDate date];
 NSDateFormatter * dateStringFormatter = [[NSDateFormatter alloc]init];
 [dateStringFormatter setDateFormat:@"yyyy_MM_dd_HH_mm_ss"];
 NSString * path1 = [dateStringFormatter stringFromDate:date];
 NSDictionary * dic = [NSBundle mainBundle].infoDictionary;
 NSString * name = dic[@"CFBundleName"];
 NSString * version = dic[@"CFBundleShortVersionString"];
 NSString * build = dic[@"CFBundleVersion"];
 
 //软件名_version_build_time
 NSString * path = [NSString stringWithFormat:@"%@_%@_%@_%@",name,version,build,path1];
 
 log.currentPath = path;
 
 
 
 //使用默认配置，log在桌面输出
  [log syncLogSetting];
 //自定义配置位置
 //[log settingLogPath:@"/vault/Station/log.log"];
 
 
 
 }
 
 *************/

/*******Log 使用********
 #import <LogStr/util.h>
 
 logstr(@"viewDidLoad ...........");
 ICTLog(@"%@%@",@"ice",@"hanpi");
 *************/





@interface LogStr : NSObject


@property (nonatomic, copy) NSString *currentPath;



//同步日志输出配置,默认配置
- (BOOL)syncLogSetting;

//设置log日志输出位置，可自定义log文件位置
- (BOOL)settingLogPath:(NSString *)path;

//单例
+(instancetype)shareTools;

//log 位置
- (NSString *)path;
+ (void)function:(char*)functionName lineNumber:(int)lineNumber format:(NSString*)format,...;

void logstr(NSString *str);
void ZCLog(NSString *str);
@end





NS_ASSUME_NONNULL_END

