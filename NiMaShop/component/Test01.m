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
    
    oldImage=self.image.image;
    self.scrollview.delegate=self;
    self.image.contentMode=UIViewContentModeScaleAspectFill;
    
    
    
    
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
  

    self.image.image=image;
    oldImage=image;
    
    
}

- (IBAction)btnF0:(UIButton *)sender
{
    self.image.image=oldImage;
}

- (IBAction)btnF1:(UIButton *)sender
{
    NSLog(@"press");
    
    const CGFloat colorMasking[6] = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0};
    self.image.image = [UIImage imageWithCGImage: CGImageCreateWithMaskingColors(self.image.image.CGImage, colorMasking)];
    
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
    self.image.image = [UIImage imageWithCGImage: CGImageCreateWithMaskingColors(self.image.image.CGImage, colorMasking)];
}

- (IBAction)btnF3:(UIButton *)sender
{
    self.image.image=self.imageWithChromaKeyMasking;
}

- (IBAction)btnF4:(UIButton *)sender
{
    UIColor *color=[[UIColor alloc]initWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    self.image.image=[self replaceColor:color inImage:self.image.image withTolerance:0.3];
}

- (IBAction)btnF5:(UIButton *)sender
{
    CIImage *inputImg=[[CIImage alloc]initWithImage:self.image.image];
    // 將圖片套用黑白濾鏡
    CIFilter *filter = [CIFilter filterWithName:@"CIColorMonochrome"];
    [filter setDefaults];
    [filter setValue:inputImg forKey:kCIInputImageKey];
    [filter setValue:[CIColor colorWithRed:1 green:1 blue:1] forKey:@"inputColor"];
    // 取得套用濾鏡後的效果
    CIImage *outputImg = [filter outputImage];
    // 將照片轉為UIImage 格式
    CIContext *context = [CIContext contextWithOptions:nil];
    self.image.image = [UIImage imageWithCGImage: [context createCGImage:outputImg fromRect:outputImg.extent]];
}

- (UIImage *)imageWithChromaKeyMasking {
    const CGFloat colorMasking[6]={255.0,255.0,255.0,255.0,255.0,255.0};
    CGImageRef oldImage = self.image.image.CGImage;
    CGBitmapInfo oldInfo = CGImageGetBitmapInfo(oldImage);
    CGBitmapInfo newInfo = (oldInfo & (UINT32_MAX ^ kCGBitmapAlphaInfoMask)) | kCGImageAlphaNoneSkipLast;
    CGDataProviderRef provider = CGImageGetDataProvider(oldImage);
    CGImageRef newImage = CGImageCreate(self.image.frame.size.width,self.image.frame.size.height, CGImageGetBitsPerComponent(oldImage), CGImageGetBitsPerPixel(oldImage), CGImageGetBytesPerRow(oldImage), CGImageGetColorSpace(oldImage), newInfo, provider, NULL, false, kCGRenderingIntentDefault);
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
       UIColor *color= [self pixelColorInImage:self.image.image atX:0 atY:10];
   
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
    
    CIImage *inputImg=[[CIImage alloc]initWithImage:self.image.image];
    // 將圖片套用黑白濾鏡
    CIFilter *filter = [CIFilter filterWithName:filterMode];
    [filter setDefaults];
    [filter setValue:inputImg forKey:kCIInputImageKey];
    [filter setValue:[CIColor colorWithRed:1 green:1 blue:1] forKey:@"inputColor"];
    // 取得套用濾鏡後的效果
    CIImage *outputImg = [filter outputImage];
    // 將照片轉為UIImage 格式
    CIContext *context = [CIContext contextWithOptions:nil];
    self.image.image = [UIImage imageWithCGImage: [context createCGImage:outputImg fromRect:outputImg.extent]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





//
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    UITouch *touch = [[touches allObjects] objectAtIndex:0];
//    CGPoint point1 = [touch locationInView:self.view];
//    touch = [[event allTouches] anyObject];
//    NSLog(@"ABCCCCCC");
//    if ([touch view] == self.image)
//    {
//        CGPoint location = [touch locationInView:imgZoneWheel];
//        [self getPixelColorAtLocation:location];
//        if(alpha==255)
//        {
//            NSLog(@"In Image Touch view alpha %d",alpha);
//            [self translateCurrentTouchPoint:point1.x :point1.y];
//            [imgZoneWheel setImage:[UIImage imageNamed:[NSString stringWithFormat:@"blue%d.png",GrndFild]]];
//        }
//    }
//}

//
//
//- (UIColor*) getPixelColorAtLocation:(CGPoint)point
//{
//    
//    UIColor* color = nil;
//    
//    CGImageRef inImage;
//    
//    inImage = imgZoneWheel.image.CGImage;
//    
//    
//    // Create off screen bitmap context to draw the image into. Format ARGB is 4 bytes for each pixel: Alpa, Red, Green, Blue
//    CGContextRef cgctx = [self createARGBBitmapContextFromImage:inImage];
//    if (cgctx == NULL) { return nil; /* error */ }
//    
//    size_t w = CGImageGetWidth(inImage);
//    size_t h = CGImageGetHeight(inImage);
//    CGRect rect = {{0,0},{w,h}};
//    
//    
//    // Draw the image to the bitmap context. Once we draw, the memory
//    // allocated for the context for rendering will then contain the
//    // raw image data in the specified color space.
//    CGContextDrawImage(cgctx, rect, inImage);
//    
//    // Now we can get a pointer to the image data associated with the bitmap
//    // context.
//    unsigned char* data = CGBitmapContextGetData (cgctx);
//    if (data != NULL) {
//        //offset locates the pixel in the data from x,y.
//        //4 for 4 bytes of data per pixel, w is width of one row of data.
//        int offset = 4*((w*round(point.y))+round(point.x));
//        alpha =  data[offset];
//        int red = data[offset+1];
//        int green = data[offset+2];
//        int blue = data[offset+3];
//        color = [UIColor colorWithRed:(red/255.0f) green:(green/255.0f) blue:(blue/255.0f) alpha:(alpha/255.0f)];
//    }
//    
//    // When finished, release the context
//    //CGContextRelease(cgctx);
//    // Free image data memory for the context
//    if (data) { free(data); }
//    
//    return color;
//}
//
//- (CGContextRef) createARGBBitmapContextFromImage:(CGImageRef)inImage
//{
//    CGContextRef    context = NULL;
//    CGColorSpaceRef colorSpace;
//    void *          bitmapData;
//    int             bitmapByteCount;
//    int             bitmapBytesPerRow;
//    
//    // Get image width, height. We'll use the entire image.
//    size_t pixelsWide = CGImageGetWidth(inImage);
//    size_t pixelsHigh = CGImageGetHeight(inImage);
//    
//    // Declare the number of bytes per row. Each pixel in the bitmap in this
//    // example is represented by 4 bytes; 8 bits each of red, green, blue, and
//    // alpha.
//    bitmapBytesPerRow   = (pixelsWide * 4);
//    bitmapByteCount     = (bitmapBytesPerRow * pixelsHigh);
//    
//    // Use the generic RGB color space.
//    colorSpace = CGColorSpaceCreateDeviceRGB();
//    
//    if (colorSpace == NULL)
//    {
//        fprintf(stderr, "Error allocating color space\n");
//        return NULL;
//    }
//    
//    // Allocate memory for image data. This is the destination in memory
//    // where any drawing to the bitmap context will be rendered.
//    bitmapData = malloc( bitmapByteCount );
//    if (bitmapData == NULL)
//    {
//        fprintf (stderr, "Memory not allocated!");
//        CGColorSpaceRelease( colorSpace );
//        return NULL;
//    }
//    
//    // Create the bitmap context. We want pre-multiplied ARGB, 8-bits
//    // per component. Regardless of what the source image format is
//    // (CMYK, Grayscale, and so on) it will be converted over to the format
//    // specified here by CGBitmapContextCreate.
//    context = CGBitmapContextCreate (bitmapData,
//                                     pixelsWide,
//                                     pixelsHigh,
//                                     8,      // bits per component
//                                     bitmapBytesPerRow,
//                                     colorSpace,
//                                     kCGImageAlphaPremultipliedFirst);
//    if (context == NULL)
//    {
//        free (bitmapData);
//        fprintf (stderr, "Context not created!");
//    }
//    
//    // Make sure and release colorspace before returning
//    CGColorSpaceRelease( colorSpace );
//    
//    return context;
//}

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


@end
