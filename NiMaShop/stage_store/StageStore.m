//
//  StageStore.m
//  NiMaShop
//
//  Created by 陳晁偉 on 2015/11/27.
//  Copyright © 2015年 RogerChen. All rights reserved.
//

#import "StageStore.h"

@interface StageStore ()

@end

@implementation StageStore

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //
    UIImage *imageTheme1=[UIImage imageNamed:@"18sticker1"];
    //UIImage *image=[WebService urlImage:@"http://image.wangchao.net.cn/baike/1256135629539.jpg"];
    [self addTheme:imageTheme1 count:16];
    
    UIImage *imageTheme2=[UIImage imageNamed:@"09sticker2"];
    [self addTheme:imageTheme2 count:9];
    
    UIImage *imageTheme3=[UIImage imageNamed:@"18sticker3"];
    [self addTheme:imageTheme3 count:18];
    
    
    [self addTheme:imageTheme1 count:16];

    [self addTheme:imageTheme2 count:9];

    [self addTheme:imageTheme3 count:18];
    
    
}

-(BOOL) virtualBtnGruopClick:(UIButton *)sender
{
    
    iThemeIdx=(int)[listBtn indexOfObject:sender];
    
    listDataProviderCollection=[dTheme objectAtIndex:iThemeIdx];
    
    [self.collectionView reloadData];
    
    return true;
}

-(void) virtualCellClick:(UIImageView*)imageView
{
    UIImage *image=imageView.image;
    UIImageView *testView=[[UIImageView alloc] initWithImage:image];
    ItemStickView *stickerView = [[ItemStickView alloc] initWithContentView:testView];
    stickerView.center = self.view.center;
    stickerView.delegate = self;
    stickerView.outlineBorderColor = [UIColor blueColor];
    [stickerView setImage:[UIImage imageNamed:@"close"] forHandler:HandlerClose];
    [stickerView setImage:[UIImage imageNamed:@"rotate"] forHandler:HandlerRotate];
    [stickerView setImage:[UIImage imageNamed:@"flip"] forHandler:HandlerFlip];
    [stickerView setHandlerSize:35];
    stickerView.frame=CGRectMake((self.view.frame.size.width-200)/2, 200, 200, 200);
    
    [self.view addSubview:stickerView];
    
    self.selectedView = stickerView;
}




@end
