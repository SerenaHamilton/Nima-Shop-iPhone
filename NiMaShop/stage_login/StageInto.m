//
//  StageInto.m
//  NiMaShop
//
//  Created by 陳晁偉 on 2015/11/25.
//  Copyright © 2015年 RogerChen. All rights reserved.
//

#import "StageInto.h"

@interface StageInto ()
{
    CGFloat imageW, imageH;
}

@end

@implementation StageInto

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    

    [self.btnRegist.layer setCornerRadius:15.0];
    [self.btnLogin.layer setCornerRadius:15.0];
    [self.btnRegist setTitle:[Global tr:@"btnRegist"] forState:UIControlStateNormal];
     [self.btnLogin setTitle:[Global tr:@"btnLogin"] forState:UIControlStateNormal];


    _viewLogo.layer.cornerRadius = 5.0; // 圓角的弧度
    _viewLogo.layer.masksToBounds = YES;
    
    _viewLogo.layer.shadowColor = [[UIColor blackColor] CGColor];
    _viewLogo.layer.shadowOffset = CGSizeMake(3.0f, 3.0f); // [水平偏移, 垂直偏移]
    _viewLogo.layer.shadowOpacity = 0.2f; // 0.0 ~ 1.0 的值
    _viewLogo.layer.shadowRadius = 10.0f; // 陰影發散的程度
    
    
    
}

-(void) viewDidLayoutSubviews
{
    
    //UIScrollView設定
    [self.scrollView setPagingEnabled:YES];
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.scrollView setShowsVerticalScrollIndicator:NO];
    [self.scrollView setScrollsToTop:NO];
    [self.scrollView setDelegate:self];
    
    imageW = self.scrollView.bounds.size.width;
    imageH = self.scrollView.bounds.size.height;
    [self.scrollView setContentSize:CGSizeMake(imageW * 5, 0)];
    
    NSMutableArray *listImage=[NSMutableArray new];
    [listImage addObject:@"seco0"];
    [listImage addObject:@"seco1"];
    [listImage addObject:@"seco2"];
    
    //製作ScrollView的內容
    for (int i=0; i<listImage.count; i++)
    {
        CGRect frame = CGRectMake(imageW*i, -64, imageW, imageH);
        
        UIImageView *view=[[UIImageView alloc]initWithImage:[UIImage imageNamed:[listImage objectAtIndex:i]]];
        
        [view setFrame:frame];
        [self.scrollView addSubview:view];

    }
    
    
    
    
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

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    
    NSInteger currentPage = ((self.scrollView.contentOffset.x - imageW / 2) / imageW) + 1;
    
    [self.pageCtrl setCurrentPage:currentPage];
}




@end
