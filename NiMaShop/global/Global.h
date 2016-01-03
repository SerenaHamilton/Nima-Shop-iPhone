//
//  Global.h
//  HotelApp
//
//  Created by 陳晁偉 on 2015/11/12.
//  Copyright © 2015年 RogerChen. All rights reserved.
//

#ifndef Global_h
#define Global_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define IPHONE_4 "iPhone 4"
#define IPHONE_4S "iPhone 4S"






@interface Global : NSObject
{
    int m_iLanguage;
}



//--instance methods--
//-(void) doSomething;

//--class method--
+(void) ini;

+(NSBundle*) bundle;

+(void) changeLanguage:(int)iIdx;

+(int) language;

+(NSString*) device;

+(NSString*) tr:(NSString*)sKey;

+ (NSString *) platformType:(NSString *)platform;


+(UIImage*) sticker :(UIImage*)image atIndex:(NSInteger)idx;

+ (CGSize) getImageSizeAfterAspectFit:(UIImageView *) imageView ;

@end




#endif /* Global_h */
