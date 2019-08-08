//
//  ViewController.m
//  TestLog
//
//  Created by jax on 2019/8/8.
//  Copyright © 2019 ict-luxshare. All rights reserved.
//

#import "ViewController.h"
#import <LogStr/util.h>
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    logstr(@"viewDidLoad ...........");
    
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
