//
//  StageLogin.h
//  NiMaShop
//
//  Created by 陳晁偉 on 2015/11/24.
//  Copyright © 2015年 RogerChen. All rights reserved.
//

#import "StageBase.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface StageStart : StageBase <UIScrollViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSMutableArray *listPickerData;
    CGFloat imageW, imageH;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UILabel *lbLanguage;

@property (weak, nonatomic) IBOutlet UIView *viewLogo;

-(void) toNextStage;

//key
@property (weak) NSString *keyString;
@end
