//
//  Test01.h
//  NiMaShop
//
//  Created by 陳晁偉 on 2015/12/2.
//  Copyright © 2015年 RogerChen. All rights reserved.
//

#import "Global.h"
#import "StageSlideBase.h"

@interface Test01 : StageSlideBase<UIScrollViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    UIImage *oldImage;
}

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;

@property (weak, nonatomic) IBOutlet UITextField *txtFnName;

@property (weak, nonatomic) IBOutlet UITextField *txtFnValue;

@property (weak, nonatomic) IBOutlet UIButton *btnFn;

- (UIImage *)imageWithChromaKeyMasking ;

- (UIColor*)pixelColorInImage:(UIImage*)image atX:(int)x atY:(int)y;

- (UIImage *)eraseImageAtPoint: (CGPoint)point inImageView: (UIImageView *)imgView fromEraser: (UIImage *)eraser;

- (void)panDetected:(UIPanGestureRecognizer *)panRecognizer;
@end
