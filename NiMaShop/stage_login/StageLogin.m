//
//  StageLogin.m
//  NiMaShop
//
//  Created by 陳晁偉 on 2015/11/26.
//  Copyright © 2015年 RogerChen. All rights reserved.
//

#import "StageLogin.h"

@interface StageLogin ()

@end

@implementation StageLogin

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.frame=CGRectMake(0, 0, self.viewFbButton.frame.size.width, self.viewFbButton.frame.size.height);
    loginButton.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    
    [self.viewFbButton addSubview:loginButton];
    [loginButton setDelegate:self];
    
    visualEffectView= [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    
    visualEffectView.frame = self.view.bounds;
    
    [_backgroundImage addSubview:visualEffectView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(void) loginButtonDidLogOut:(FBSDKLoginButton *)loginButton
{
    NSLog(@"logout finish");
    
}


-(void) loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error
{
    if ([FBSDKAccessToken currentAccessToken])
    {
        NSLog(@"login finish");
        
        UIViewController *nextView;
        
        nextView =[self.storyboard instantiateViewControllerWithIdentifier:@"agree"];
        
        [self showViewController:nextView sender:self];
    }
}

@end
