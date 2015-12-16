//
//  ViewController.m
//  NiMaShop
//
//  Created by 陳晁偉 on 2015/11/24.
//  Copyright © 2015年 RogerChen. All rights reserved.
//

#import "ViewController.h"




@interface ViewController ()

@end

@implementation ViewController

+ (void) initialize
{
    //[Global ini];
    NSLog(@"ViewController initialize");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    

}



//View 要被呈現前，發生於 viewDidLoad 之後：
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
}

//View 呈現後，發生於 viewWillAppear 之後：
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear");
}

//View 要結束前，要切換到下一個 View 時會發生此事件：
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear");
}

//View 完全結束後，發生於 viewWillDisappear 之後：
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"viewDidDisappear");
}




//實作用:返回上一頁
- (IBAction)returnToFirstPage:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

//實作用:下一頁傳值
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    // NextStageXXXX *view = [segue destinationViewController];
    //[view fn:value];
}














@end
