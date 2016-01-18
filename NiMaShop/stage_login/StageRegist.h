//
//  StageRegist.h
//  NiMaShop
//
//  Created by 陳晁偉 on 2015/11/26.
//  Copyright © 2015年 RogerChen. All rights reserved.
//

#import "StageBase.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>


@interface StageRegist : StageBase <FBSDKLoginButtonDelegate>

@property (weak, nonatomic) IBOutlet UIView *viewFbButton;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

@end
