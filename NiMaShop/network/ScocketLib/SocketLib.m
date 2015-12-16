//
//  ScocketLib.m
//  ScocketLib
//
//  Created by 陳晁偉 on 2015/11/16.
//  Copyright © 2015年 RogerChen. All rights reserved.
//

//shit .....全能的ios socket 居然要自已寫

#import "SocketLib.h"

@implementation SocketLib



// 1
-(instancetype)init
{
    // 初始化
    self = [super init];
    if(self)
    {
        inputData = [NSMutableData new];
    }
    return self;
}


// 2
-(void)openReadStream:(CFReadStreamRef)readStream writeStream: (CFWriteStreamRef)writeStream child:(id)aChild
{
    // 設定資料流
    self.child = aChild; m_inputStream = (__bridge_transfer NSInputStream *)readStream; m_outputStream = (__bridge_transfer NSOutputStream *)writeStream; m_inputStream.delegate = self;
    
    m_outputStream.delegate =self;
    [m_inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode: NSDefaultRunLoopMode];
    [m_outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [m_inputStream open];
    [m_outputStream open];
    
}

// 3
-(NSData *)readData
{
    // 從 socket 讀取資料
    uint8_t buff[BUFFER_SIZE];
    long length = [m_inputStream read:buff maxLength:BUFFER_SIZE];
    [inputData appendBytes:buff length:length];
    // 判斷目前收到的資料是否已經可完整讀取「資料大小」部分
    if([inputData length] >= sizeof(NSUInteger))
    {
        // 讀取「資料大小」
        NSUInteger dataLength;
        [inputData getBytes:&dataLength length:sizeof(NSUInteger)];
        if([inputData length] - sizeof(NSUInteger)== dataLength){
            // 根據「資料大小」判斷資料已全部讀取完畢
            // tmpData 為去除「資料大小」後的原始資料
            NSData *tmpData = [inputData subdataWithRange:NSMakeRange (sizeof(NSUInteger), dataLength)].copy;
            // 將 inputData 的資料清除 => 歸零
            [inputData setData:nil];
            return tmpData;
        }
    }
    return nil;
}

// 4
-(NSUInteger)writeData:(NSData *)data
{
    // 將資料寫到 socket 上
    uint8_t buff[BUFFER_SIZE];
    NSRange window = NSMakeRange(0, BUFFER_SIZE);
   
    // 在要傳送的資料前面先補上這資料大小
    NSUInteger dataLength = [data length];
    NSMutableData *tmpData = [NSMutableData dataWithBytes:&dataLength length: sizeof(NSUInteger)];
    //tmpData 格式為 「資料大小 + 資料」
    [tmpData appendData:data];
    long length;
    do {
        if([m_outputStream hasSpaceAvailable])
        {
            if((window.location + window.length)> [tmpData length]){ window.length = [tmpData length] - window.location;
                buff[window.length] = '\0';
            }
            [tmpData getBytes:buff range:window];
            if(window.length == 0)
            {
                buff[0] = '\0';
            }

length = [m_outputStream write:buff maxLength:window.length];
            window = NSMakeRange(window.location + BUFFER_SIZE, window.length);
        }
    } while(window.length == BUFFER_SIZE);

    return [data length];
}


// 5
-(void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode
{
    // socket 連線的狀態
    switch(eventCode)
    {
        case NSStreamEventNone:
            break;
        case NSStreamEventOpenCompleted:
            break;
        case NSStreamEventHasBytesAvailable:
            if(aStream == m_inputStream)
            {
                // 網路上讀資料
                NSData *data = [self readData];
                if(data != nil)
                {
                    [self.child dataReadyForRead:data];
                    // <== 呼叫繼承者
                }
            } break;
        case NSStreamEventHasSpaceAvailable:
            if(aStream == m_outputStream)
            {
            // 準備寫資料到網路上
                }
            break;
        case NSStreamEventErrorOccurred:
            break;
        case NSStreamEventEndEncountered:
            // Socket 斷線
            NSLog(@"網路斷線");
            [self disconnect];
            [self.child streamDidClosed];
            // <==
            break;
        default:
            break;
    }
}

//6
-(void)disconnect
{
    // 網路斷線時，關閉資料流
    [m_inputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [m_outputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [m_inputStream close];
    [m_outputStream close];
}


@end
