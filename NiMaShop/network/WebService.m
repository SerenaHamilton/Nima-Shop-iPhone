//
//  NSObject+UrlLink.m
//  HotelApp
//
//  Created by 陳晁偉 on 2015/11/18.
//  Copyright © 2015年 RogerChen. All rights reserved.
//

#import "WebService.h"

@implementation WebService

+(void) unblockUrl :(NSString*) sUrl
{
    
    NSURL *url = [NSURL URLWithString:sUrl]; NSURLRequest *request = [NSURLRequest requestWithURL:url]; NSOperationQueue *queue = [NSOperationQueue new];
    // 非同步模式讀取網頁
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response,NSData *data, NSError *error)
     {
         // web server 回應
         if([data length] > 0 && error == nil)
         { NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
             // html 變數存放該 url 的內容
             NSLog(@"%@", html);
         }
         else
         {
         }
     }
     ];
}

+(UIImage*) urlImage:(NSString *)sUrl
{
    UIImage *img;
    // 設定圖片的網址
    NSURL *url = [NSURL URLWithString:sUrl];
    // 將網址轉換成 http request，這樣才能跟 web server 要資料
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSURLResponse *response = nil;
    NSError *error = nil;
    // 用同步方式跟 web server 要資料
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error ];
    if([data length] > 0 && error == nil)
    {
        img = [UIImage imageWithData:data];
        // 圖片已經放在 img 變數中，接下來顯示在螢幕上或是存檔都可以
        NSLog(@"圖片下載完畢 size為%.0f x %.0f", img.size.width,img.size.height);
        
    }
    else
    {
        NSLog(@"Aerror: %@", error);
    }
    
    return img;
    
}

+(void) urlGet:(NSString*) sUrl
{
    // 先把url串好再呼 叫
    NSURL *url = [NSURL URLWithString:sUrl];
   // NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //to do 回傳值解析
}

+(void) urlPost:(NSString*) sUrl
{
    NSURL *url = [NSURL URLWithString:sUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSString *submitContent = @"x=10&y=20"; [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[submitContent dataUsingEncoding:NSUTF8StringEncoding]];
}



@end
