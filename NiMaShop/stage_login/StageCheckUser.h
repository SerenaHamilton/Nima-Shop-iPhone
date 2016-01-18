//
//  StageCheckUser.h
//  NiMaShop
//
//  Created by 陳晁偉 on 2015/11/26.
//  Copyright © 2015年 RogerChen. All rights reserved.
//

#import "StageBase.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@class FBSDKProfilePictureView;

// the child view controller displaying the active user.
@interface StageCheckUser : StageBase <FBSDKLoginButtonDelegate>
{
    FBSDKLoginButton *loginButton;
}

@property (strong, nonatomic) IBOutlet FBSDKProfilePictureView *profilePictureView;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIView *viewFBbutton;

@property (weak, nonatomic) IBOutlet UIButton *btnAccount;

@end