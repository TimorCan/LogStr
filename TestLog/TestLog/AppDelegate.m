//
//  AppDelegate.m
//  TestLog
//
//  Created by jax on 2019/8/8.
//  Copyright © 2019 ict-luxshare. All rights reserved.
//

#import "AppDelegate.h"
#import "LogStr.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
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


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
