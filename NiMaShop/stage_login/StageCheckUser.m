//
//  StageCheckUser.m
//  NiMaShop
//
//  Created by 陳晁偉 on 2015/11/26.
//  Copyright © 2015年 RogerChen. All rights reserved.
//

#import "StageCheckUser.h"




@implementation StageCheckUser


//==========UIViewController
//
- (void)viewDidLoad
{
    [super viewDidLoad];
    // self.btnLogin=[[FBSDKLoginButton alloc]init];
    self.profilePictureView=[[FBSDKProfilePictureView alloc]init];
    self.profilePictureView.profileID=@"me";
    // [self.subtitleLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tapLink:)]];
    [self _updateContent:nil];
    //    //
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_updateContent:) name:FBSDKProfileDidChangeNotification object:nil];
}


-(void) viewDidAppear:(BOOL)animated
{
    loginButton= [[FBSDKLoginButton alloc] init];
    
    loginButton.frame=CGRectMake(0, 0, self.viewFBbutton.frame.size.width, self.viewFBbutton.frame.size.height);
    
    loginButton.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    
    [self.viewFBbutton addSubview:loginButton];
    
    [loginButton setDelegate:self];
}


- (void)dealloc
{
    // [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)_updateContent:(NSNotification *)notification
{
    if ([FBSDKAccessToken currentAccessToken]) {
        self.titleLabel.hidden = NO;
        self.titleLabel.text = [FBSDKProfile currentProfile].name;
        //  self.subtitleLabel.text = [FBSDKProfile currentProfile].linkURL.absoluteString;
    } else {
        self.titleLabel.hidden = YES;
        // self.subtitleLabel.text = @"No active user. Go to Accounts tab to log in!";
    }
}


- (void)_tapLink:(UITapGestureRecognizer *)gesture
{
    //        if ([FBSDKAccessToken currentAccessToken])
    //        {
    //            NSURL *url = [NSURL URLWithString:self.subtitleLabel.text];
    //            [[UIApplication sharedApplication] openURL:url];
    //        }
}

- (IBAction)btnAccountPress:(UIButton *)sender
{
    UIViewController *nextView;
    
    nextView =[self.storyboard instantiateViewControllerWithIdentifier:@"agree"];
    
    [self showViewController:nextView sender:self];
}


//=====FBSDKLoginButtonDelegate
//

-(void) loginButtonDidLogOut:(FBSDKLoginButton *)loginButton
{
    NSLog(@"logout finish");
    self.btnAccount.hidden=true;
    
    UIViewController *nextView;
    
    nextView =[self.storyboard instantiateViewControllerWithIdentifier:@"StageInto"];
    
    [self showViewController:nextView sender:self];
    
}

-(void) loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error
{
    if ([FBSDKAccessToken currentAccessToken])
    {
        NSLog(@"login finish");
        self.btnAccount.hidden=false;
        
        UIViewController *nextView;
        
        nextView =[self.storyboard instantiateViewControllerWithIdentifier:@"agree"];
        
        [self showViewController:nextView sender:self];
    }
}


@end

