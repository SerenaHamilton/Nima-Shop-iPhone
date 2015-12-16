//
//  ScocketLib.h
//  ScocketLib
//
//  Created by 陳晁偉 on 2015/11/16.
//  Copyright © 2015年 RogerChen. All rights reserved.
//

//shit .....全能的ios socket 居然要自已寫


#import <Foundation/Foundation.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import "SocketLibDelegate.h"

#define BUFFER_SIZE 1024

@interface SocketLib : NSObject <NSStreamDelegate>
{
    NSInputStream *m_inputStream;
    NSOutputStream *m_outputStream;
    NSMutableData *inputData;
}

@property (nonatomic, assign) id child;

-(void) openReadStream:(CFReadStreamRef)readStream
           writeStream:(CFWriteStreamRef) writeStream
                 child:(id) aChild;

-(NSDate *) readData;

-(NSUInteger) writeData:(NSData *) data;

-(void) disconnect;


@end
