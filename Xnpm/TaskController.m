//
//  TaskController.m
//  Xnpm
//
//  Created by Joss Manger on 5/24/17.
//  Copyright © 2017 Joss Manger. All rights reserved.
//

#import "TaskController.h"

@implementation TaskController

- (instancetype)initWithURL:(NSURL*)url
{
    self = [super init];
    if (self) {
        _path = [[url path]stringByDeletingLastPathComponent];
    }
    return self;
}

-(void)beginTask:(NSString*)cmd{
    _task = [[NSTask alloc]init];
    NSString *cmdStrRoot = @"npm run ";
    NSString *cmdStr = [cmdStrRoot stringByAppendingString:cmd];
    //NSString *fullString = [ stringByAppendingString:cmdStr];
    [_task setLaunchPath:@"/bin/bash"];
    [_task setArguments:@[@"-l",@"-c",cmdStr]];
    [_task setCurrentDirectoryPath:_path];
    NSPipe *pipe = [[NSPipe alloc]init];
    [_task setStandardOutput:pipe];
    NSFileHandle *outhandle = [pipe fileHandleForReading];
    [outhandle waitForDataInBackgroundAndNotify];
    
    NSObject *obs1 = [[NSObject alloc]init];
    [[NSNotificationCenter defaultCenter]addObserverForName:NSFileHandleDataAvailableNotification object:outhandle queue:nil usingBlock:^(NSNotification *notification){
        NSData *data = [outhandle availableData];
        if(data.length>0){
            NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"gotOut" object:str];
            [outhandle waitForDataInBackgroundAndNotify];
        } else {
            NSLog(@"EOF in stdout from process, removing obs1 observer");
            [[NSNotificationCenter defaultCenter]postNotificationName:@"gotEnd" object:@"got end"];
            [[NSNotificationCenter defaultCenter]removeObserver:obs1];
        }
        
    }];
    
    NSObject *obs2 = [[NSObject alloc]init];
    [[NSNotificationCenter defaultCenter]addObserverForName:NSTaskDidTerminateNotification object:_task queue:nil usingBlock:^(NSNotification *notification){
        NSLog(@"Terminated, removing obs2 observer");
        [[NSNotificationCenter defaultCenter]removeObserver:obs2];
    }];
    [_task launch];
}

-(void)endTask{
    NSLog(@"Got terminate signal.");
    [_task terminate];
}


@end
