# LogStr
Mac os 打印log日志在本地文件


## 1.初始化
```
#import <LogStr/LogStr.h>
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
 ```

## 2. Log 使用

```
# import <LogStr/LogStr.h>
 
 logstr(@"viewDidLoad ...........");
 ICTLog(@"李爱思是个憨批");
```

