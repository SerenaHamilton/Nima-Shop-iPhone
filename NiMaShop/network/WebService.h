//
//  NSObject+UrlLink.h
//  HotelApp
//
//  Created by 陳晁偉 on 2015/11/18.
//  Copyright © 2015年 RogerChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIImage.h>
@interface WebService : NSObject


+(void) unblockUrl:( NSString *) sUrl;

+(UIImage*) urlImage:(NSString *) sUrl;

+(void) urlGet:(NSString *) sUrl;

+(void) urlPost:(NSString*) sUrl;

@end
