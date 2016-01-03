//
//  LayerRemoveBackground.m
//  NiMaShop
//
//  Created by 陳晁偉 on 2015/12/18.
//  Copyright © 2015年 RogerChen. All rights reserved.
//

#import "LayerRemoveBackground.h"

@interface LayerRemoveBackground ()

@end

@implementation LayerRemoveBackground

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    listHistoryImage=[[NSMutableArray alloc]init];
    
    UIImage *image= [UIImage imageNamed:@"close"];
    
    m_imageView=[[UIImageView alloc]initWithImage:image];
    
    m_imageView.image=image;
    
    m_imageView.contentMode=UIViewContentModeScaleAspectFill;
    
     iRemoveRange=0;
    
    [self.scrollView addSubview:m_imageView];
    
    UITapGestureRecognizer * tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    [m_imageView addGestureRecognizer:tapRecognizer];
    m_imageView.userInteractionEnabled = YES;
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panDetected:)];
    [m_imageView addGestureRecognizer:panRecognizer];
    
   
    
    
}

- (void)panDetected:(UIPanGestureRecognizer *)panRecognizer
{
    CGPoint translation = [panRecognizer translationInView:self.view];
    CGPoint imageViewPosition = m_imageView.center;
    imageViewPosition.x += translation.x;
    imageViewPosition.y += translation.y;
    
    m_imageView.center = imageViewPosition;
    [panRecognizer setTranslation:CGPointZero inView:self.view];
}

- (void)tapGesture:(UITapGestureRecognizer *)recognizer
{
    CGPoint point = [recognizer locationInView:m_imageView];
    
    UIGraphicsBeginImageContext(m_imageView.bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [m_imageView.layer renderInContext:context];
    
    int bpr = CGBitmapContextGetBytesPerRow(context);
    unsigned char * data = CGBitmapContextGetData(context);
    if (data != NULL)
    {
        int offset = bpr*round(point.y) + 4*round(point.x);
        int blue = data[offset+0];
        int green = data[offset+1];
        int red = data[offset+2];
        int alpha =  data[offset+3];
        
        NSLog(@"%d %d %d %d", alpha, red, green, blue);
        
        m_imageView.image= [self maskImage:m_imageView.image setR:red setG:green setB:blue];
        [self changeImage];
        
    }
    
    UIGraphicsEndImageContext();
}


-(void)viewDidAppear:(BOOL)animated
{
    UIImageView *imageView = [self.scrollView.subviews firstObject];
    // 將 imageView 大小調整為跟 scrollView 一樣
    imageView.frame = self.scrollView.bounds;
    // 取得圖片縮小後的長寬
    CGSize size = [Global getImageSizeAfterAspectFit:imageView];
    // 將 imageView 的大小調整為圖片大小
    imageView.frame = CGRectMake(0,0,size.width,size.height);
    // 將 scrollView 的容器大小調整為 imageView 大小
    self.scrollView.contentSize = imageView.frame.size;
    
}

-(nullable UIView *)viewForZoomingInScrollView:(nonnull UIScrollView *) scrollView
{
    //return [self.scrollView.subviews firstObject];
    return m_imageView;
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
        NSLog(@"AAAAA");
        [btnEraser setSelected:true];
        [btnRemoveBg setSelected:false];
        
//        [lbEraser setTextColor:selectColor];
//        [lbRemoveBg setTextColor:noSelectColor];
     

        
    }
    else if(sender==btnRemoveBg)
    {
        NSLog(@"bbbb");
        [btnEraser setSelected:false];
        [btnRemoveBg setSelected:true];

//        [lbEraser setTextColor:noSelectColor];
//        [lbRemoveBg setTextColor:selectColor];
    }
}
- (IBAction)btnClosePress:(UIButton *)sender
{
    self.navigationController.navigationBarHidden=false;
    self.view.hidden=true;
}
- (IBAction)slider:(UISlider *)sender
{
    iRemoveRange=sender.value;
    NSLog(@"%d",iRemoveRange);
}

-(void) setImage:(UIImage *) image
{
    self.navigationController.navigationBarHidden=true;
    m_imageView.image=image;
    [self changeImage];
    
}

-(UIImage*) returnImage
{
    return m_imageView.image;
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
        [listHistoryImage removeObjectAtIndex:0];
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

@end
