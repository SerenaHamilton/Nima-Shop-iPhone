//
//  NSObject+Socket.m
//  ScocketLib
//
//  Created by 陳晁偉 on 2015/11/17.
//  Copyright © 2015年 RogerChen. All rights reserved.
//

//shit .....全能的ios socket 居然要自已寫

#import "Socket.h"


@implementation Socket


//1
- (instancetype) init
{
    // Socket 初始化
    self = [super init];
    if(self)
    {
    }
    return self;
}

// 2
- (instancetype) initWithIP: (NSString *)ip port:(int)port delegate:(id) delegate
{
    // 跟 server 連線，並且開啟 I/O stream
    self = [self init];
    if(self)
    {
        self.delegate = delegate;
        CFReadStreamRef readStream;
        CFWriteStreamRef writeStream;
        CFStreamCreatePairWithSocketToHost( NULL, (__bridge CFStringRef)ip, port, &readStream, &writeStream);
        //[super openReadStream:<#(CFReadStreamRef)#> writeStream:<#(CFWriteStreamRef)#> child:<#(id)#>];
        [super openReadStream:readStream writeStream:writeStream child:self];
    }
    return self;
}

// 3
-(void)dataReadyForRead:(NSData *)data
{
    // 讀取到一筆資料
    [self.delegate dataReadyForRead:data];
}

-(void)streamDidClosed
{
    
}

@end
