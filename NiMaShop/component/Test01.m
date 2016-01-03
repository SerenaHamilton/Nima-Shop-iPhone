//
//  Test01.m
//  NiMaShop
//
//  Created by 陳晁偉 on 2015/12/2.
//  Copyright © 2015年 RogerChen. All rights reserved.
//




#import "Test01.h"

@interface Test01 ()

@end

@implementation Test01

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    oldImage=self.imageView.image;
    self.scrollview.delegate=self;
    self.imageView.contentMode=UIViewContentModeScaleAspectFill;
    
    
    
    self.imageView.userInteractionEnabled = YES;
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panDetected:)];
    [self.imageView addGestureRecognizer:panRecognizer];
    
//    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchDetected:)];
//    [self.imageView addGestureRecognizer:pinchRecognizer];
//    
//    UIRotationGestureRecognizer *rotationRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationDetected:)];
//    [self.imageView addGestureRecognizer:rotationRecognizer];
//    
//    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
//    tapRecognizer.numberOfTapsRequired = 2;
//    [self.imageView addGestureRecognizer:tapRecognizer];
    
}

- (void)panDetected:(UIPanGestureRecognizer *)panRecognizer
{
    
    CGPoint translation = [panRecognizer translationInView:self.view];
    CGPoint imageViewPosition = self.imageView.center;
    
    NSLog(@"loc : %f ,%f",translation.x,translation.y);
    
//    imageViewPosition.x += translation.x;
//    imageViewPosition.y += translation.y;
//    
//    self.imageView.center = imageViewPosition;
//    [panRecognizer setTranslation:CGPointZero inView:self.view];
}

- (void)pinchDetected:(UIPinchGestureRecognizer *)pinchRecognizer
{
    CGFloat scale = pinchRecognizer.scale;
    self.imageView.transform = CGAffineTransformScale(self.imageView.transform, scale, scale);
    pinchRecognizer.scale = 1.0;
}

- (void)rotationDetected:(UIRotationGestureRecognizer *)rotationRecognizer
{
    CGFloat angle = rotationRecognizer.rotation;
    self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, angle);
    rotationRecognizer.rotation = 0.0;
}

- (void)tapDetected:(UITapGestureRecognizer *)tapRecognizer
{
    [UIView animateWithDuration:0.25 animations:^{
        self.imageView.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
        self.imageView.transform = CGAffineTransformIdentity;
    }];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return [scrollView.subviews objectAtIndex:0];
}
- (IBAction)btnSelect:(UIButton *)sender
{
    UIPopoverPresentationController *popover;
    UIImagePickerController *imagePicker = [UIImagePickerController new];
    // 設定相片的來源為行動裝置內的相本
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    // 設定顯示模式為 popover
    imagePicker.modalPresentationStyle = UIModalPresentationPopover;
    popover = imagePicker.popoverPresentationController;
    // 設定 popover 視窗與哪一個 view 元件有關連
    popover.sourceView = sender;
    // 以下兩行處理 popover 的箭頭位置
    popover.sourceRect = sender.bounds;
    popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
    [self presentViewController:imagePicker animated:YES completion:nil];
    
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *image=[info valueForKey:UIImagePickerControllerOriginalImage];
   // UIImageView *imageView=[[UIImageView alloc] initWithImage:image];
    [self dismissViewControllerAnimated:YES completion:nil];
  

    self.imageView.image=image;
    oldImage=image;
    
    
}

- (IBAction)btnF0:(UIButton *)sender
{
    self.imageView.image=oldImage;
}

- (IBAction)btnF1:(UIButton *)sender
{
    NSLog(@"press");
    
    const CGFloat colorMasking[6] = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0};
    self.imageView.image = [UIImage imageWithCGImage: CGImageCreateWithMaskingColors(self.imageView.image.CGImage, colorMasking)];
    
    if(SYSTEM_VERSION_GREATER_THAN(@"7.2"))
    {
        NSLog(@"AAAA");
    }
    else
    {
        NSLog(@"BBB");
    }
    
    
}


- (IBAction)btnF2:(UIButton *)sender
{
    const CGFloat colorMasking[6] = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0};
    self.imageView.image = [UIImage imageWithCGImage: CGImageCreateWithMaskingColors(self.imageView.image.CGImage, colorMasking)];
}

- (IBAction)btnF3:(UIButton *)sender
{
    self.imageView.image=self.imageWithChromaKeyMasking;
}

- (IBAction)btnF4:(UIButton *)sender
{
    
    UIColor *color=[[UIColor alloc]initWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    self.imageView.image=[self replaceColor:color inImage:self.imageView.image withTolerance:0.3];
}

- (IBAction)btnF5:(UIButton *)sender
{
    CIImage *inputImg=[[CIImage alloc]initWithImage:self.imageView.image];
    // 將圖片套用黑白濾鏡
    CIFilter *filter = [CIFilter filterWithName:@"CIColorMonochrome"];
    [filter setDefaults];
    [filter setValue:inputImg forKey:kCIInputImageKey];
    [filter setValue:[CIColor colorWithRed:1 green:1 blue:1] forKey:@"inputColor"];
    // 取得套用濾鏡後的效果
    CIImage *outputImg = [filter outputImage];
    // 將照片轉為UIImage 格式
    CIContext *context = [CIContext contextWithOptions:nil];
    self.imageView.image = [UIImage imageWithCGImage: [context createCGImage:outputImg fromRect:outputImg.extent]];
}

- (UIImage *)imageWithChromaKeyMasking {
    const CGFloat colorMasking[6]={255.0,255.0,255.0,255.0,255.0,255.0};
    CGImageRef oldImage = self.imageView.image.CGImage;
    CGBitmapInfo oldInfo = CGImageGetBitmapInfo(oldImage);
    CGBitmapInfo newInfo = (oldInfo & (UINT32_MAX ^ kCGBitmapAlphaInfoMask)) | kCGImageAlphaNoneSkipLast;
    CGDataProviderRef provider = CGImageGetDataProvider(oldImage);
    CGImageRef newImage = CGImageCreate(self.imageView.frame.size.width,self.imageView.frame.size.height, CGImageGetBitsPerComponent(oldImage), CGImageGetBitsPerPixel(oldImage), CGImageGetBytesPerRow(oldImage), CGImageGetColorSpace(oldImage), newInfo, provider, NULL, false, kCGRenderingIntentDefault);
    CGDataProviderRelease(provider); provider = NULL;
    CGImageRef im = CGImageCreateWithMaskingColors(newImage, colorMasking);
    UIImage *ret = [UIImage imageWithCGImage:im];
    CGImageRelease(im);
    return ret;
}

- (UIImage*) replaceColor:(UIColor*)color inImage:(UIImage*)image withTolerance:(float)tolerance {
    CGImageRef imageRef = [image CGImage];
    
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    NSUInteger bitmapByteCount = bytesPerRow * height;
    
    unsigned char *rawData = (unsigned char*) calloc(bitmapByteCount, sizeof(unsigned char));
    
    CGContextRef context = CGBitmapContextCreate(rawData, width, height,
                                                 bitsPerComponent, bytesPerRow, colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    
    CGColorRef cgColor = [color CGColor];
    const CGFloat *components = CGColorGetComponents(cgColor);
    float r = components[0];
    float g = components[1];
    float b = components[2];
    //float a = components[3]; // not needed
    
    r = r * 255.0;
    g = g * 255.0;
    b = b * 255.0;
    
    const float redRange[2] = {
        MAX(r - (tolerance / 2.0), 0.0),
        MIN(r + (tolerance / 2.0), 255.0)
    };
    
    const float greenRange[2] = {
        MAX(g - (tolerance / 2.0), 0.0),
        MIN(g + (tolerance / 2.0), 255.0)
    };
    
    const float blueRange[2] = {
        MAX(b - (tolerance / 2.0), 0.0),
        MIN(b + (tolerance / 2.0), 255.0)
    };
    
    int byteIndex = 0;
    
    while (byteIndex < bitmapByteCount) {
        unsigned char red   = rawData[byteIndex];
        unsigned char green = rawData[byteIndex + 1];
        unsigned char blue  = rawData[byteIndex + 2];
        
        if (((red >= redRange[0]) && (red <= redRange[1])) &&
            ((green >= greenRange[0]) && (green <= greenRange[1])) &&
            ((blue >= blueRange[0]) && (blue <= blueRange[1]))) {
            // make the pixel transparent
            //
            rawData[byteIndex] = 0;
            rawData[byteIndex + 1] = 0;
            rawData[byteIndex + 2] = 0;
            rawData[byteIndex + 3] = 0;
        }
        
        byteIndex += 4;
    }
    
    CGImageRef imgref = CGBitmapContextCreateImage(context);
    UIImage *result = [UIImage imageWithCGImage:imgref];
    
    CGImageRelease(imgref);
    CGContextRelease(context);
    free(rawData);
    
    return result;
}

- (IBAction)btnFnPress:(UIButton *)sender
{
    NSString *sFnName=_txtFnName.text;
    NSString *sFnValue=_txtFnValue.text;
    
    if ([sFnName isEqual:@"fn0"])
    {
        [self filter:sFnValue];
    }
    else if([sFnName isEqualToString:@"fn1"])
    {
       UIColor *color= [self pixelColorInImage:self.imageView.image atX:0 atY:10];
   
    }
    
}


-(void) filter:(NSString*) filterMode
{
    NSLog(@"%@", [CIFilter filterNamesInCategory:kCICategoryBuiltIn]);
   // NSLog(@"%@", [[CIFilter filterWithName:@"CIColorControls"] attributes]);
    
    if ([filterMode isEqualToString:@""])
    {
        filterMode=@"CIColorMonochrome";
    }
    
    CIImage *inputImg=[[CIImage alloc]initWithImage:self.imageView.image];
    // 將圖片套用黑白濾鏡
    CIFilter *filter = [CIFilter filterWithName:filterMode];
    [filter setDefaults];
    [filter setValue:inputImg forKey:kCIInputImageKey];
    [filter setValue:[CIColor colorWithRed:1 green:1 blue:1] forKey:@"inputColor"];
    // 取得套用濾鏡後的效果
    CIImage *outputImg = [filter outputImage];
    // 將照片轉為UIImage 格式
    CIContext *context = [CIContext contextWithOptions:nil];
    self.imageView.image = [UIImage imageWithCGImage: [context createCGImage:outputImg fromRect:outputImg.extent]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





- (UIColor*)pixelColorInImage:(UIImage*)image atX:(int)x atY:(int)y
{
    
    CFDataRef pixelData = CGDataProviderCopyData(CGImageGetDataProvider(image.CGImage));
    const UInt8* data = CFDataGetBytePtr(pixelData);
    
    int pixelInfo = ((image.size.width  * y) + x ) * 4; // 4 bytes per pixel
    
    UInt8 red   = data[pixelInfo + 0];
    UInt8 green = data[pixelInfo + 1];
    UInt8 blue  = data[pixelInfo + 2];
    UInt8 alpha = data[pixelInfo + 3];
    CFRelease(pixelData);
    
    return [UIColor colorWithRed:red/255.0f
                           green:green/255.0f
                            blue:blue/255.0f
                           alpha:alpha/255.0f];
}


//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    
//    
//    UITouch *touch = [touches anyObject];
//    CGPoint location = [touch locationInView:self.view];
//    
//    
//    NSLog(@"loc : %f  ,  %f ",location.x,location.y);
//    
//    //self.image.image = [self eraseImageAtPoint:location inImageView:self.image  fromEraser:eraserImg];
//    
//    
//    
//}
//
//
//
//- (UIImage *)eraseImageAtPoint: (CGPoint)point inImageView: (UIImageView *)imgView fromEraser: (UIImage *)eraser
//{
//    UIGraphicsBeginImageContext(imgView.frame.size);
//    
//   // [self drawInRect:CGRectMake(0, 0, imgView.frame.size.width, imgView.frame.size.height)];
//    
//    [eraser drawAtPoint:point blendMode:kCGBlendModeDestinationOut alpha:1.0];
//    
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    return image;
//    
//}



@end
