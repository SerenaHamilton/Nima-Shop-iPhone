//
//  LayerRemoveBackground.h
//  NiMaShop
//
//  Created by 陳晁偉 on 2015/12/18.
//  Copyrigªªªht © 2015年 RogerChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Global.h"
#import "ItemScaleImage.h"

@protocol LayerRemoveBgDelegate

//协定中的方法

- (void)reImage:(UIImage *)image;


@end

@interface LayerRemoveBackground : UIViewController//<UIScrollViewDelegate>
{
    
    int m_iMode;
    

    float fScale;
    CGPoint currentTouch;
    CGPoint lastTouch;
    IBOutlet ItemScaleImage *m_imageView;
    int iRemoveRange;
    NSMutableArray *listHistoryImage;
    __weak IBOutlet UIButton *btnPreImage;
    
    __weak IBOutlet UIButton *btnEraser;
    
    __weak IBOutlet UIButton *btnRemoveBg;
    
    __weak IBOutlet UILabel *lbPre;
    __weak IBOutlet UILabel *lbEraser;
    __weak IBOutlet UILabel *lbRemoveBg;
    IBOutlet UILabel *lbSlider;
}

//@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

-(void) setImage:(UIImage *) image;


- (UIImage *)maskImage:(UIImage *)image setR:(float)r setG:(float)g setB:(float)b;

- (void)panDetected:(UIPanGestureRecognizer *)panRecognizer;

@property (weak, nonatomic) id<LayerRemoveBgDelegate> delegate;   //记得@synthesize
-(void)sendDataA:(NSString*)st;

@end
