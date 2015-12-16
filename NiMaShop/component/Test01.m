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

- (IBAction)btnPress:(UIButton *)sender
{
    self.image.image=oldImage;
}

- (IBAction)btnTran:(UIButton *)sender
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
//           NSLog(@"AAAA");
//    const CGFloat colorMasking[6] = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0};
//    self.image.image = [UIImage imageWithCGImage: CGImageCreateWithMaskingColors(self.image.image.CGImage, colorMasking)];
//       }
//       else
//       {
//           NSLog(@"BBBB");
//           self.image.image=[self imageWithChromaKeyMasking];
//       }
    
}


- (IBAction)btnTranIcon:(UIButton *)sender
{
    const CGFloat colorMasking[6] = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0};
    self.image.image = [UIImage imageWithCGImage: CGImageCreateWithMaskingColors(self.image.image.CGImage, colorMasking)];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
