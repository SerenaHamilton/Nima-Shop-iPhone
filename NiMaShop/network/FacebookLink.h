//
//  NSObject+FaceBookLink.h
//  HotelApp
//
//  Created by 陳晁偉 on 2015/11/17.
//  Copyright © 2015年 RogerChen. All rights reserved.
//

//要加入framework: Social.frameword

#import <Foundation/Foundation.h>
#import <UIKit/UIImage.h>
#import <Social/SLComposeViewController.h>
#import <Social/SLServiceTypes.h>

@interface FacebookLink:NSObject

-(int) pushToFacebook: (NSString*) sText Url: (NSString*) sUrl image: (UIImage*) img;

-(int) pushToFacebook;

@end
