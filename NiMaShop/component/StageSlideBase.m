//
//  StageSildeBase.m
//  NiMaShop
//
//  Created by 陳晁偉 on 2015/11/27.
//  Copyright © 2015年 RogerChen. All rights reserved.
//

#import "StageSlideBase.h"

@interface StageSlideBase ()

@end

@implementation StageSlideBase

- (void)viewDidLoad {
    [super viewDidLoad];
    _barButton.target = self.revealViewController;
    _barButton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
