//
//  util.m
//  QTCrownBundle
//
//  Created by Jimmy Lee on 10/11/17.
//  Copyright © 2017 Jimmy Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LogStr.h"
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
