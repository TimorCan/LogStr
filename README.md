# LogStr
Mac os 打印log日志在本地文件


## 1.初始化
```
`- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
 // Insert code here to initialize your application
 
 //打印log初始化配置
 LogStr * log = [LogStr shareTools]();
 //下面两种2选1
 
 //使用默认配置，log在桌面输出
 // [log syncLogSetting]();
 
 //自定义配置位置
 [log settingLogPath:@"/vault/Station/log.log"]();
 }
 ```
`
## 2. Log 使用

```
`# import \<LogStr/util.h\>
 
 logstr(@"viewDidLoad ...........");
```
`

