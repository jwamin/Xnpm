//
//  TaskController.h
//  Xnpm
//
//  Created by Joss Manger on 5/24/17.
//  Copyright © 2017 Joss Manger. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskController : NSObject
- (instancetype)initWithURL:(NSURL*)url;
@property (weak) NSString *path;
@property NSTask *task;
-(void)beginTask:(NSString*)cmd;
-(void)endTask;
@end
