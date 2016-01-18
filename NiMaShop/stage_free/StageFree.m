//
//  StageFree.m
//  NiMaShop
//
//  Created by 陳晁偉 on 2015/11/27.
//  Copyright © 2015年 RogerChen. All rights reserved.
//

#import "StageFree.h"

@interface StageFree ()

@end

@implementation StageFree

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addBtn:@"icon_cam"];
    [self addBtn:@"icon_eraser"];
    [self addBtn:@"icon_temp"];
    [self addBtn:@"icon_text"];
    [self addBtn:@"icon_stamp"];
    
    m_layerRm= [[LayerRemoveBackground alloc]init];
    
    m_layerRm.delegate=self;
    
    [self.view addSubview:m_layerRm.view];
    
    m_layerRm.view.hidden=true;
    
    fScale=1.0;
    
    imageNowEdit=nil;
    
    [viewTempStyleArea setHidden:true];
    
    editImageView= [[UIImageView alloc]init];
    
    // editImageView.image=[UIImage imageNamed:@""]
    
    editImageView.contentMode=UIViewContentModeScaleAspectFill;
    
    
    [scrollEditArea addSubview: editImageView];
    
    
#if 1  //試看哪一種縮放、移動圖片的寫法比較適合
    scrollEditArea.delegate=self;
    editImageView.userInteractionEnabled=NO;
#else
    editImageView.userInteractionEnabled=YES;
#endif
    UITapGestureRecognizer * tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    [editImageView addGestureRecognizer:tapRecognizer];
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panDetected:)];
    [editImageView addGestureRecognizer:panRecognizer];
    
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchDetected:)];
    [editImageView addGestureRecognizer:pinchRecognizer];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(BOOL) virtualBtnGruopClick:(UIButton *)sender
{
    
    [viewTempStyleArea setHidden:true];
    
    if (sender==[listBtn objectAtIndex:1])
        [self buttonPress:sender];
    else if (sender==[listBtn objectAtIndex:2])
        [self editRemoveBackground];
    else if(sender==[listBtn objectAtIndex:3])
        [viewTempStyleArea setHidden:false];
    return false;
}

-(void) virtualCellClick:(UIImageView*)imageView
{
    
}



- (IBAction)buttonPress:(UIButton *)sender
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
    
    imageNowEdit=[info valueForKey:UIImagePickerControllerOriginalImage];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    editImageView.image=imageNowEdit;
    
    UIImageView *imageView=[scrollEditArea.subviews firstObject];
    imageView.frame=scrollEditArea.bounds;
    CGSize size=[Global getImageSizeAfterAspectFit:imageView];
    imageView.frame=CGRectMake(0, 0, size.width, size.height);
    scrollEditArea.contentSize=CGSizeMake(size.width*1.8, size.height*2);
    
}

-(nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return [scrollView.subviews firstObject];
}

-(void)editRemoveBackground;
{
    
    
    if (imageNowEdit==nil)
    {
        return;
    }
    
    [m_layerRm setImage:imageNowEdit];
    
    [self.view bringSubviewToFront:m_layerRm.view];
    
    // self.navigationController.navigationBar.hidden=true;
    m_layerRm.view.hidden=false;
}


- (void)reImage:(UIImage *)image
{
    imageNowEdit=image;
    editImageView.image =imageNowEdit ;
}

- (IBAction)btnTempStylePress:(UIButton *)sender
{
    CGFloat fSize=borderView.frame.size.width;
    if (borderView.frame.size.height<borderView.frame.size.width)
        fSize=borderView.frame.size.height;
    fSize+=10;
    CALayer *mask = [CALayer layer];
    mask.frame =CGRectMake((borderView.frame.size.width-fSize)/2, (borderView.frame.size.height-fSize)/2, fSize,fSize);
    borderView.layer.masksToBounds = YES;
    
    if (sender.tag==0)
    {
        editImageView.image=imageNowEdit;
        borderView.layer.mask =nil;
        
    }
    
    else if (sender.tag==1)
    {
        mask.contents = (id)[[UIImage imageNamed:@"temp_style2"] CGImage];
        borderView.layer.mask = mask;
    }
    
    else if(sender.tag==2)
    {
        mask.contents = (id)[[UIImage imageNamed:@"temp_style3"] CGImage];
        borderView.layer.mask = mask;
        
    }
    else if(sender.tag==3)
    {
        mask.contents = (id)[[UIImage imageNamed:@"temp_style4"] CGImage];
        borderView.layer.mask = mask;
    }
    
    [viewTempStyleArea setHidden:true];
    
}



- (UIImage*) maskImage:(UIImage *)image withMask:(UIImage *)maskImage {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGImageRef maskImageRef = [maskImage CGImage];
    
    // create a bitmap graphics context the size of the image
    CGContextRef mainViewContentContext = CGBitmapContextCreate (NULL, maskImage.size.width, maskImage.size.height, 8, 0, colorSpace, kCGImageAlphaPremultipliedLast);
    CGColorSpaceRelease(colorSpace);
    
    if (mainViewContentContext==NULL)
        return NULL;
    
    CGFloat ratio = 0;
    
    ratio = maskImage.size.width/ image.size.width;
    
    if(ratio * image.size.height < maskImage.size.height) {
        ratio = maskImage.size.height/ image.size.height;
    }
    
    CGRect rect1  = {{0, 0}, {maskImage.size.width, maskImage.size.height}};
    CGRect rect2  = {{-((image.size.width*ratio)-maskImage.size.width)/2 , -((image.size.height*ratio)-maskImage.size.height)/2}, {image.size.width*ratio, image.size.height*ratio}};
    
    
    CGContextClipToMask(mainViewContentContext, rect1, maskImageRef);
    CGContextDrawImage(mainViewContentContext, rect2, image.CGImage);
    
    
    // Create CGImageRef of the main view bitmap content, and then
    // release that bitmap context
    CGImageRef newImage = CGBitmapContextCreateImage(mainViewContentContext);
    CGContextRelease(mainViewContentContext);
    
    UIImage *theImage = [UIImage imageWithCGImage:newImage];
    
    CGImageRelease(newImage);
    
    // return the image
    return theImage;
}

- (void)tapGesture:(UITapGestureRecognizer *)recognizer
{
    if(recognizer.numberOfTouches!=2)
        return;
    [UIView animateWithDuration:0.25 animations:^{
        //        editImageView.center = CGPointMake(CGRectGetMidX(editImageView.bounds), CGRectGetMidY(editImageView.bounds));
        editImageView.center=CGPointMake(editImageView.bounds.size.width/2, editImageView.bounds.size.height/2);
        editImageView.transform = CGAffineTransformIdentity;
    }];
}

- (void)panDetected:(UIPanGestureRecognizer *)panRecognizer
{
    
    //位移變化量
    CGPoint translation = [panRecognizer translationInView:editImageView];
    
    //當前第一根手指的位置
    //CGPoint point=[panRecognizer locationOfTouch:1 inView:editImageView];
    
    CGPoint imageViewPosition = editImageView.center;

    imageViewPosition.x += translation.x;
    imageViewPosition.y += translation.y;
    
    editImageView.center = imageViewPosition;
    
    [panRecognizer setTranslation:CGPointZero inView:editImageView.superview];
}

- (void)pinchDetected:(UIPinchGestureRecognizer *)pinchRecognizer
{
    CGFloat scale = pinchRecognizer.scale;
    
    
    
    editImageView.transform = CGAffineTransformScale(editImageView.transform, scale, scale);
    
    fScale=scale;
    
    float fW=editImageView.bounds.size.width/editImageView.image.size.width;
    
    float fH=editImageView.bounds.size.height/editImageView.image.size.height;
    
    float tempf=MIN(fW, fH);
    
    scrollEditArea.contentSize=CGSizeMake(tempf*editImageView.image.size.width, tempf*editImageView.image.size.height);
    
    pinchRecognizer.scale = 1.0;
    

}


@end
