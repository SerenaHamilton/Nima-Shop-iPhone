//
//  TestStickViewController.m
//  NiMaShop
//
//  Created by 陳晁偉 on 2015/12/9.
//  Copyright © 2015年 RogerChen. All rights reserved.
//

#import "TestStickViewController.h"

@interface TestStickViewController ()
@property (nonatomic, strong) ItemStickView *selectedView;
@end

@implementation TestStickViewController

- (void)setSelectedView:(ItemStickView *)selectedView {
    if (_selectedView != selectedView) {
        if (_selectedView) {
            _selectedView.showEditingHandlers = NO;
        }
        _selectedView = selectedView;
        if (_selectedView) {
            _selectedView.showEditingHandlers = YES;
            [_selectedView.superview bringSubviewToFront:_selectedView];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    UIImageView *testView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"seco0"]];
    
    ItemStickView *stickerView = [[ItemStickView alloc] initWithContentView:testView];
    stickerView.center = self.view.center;
    stickerView.delegate = self;
    stickerView.outlineBorderColor = [UIColor blueColor];
    [stickerView setImage:[UIImage imageNamed:@"close"] forHandler:HandlerClose];
    [stickerView setImage:[UIImage imageNamed:@"rotate"] forHandler:HandlerRotate];
    [stickerView setImage:[UIImage imageNamed:@"flip"] forHandler:HandlerFlip];
    [stickerView setHandlerSize:40];
    
    
    stickerView.frame=CGRectMake(10, 10, 300, 300);
    

    
    [self.view addSubview:stickerView];

    self.selectedView = stickerView;
}

- (void)stickerViewDidBeginMoving:(ItemStickView *)stickerView
{
    self.selectedView = stickerView;
}

- (void)stickerViewDidTap:(ItemStickView *)stickerView
{
    self.selectedView = stickerView;
}

@end
