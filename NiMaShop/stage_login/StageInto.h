//
//  StageInto.h
//  NiMaShop
//
//  Created by 陳晁偉 on 2015/11/25.
//  Copyright © 2015年 RogerChen. All rights reserved.
//

#import "StageBase.h"



@interface StageInto : StageBase <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIPageControl *pageCtrl;

@property (weak, nonatomic) IBOutlet UIButton *btnRegist;

@property (weak, nonatomic) IBOutlet UIButton *btnLogin;

@property (weak, nonatomic) IBOutlet UIView *viewLogo;

@end
