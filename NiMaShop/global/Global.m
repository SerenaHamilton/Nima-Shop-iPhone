//
//  Global.m
//  HotelApp
//
//  Created by 陳晁偉 on 2015/11/12.
//  Copyright © 2015年 RogerChen. All rights reserved.
//

#import "Global.h"
#import <sys/sysctl.h>
int g_iLanguage=0;
NSString *g_device;

@interface Global()


@end



@implementation Global


static NSBundle *g_bundle;

+(void) ini
{
    
    
    g_bundle= [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"Base" ofType:@"lproj"]];
    
    size_t size;
    // sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    g_device=[self platformType:platform];
    NSLog(@"iPhone Device: %@",g_device);
    
    
    
    
}


+(NSBundle*) bundle
{
    return g_bundle;
}

+(void) changeLanguage:(int)iIdx
{
    g_iLanguage=iIdx;
    if(iIdx==1)
    {
        g_bundle= [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"zh-Hant" ofType:@"lproj"]];
        NSLog(@"change language: zh-Hant");
        
    }
    else if(iIdx==2)
    {
        g_bundle= [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"zh-Hans" ofType:@"lproj"]];
        
        NSLog(@"change language: zh-Hans");
    }
    else if(iIdx==3)
    {
        g_bundle= [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"ja" ofType:@"lproj"]];
        
        NSLog(@"change language: ja");
    }
    else
    {
        g_bundle= [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:
                                            @"Base" ofType:@"lproj"]];
        NSLog(@"change language: base(en)");
    }
    
    //    self.lbName.text=NSLocalizedStringFromTableInBundle(@"userName", nil, bundle, nil);
}

+(int) language
{
    return g_iLanguage;
}

+(NSString*) device
{
    return g_device;
}

+(NSString*) tr:(NSString*)sKey
{
    NSString *sRe=@"";
    
    sRe=NSLocalizedStringFromTableInBundle(sKey, nil, g_bundle, nil);
    
    
    return sRe;
}


+ (NSString *) platformType:(NSString *)platform
{
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"Verizon iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5 (GSM)";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad Mini (GSM)";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3 (GSM)";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4 (GSM)";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([platform isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([platform isEqualToString:@"iPad4,3"])      return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,4"])      return @"iPad Mini 2G (WiFi)";
    if ([platform isEqualToString:@"iPad4,5"])      return @"iPad Mini 2G (Cellular)";
    if ([platform isEqualToString:@"iPad4,6"])      return @"iPad Mini 2G";
    if ([platform isEqualToString:@"iPad4,7"])      return @"iPad Mini 3 (WiFi)";
    if ([platform isEqualToString:@"iPad4,8"])      return @"iPad Mini 3 (Cellular)";
    if ([platform isEqualToString:@"iPad4,9"])      return @"iPad Mini 3 (China)";
    if ([platform isEqualToString:@"iPad5,3"])      return @"iPad Air 2 (WiFi)";
    if ([platform isEqualToString:@"iPad5,4"])      return @"iPad Air 2 (Cellular)";
    if ([platform isEqualToString:@"AppleTV2,1"])   return @"Apple TV 2G";
    if ([platform isEqualToString:@"AppleTV3,1"])   return @"Apple TV 3";
    if ([platform isEqualToString:@"AppleTV3,2"])   return @"Apple TV 3 (2013)";
    if ([platform isEqualToString:@"i386"])         return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
    return platform;
}


+(UIImage*) sticker :(UIImage*)image atIndex:(NSInteger)idx
{
    
    //    UIImage *image=[UIImage imageNamed:sName];
    //    //UIImage *image=[WebService urlImage:@"http://image.wangchao.net.cn/baike/1256135629539.jpg"];
    
    //設定剪裁影像的位置與大小
    int iStartX=idx%6*220;
    long int iStartY=idx/6*220;
    
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(iStartX,iStartY,220,220));
    
    //剪裁影像
    UIImage *copiedImage = [UIImage imageWithCGImage:imageRef];
    
    CGImageRelease(imageRef);
    
    return copiedImage;
}

+ (CGSize) getImageSizeAfterAspectFit:(UIImageView *) imageView
{
    float widthRatio = imageView.bounds.size.width / imageView.image.size.width;
    float heightRatio = imageView.bounds.size.height / imageView.image.size. height;
    float scale = MIN(widthRatio,heightRatio);
    float imageWidth = scale * imageView.image.size.width;
    float imageHeight = scale * imageView.image.size.height;
    return CGSizeMake(imageWidth,imageHeight);
}

@end