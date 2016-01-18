//
//  LayerRemoveBackground.m
//  NiMaShop
//
//  Created by 陳晁偉 on 2015/12/18.
//  Copyright © 2015年 RogerChen. All rights reserved.
//

#import "LayerRemoveBackground.h"

@interface LayerRemoveBackground ()

#define REMOVE_BG 0

#define ERASER 1


@end

@implementation LayerRemoveBackground

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    listHistoryImage=[[NSMutableArray alloc]init];
    
    UIImage *image= [UIImage imageNamed:@"close"];
    
    //    m_imageView=[[UIImageView alloc]initWithImage:image];
    //
    m_imageView.image=image;
    
    [m_imageView initImage];
    m_imageView.contentMode=UIViewContentModeScaleAspectFit;
    [listHistoryImage addObject:m_imageView.image];
    
    iRemoveRange=0;
    
    fScale=1.0;
    
    m_iMode=REMOVE_BG;
    
    [btnEraser setSelected:false];
    
    [btnRemoveBg setSelected:true];
    
    
    
    UITapGestureRecognizer * tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    [m_imageView addGestureRecognizer:tapRecognizer];
    m_imageView.userInteractionEnabled = YES;
    
        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panDetected:)];
        [m_imageView addGestureRecognizer:panRecognizer];
    
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchDetected:)];
    [m_imageView addGestureRecognizer:pinchRecognizer];
    

  
    
}

- (void)panDetected:(UIPanGestureRecognizer *)panRecognizer
{
    
    if(panRecognizer.state == UIGestureRecognizerStateBegan)
    {
    
        return;
    }
    
    else if(panRecognizer.state == UIGestureRecognizerStateEnded)
    {
        [self changeImage];
        return;
    }
    
    if(panRecognizer.numberOfTouches==1 && m_iMode==ERASER)
    {

        CGPoint translation = [panRecognizer translationInView:m_imageView];
        CGPoint imageViewPosition = lastTouch;
      
        imageViewPosition.x += translation.x;
        imageViewPosition.y += translation.y;
        
       // m_imageView.center = imageViewPosition;
        currentTouch=imageViewPosition;
        [panRecognizer setTranslation:CGPointZero inView:m_imageView];
        
        
        UIGraphicsBeginImageContext(m_imageView.frame.size);
        
        [m_imageView.image drawInRect:CGRectMake(0, 0,  UIGraphicsGetImageFromCurrentImageContext().size.width,  UIGraphicsGetImageFromCurrentImageContext().size.height)];
        
        
       
        m_imageView.contentMode=UIViewContentModeScaleAspectFit;
        

    //    NSLog(@"sin %f  to %f ",lastTouch.x,currentTouch.x);
        
        
        
        float scaleW=fScale;//=m_imageView.image.size.width/m_imageView.frame.size.width;
        float scaleH=fScale;//=m_imageView.image.size.height/m_imageView.frame.size.height;
        
        int iPanWith=iRemoveRange/10+1;
        
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), iPanWith);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0, 0, 0, 0.0);
        CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeCopy);
        CGContextBeginPath(UIGraphicsGetCurrentContext());
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(),lastTouch.x*scaleW, lastTouch.y*scaleH);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentTouch.x*scaleW, currentTouch.y*scaleH);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        UIImage *retImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        m_imageView.image=retImage;
        [m_imageView setNeedsDisplay];
    
        lastTouch=currentTouch;

    }
    else if (panRecognizer.numberOfTouches==2)
    {
        CGPoint translation = [panRecognizer translationInView:self.view];
        CGPoint imageViewPosition = m_imageView.center;
        imageViewPosition.x += translation.x;
        imageViewPosition.y += translation.y;
        
        m_imageView.center = imageViewPosition;
        [panRecognizer setTranslation:CGPointZero inView:self.view];
    }
    
}

- (void)tapGesture:(UITapGestureRecognizer *)recognizer
{
    if (m_iMode!=REMOVE_BG)
    {
    //    [self drawRects];
       // m_imageView.image=[self imageByDrawingCircleOnImage:m_imageView.image];
        return;
    }
    CGPoint point = [recognizer locationInView:m_imageView];
    
    UIGraphicsBeginImageContext(m_imageView.bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [m_imageView.layer renderInContext:context];
    
    int bpr = (int)CGBitmapContextGetBytesPerRow(context);
    unsigned char * data = CGBitmapContextGetData(context);
    if (data != NULL)
    {
        int offset = bpr*round(point.y) + 4*round(point.x);
        int blue = data[offset+0];
        int green = data[offset+1];
        int red = data[offset+2];
        //       int alpha =  data[offset+3];
        
        // NSLog(@"%d %d %d %d", alpha, red, green, blue);
        
        m_imageView.image= [self maskImage:m_imageView.image setR:red setG:green setB:blue];
        [self changeImage];
        
    }
    
    UIGraphicsEndImageContext();
}

- (void)pinchDetected:(UIPinchGestureRecognizer *)pinchRecognizer
{
    CGFloat scale = pinchRecognizer.scale;
   // NSLog(@"f %f",scale);
    m_imageView.transform = CGAffineTransformScale(m_imageView.transform, scale, scale);
    fScale=scale*fScale;
    pinchRecognizer.scale = 1.0;
    
}

//
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    

    UITouch *touch = [touches anyObject];
    CGPoint currentLocation = [touch locationInView:m_imageView];
    
    lastTouch=currentLocation;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnFnPress:(UIButton *)sender
{
    //        UIColor *selectColor=[[UIColor alloc]initWithRed:255.0 green:255.0 blue:255.0 alpha:1.0];
    //        UIColor *noSelectColor=[[UIColor alloc]initWithRed:51.0 green:51.0 blue:51.0 alpha:1.0];
    //
    if (sender==btnPreImage)
    {
        [self preImage];
    }
    else if(sender==btnEraser)
    {
        [btnEraser setSelected:true];
        [btnRemoveBg setSelected:false];
        m_iMode=ERASER;
        lbSlider.text=@"範圍大小";
        
        
    }
    else if(sender==btnRemoveBg)
    {
        [btnEraser setSelected:false];
        [btnRemoveBg setSelected:true];
        m_iMode=REMOVE_BG;
        lbSlider.text=@"去背強度";
    }
}
- (IBAction)btnClosePress:(UIButton *)sender
{
    self.navigationController.navigationBarHidden=false;
    self.view.hidden=true;
}

- (IBAction)btnCheckPress:(UIButton *)sender
{

    [_delegate reImage:m_imageView.image];
    self.view.hidden=true;
}



- (IBAction)slider:(UISlider *)sender
{
    iRemoveRange=sender.value;
}

-(void) setImage:(UIImage *) image
{
    self.navigationController.navigationBarHidden=true;
    m_imageView.image=image;
    [self changeImage];
    
}


- (UIImage *)maskImage:(UIImage *)image setR:(float)r setG:(float)g setB:(float)b;
{
    
    const CGFloat colorMasking[6] = {r, r+iRemoveRange, g, g+iRemoveRange, b, b+iRemoveRange};
    CGImageRef sourceImage = image.CGImage;
    
    CGImageAlphaInfo info = CGImageGetAlphaInfo(sourceImage);
    if (info != kCGImageAlphaNone) {
        NSData *buffer = UIImageJPEGRepresentation(image, 1);
        UIImage *newImage = [UIImage imageWithData:buffer];
        sourceImage = newImage.CGImage;
    }
    
    CGImageRef masked = CGImageCreateWithMaskingColors(sourceImage, colorMasking);
    UIImage *retImage = [UIImage imageWithCGImage:masked];
    CGImageRelease(masked);
    return retImage;
}

-(void) changeImage
{
    if (listHistoryImage.count>20)
    {
        [listHistoryImage removeObjectAtIndex:1];
    }
    [listHistoryImage addObject:m_imageView.image];
}

-(void) preImage
{
    NSInteger index =listHistoryImage.count-2;
    if(index<0)
        index=0;
    
    m_imageView.image = [listHistoryImage objectAtIndex:index];
    
    if(index>1)
        [listHistoryImage removeLastObject ];
}

-(void)sendDataA:(NSString*)st
{
    
}

@end
