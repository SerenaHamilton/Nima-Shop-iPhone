//
//  LayerRemoveBackground.h
//  NiMaShop
//
//  Created by 陳晁偉 on 2015/12/18.
//  Copyrigªªªht © 2015年 RogerChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Global.h"

@interface LayerRemoveBackground : UIViewController<UIScrollViewDelegate>
{
    
  //  UIImage *m_imageEdit;
    UIImageView *m_imageView;
    int iRemoveRange;
    NSMutableArray *listHistoryImage;
    __weak IBOutlet UIButton *btnPreImage;
    
    __weak IBOutlet UIButton *btnEraser;
    
    __weak IBOutlet UIButton *btnRemoveBg;
    
    __weak IBOutlet UILabel *lbPre;
    __weak IBOutlet UILabel *lbEraser;
    __weak IBOutlet UILabel *lbRemoveBg;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

-(void) setImage:(UIImage *) image;

-(UIImage*) returnImage;

- (UIImage *)maskImage:(UIImage *)image setR:(float)r setG:(float)g setB:(float)b;

- (void)panDetected:(UIPanGestureRecognizer *)panRecognizer;
@end
