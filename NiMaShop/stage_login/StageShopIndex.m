//
//  StageShopIndex.m
//  NiMaShop
//
//  Created by 陳晁偉 on 2015/11/26.
//  Copyright © 2015年 RogerChen. All rights reserved.
//

#import "StageShopIndex.h"

@interface StageShopIndex ()

@end

@implementation StageShopIndex

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.btnStore.layer setCornerRadius:15.0];
    [self.btnFreeCreat.layer setCornerRadius:15.0];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear");
    
    
    //UIPageControl設定
    [self.pageCtrl setNumberOfPages:5];
    [self.pageCtrl setCurrentPage:0];
    
    //UIScrollView設定
    [self.scrollView setPagingEnabled:YES];
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.scrollView setShowsVerticalScrollIndicator:NO];
    [self.scrollView setScrollsToTop:NO];
    [self.scrollView setDelegate:self];
    
    imageW = self.scrollView.bounds.size.width;
    imageH = self.scrollView.frame.size.height;
    [self.scrollView setContentSize:CGSizeMake(imageW * 5, imageH)];
    
    
    
    //製作ScrollView的內容
    for (int i=0; i!=self.pageCtrl.numberOfPages; i++)
    {
        CGRect frame = CGRectMake(imageW*i, 0, imageW, imageH);
        UIView *view = [[UIView alloc]initWithFrame:frame];
        
        CGFloat r, g ,b;
        r = (arc4random() % 10) / 10.0;
        g = (arc4random() % 10) / 10.0;
        b = (arc4random() % 10) / 10.0;
        [view setBackgroundColor:[UIColor colorWithRed:r green:g blue:b alpha:0.3]];
        
        //使用QuartzCore.framework替UIView加上圓角
        [view.layer setCornerRadius:15.0];
        
        [self.scrollView addSubview:view];
    }
    
    
}


- (IBAction)btnPressFree:(UIButton *)sender
{

    UIViewController *nextView;
    
    nextView =[self.storyboard instantiateViewControllerWithIdentifier:@"StageFree"];
    
    [self showViewController:nextView sender:self];
    
}

- (IBAction)btnPressStore:(UIButton *)sender
{
    
    UIViewController *nextView;
    
    nextView =[self.storyboard instantiateViewControllerWithIdentifier:@"StageStore"];
    
    [self showViewController:nextView sender:self];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    
    NSInteger currentPage = ((self.scrollView.contentOffset.x - imageW / 2) / imageW) + 1;
    
    [self.pageCtrl setCurrentPage:currentPage];
}

@end
