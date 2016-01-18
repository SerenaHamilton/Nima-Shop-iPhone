//
//  StageLogin.m
//  NiMaShop
//
//  Created by 陳晁偉 on 2015/11/24.
//  Copyright © 2015年 RogerChen. All rights reserved.
//

#import "StageStart.h"


@implementation StageStart

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.lbLanguage.text=[Global tr:@"language"];
    listPickerData=[[NSMutableArray alloc]init];
    [listPickerData addObject:@"English"];
    [listPickerData addObject:@"繁體中文"];
    [listPickerData addObject:@"简体中文"];
    [listPickerData addObject:@"日本語"];
    
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
    

    for (int i=0; i<listImage.count; i++)
    {
        CGRect frame = CGRectMake(imageW*i, -64, imageW, imageH);
        
        UIImageView *view=[[UIImageView alloc]initWithImage:[UIImage imageNamed:[listImage objectAtIndex:i]]];
        view.contentMode=UIViewContentModeScaleAspectFill;
        [view setFrame:frame];
        [self.scrollView addSubview:view];
        
    }
    
}

+ (void) initialize
{
    [Global ini];
    NSLog(@"ViewController initialize");
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear");
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnNextPress:(UIButton *)sender
{
    [self toNextStage];
}

-(void) toNextStage
{
       
    UIViewController *nextView;
    if ([FBSDKAccessToken currentAccessToken])
    {
        nextView =[self.storyboard instantiateViewControllerWithIdentifier:@"StageCheckUser"];
    }
    else
    {
        nextView =[self.storyboard instantiateViewControllerWithIdentifier:@"StageInto"];
    }
    
    
    [self.navigationController pushViewController:nextView animated:true];
}




//picker view

//override   source data 使用幾個輪
-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

//override  pickerView delegate 該輪上呈現幾筆資料
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    if(component==0)
    {
        return [listPickerData count];
    }
    
    return 0;
}

//override pickView delegate 呈現的資料
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(component==0)
    {
        return [listPickerData objectAtIndex:row];
    }
    return nil;
}

//override pickView delegate 選擇項目時
-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
 
    [Global changeLanguage:(int)row];

    self.lbLanguage.text=[Global tr:@"language"];

    [self toNextStage];
}


@end
