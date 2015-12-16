//
//  NSObject+FaceBookLink.m
//  HotelApp
//
//  Created by 陳晁偉 on 2015/11/20.
//  Copyright © 2015年 RogerChen. All rights reserved.
//


//要加入framework: Social.frameword

#import "FacebookLink.h"

@implementation FacebookLink
//
-(int) pushToFacebook:(NSString*)sText Url:(NSString*)sUrl image:(UIImage*)img;
{
    // 先測試行動裝置內的 Facebook 設定是否完成
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        // 輸入資料的畫面使用系統內建的
        SLComposeViewController *social = [SLComposeViewController new];
        social = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        // 要上傳的文字
        [social setInitialText:sText];
        // 要上傳的網址
        NSURL*url = [[NSURL alloc] initWithString:sUrl];
        [social addURL:url];
        // 要上傳的圖片
       // UIImage *img = [UIImage imageNamed:@"sample.jpg"];
        [social addImage:img];
        // 開啓輸入資料畫面
       // [self presentViewController:social animated:YES completion:^{ NSLog(@"資料送到 facebook 成功");}];
    }
        
        return 0;
}

-(int) pushToFacebook
{
    // 先測試行動裝置內的 Facebook 設定是否完成
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        // 輸入資料的畫面使用系統內建的
        SLComposeViewController *social = [SLComposeViewController new];
        social = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        // 要上傳的文字
        [social setInitialText:@"aaa \n"];
        // 要上傳的網址
        NSURL*url = [[NSURL alloc] initWithString:@"www.joanbuller.com"];
        [social addURL:url];
        // 要上傳的圖片
        UIImage *img = [UIImage imageNamed:@"sample.jpg"];
        [social addImage:img];
        // 開啓輸入資料畫面
        //[self presentViewController:social animated:YES completion:^{ NSLog(@"資料送到 facebook 成功");}];
    }
    return 0;
}

@end
