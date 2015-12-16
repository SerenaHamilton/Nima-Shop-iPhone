//
//  Test01.h
//  NiMaShop
//
//  Created by 陳晁偉 on 2015/12/2.
//  Copyright © 2015年 RogerChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Global.h"


@interface Test01 : UIViewController<UIScrollViewDelegate>
{
    UIImage *oldImage;
}

@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;


- (UIImage *)imageWithChromaKeyMasking ;
- (UIImage*) replaceColor:(UIColor*)color inImage:(UIImage*)image withTolerance:(float)tolerance ;


@end
