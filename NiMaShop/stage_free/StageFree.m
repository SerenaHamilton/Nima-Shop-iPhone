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
    
    [self.view addSubview:m_layerRm.view];
    
    m_layerRm.view.hidden=true;
    
    imageNowEdit=nil;
    UIImageView *imageView=[[UIImageView alloc]init];
    imageView.contentMode=UIViewContentModeScaleAspectFit;
    stickerView = [[ItemStickView alloc] initWithContentView:imageView];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) virtualBtnGruopClick:(UIButton *)sender
{
    if (sender==[listBtn objectAtIndex:1])
        [self buttonPress:sender];
    else if (sender==[listBtn objectAtIndex:2])
        [self editRemoveBackground];
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
  //  UIImageView *imageView=[[UIImageView alloc] initWithImage:imageNowEdit];
   //
    [self dismissViewControllerAnimated:YES completion:nil];
    stickerView.contentView.image =imageNowEdit ;
    stickerView.center = self.view.center;
    stickerView.delegate = self;
    stickerView.outlineBorderColor = [UIColor blueColor];
    [stickerView setImage:[UIImage imageNamed:@"close"] forHandler:HandlerClose];
    [stickerView setImage:[UIImage imageNamed:@"rotate"] forHandler:HandlerRotate];
    [stickerView setImage:[UIImage imageNamed:@"flip"] forHandler:HandlerFlip];
    [stickerView setHandlerSize:35];
    stickerView.frame=CGRectMake((self.view.frame.size.width-300)/2, 100, 300, 300);
    
    [self.view addSubview:stickerView];
    
    self.selectedView = stickerView;
    
    
}

-(void)editRemoveBackground;
{
    
  //  [stickerView setShowEditingHandlers:false];
//    super.selectedView=nil;
    
    if (imageNowEdit==nil)
    {
        return;
    }
    
    [m_layerRm setImage:imageNowEdit];
    
    [self.view bringSubviewToFront:m_layerRm.view];
    
   // self.navigationController.navigationBar.hidden=true;
    m_layerRm.view.hidden=false;
}

@end
