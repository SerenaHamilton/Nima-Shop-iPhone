//
//  NSObject+Socket.h
//  ScocketLib
//
//  Created by 陳晁偉 on 2015/11/17.
//  Copyright © 2015年 RogerChen. All rights reserved.
//

//shit .....全能的ios socket 居然要自已寫

#import <Foundation/Foundation.h>
#import "SocketLib.h"

@interface Socket  :SocketLib <SocketState>

@property(nonatomic,assign) id<SocketDelegate> delegate;

- (instancetype) initWithIP:(NSString *)ip port:(int)port delegate:(id) delegate;

@end
