//
//  ItemScaleImage.m
//  NiMaShop
//
//  Created by 陳晁偉 on 2015/12/31.
//  Copyright © 2015年 RogerChen. All rights reserved.
//

#import "ItemScaleImage.h"

@implementation ItemScaleImage

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 */
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    

}

-(void) initImage
{
    NSLog(@"image scale");
    
    self.userInteractionEnabled = YES;
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panDetected:)];
    [self addGestureRecognizer:panRecognizer];
    
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchDetected:)];
    [self addGestureRecognizer:pinchRecognizer];
    
//    UIRotationGestureRecognizer *rotationRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationDetected:)];
//    [self addGestureRecognizer:rotationRecognizer];
//    
//    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
//    tapRecognizer.numberOfTapsRequired = 2;
//    [self addGestureRecognizer:tapRecognizer];
}




- (void)panDetected:(UIPanGestureRecognizer *)panRecognizer
{
    
    CGPoint translation = [panRecognizer translationInView:self];
    CGPoint imageViewPosition = self.center;
    
    NSLog(@"loc : %f ,%f",translation.x,translation.y);
    
        imageViewPosition.x += translation.x;
        imageViewPosition.y += translation.y;
    
        self.center = imageViewPosition;
        [panRecognizer setTranslation:CGPointZero inView:self.superview];
}

- (void)pinchDetected:(UIPinchGestureRecognizer *)pinchRecognizer
{
    CGFloat scale = pinchRecognizer.scale;
    NSLog(@"scale , %f ",scale);
    self.transform = CGAffineTransformScale(self.transform, scale, scale);
    pinchRecognizer.scale = 1.0;
}

- (void)rotationDetected:(UIRotationGestureRecognizer *)rotationRecognizer
{
    CGFloat angle = rotationRecognizer.rotation;
    self.transform = CGAffineTransformRotate(self.transform, angle);
    rotationRecognizer.rotation = 0.0;
}

- (void)tapDetected:(UITapGestureRecognizer *)tapRecognizer
{
    [UIView animateWithDuration:0.25 animations:^{
        self.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        self.transform = CGAffineTransformIdentity;
    }];
}

@end
