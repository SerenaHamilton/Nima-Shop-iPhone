//
//  SocketLibDelegate.h
//  ScocketLib
//
//  Created by 陳晁偉 on 2015/11/16.
//  Copyright © 2015年 RogerChen. All rights reserved.
//

////shit .....全能的ios socket 居然要自已寫

#ifndef SocketLibDelegate_h
#define SocketLibDelegate_h


@class ServerSocket;
@class OneClient;
@class Socket;


//client用
//
@protocol SocketDelegate <NSObject>

@required
-(void) dataReadyForRead: (NSData *) data;

@end

//server用

@protocol ServerSocketDelegate <NSObject>

@required
-(void) oneClientDidCounnect: (OneClient *) client;
-(void) dataReadyForRead: (NSData *) data;
@end


// socketLib
@protocol SocketState <NSObject>

@required

-(void) dataReadyForRead:(NSData *)data;
-(void) streamDidClosed;

@end


#endif /* SocketLibDelegate_h */
