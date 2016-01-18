//
//  StoreCore.m
//  NiMaShop
//
//  Created by 陳晁偉 on 2015/12/11.
//  Copyright © 2015年 RogerChen. All rights reserved.
//

#import "StoreCore.h"



@interface StoreCore ()
@property (nonatomic, strong) ItemStickView *selectedView;
@end

@implementation StoreCore

- (void)viewDidLoad {
    [super viewDidLoad];
    
    viewShare.hidden=true;
    
    listDataProviderCollection=[[NSMutableArray alloc] init];
    dClothColor=[[NSMutableArray alloc] init];
    dClothView=[[NSMutableArray alloc]init];
    dTheme=[[NSMutableArray alloc]init];
    listBtn=[[NSMutableArray alloc]init];
 
    [self setClothing];
    
    viewImage.hidden=true;
    
    viewImage.userInteractionEnabled=true;
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
    tapRecognizer.numberOfTapsRequired = 1;
    [viewImage addGestureRecognizer:tapRecognizer];

    
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{

    
    viewImage.hidden=false;
    

}

- (void)tapDetected:(UITapGestureRecognizer *)tapRecognizer
{
    self.selectedView=nil;
}

- (CGSize) getImageSizeAfterAspectFit:(UIImageView *) imageView
{
    float widthRatio = imageView.bounds.size.width / imageView.image.size.width;
    float heightRatio = imageView.bounds.size.height / imageView.image.size. height; float scale = MIN(widthRatio,heightRatio);
    float imageWidth = scale * imageView.image.size.width;
    float imageHeight = scale * imageView.image.size.height;
    return CGSizeMake(imageWidth,imageHeight);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setClothing
{
    iThemeIdx=0;
    
    iColorIdx=0;
    _collectionView.hidden=true;
    //
    
    //衣服樣式是固定的
    NSMutableArray *arr;
    arr=[[NSMutableArray alloc]init];
    
    [arr addObject:[UIImage imageNamed:@"icon_clothes1a"]];
    [arr addObject:[UIImage imageNamed:@"icon_clothes1b"]];
    [arr addObject:[UIImage imageNamed:@"icon_clothes2a"]];
    [arr addObject:[UIImage imageNamed:@"icon_clothes2b"]];
    [arr addObject:[UIImage imageNamed:@"icon_clothes3a"]];
    [arr addObject:[UIImage imageNamed:@"icon_clothes3b"]];
    [arr addObject:[UIImage imageNamed:@"icon_clothes3c"]];
    [arr addObject:[UIImage imageNamed:@"icon_clothes4a"]];
    [arr addObject:[UIImage imageNamed:@"icon_clothes4b"]];
    [arr addObject:[UIImage imageNamed:@"icon_clothes5a"]];
    [dTheme addObject:arr];
    [btnCloth setRestorationIdentifier:@"theme0"];
    [btnCloth addTarget:self action:@selector(btnGrounpClick:) forControlEvents: UIControlEventTouchUpInside];
   // [btnCloth.imageView setFrame:CGRectMake(0, 0, 58  , 58)];
    [listBtn addObject:btnCloth];
    
    
    arr=[[NSMutableArray alloc]init];
    [arr addObject:[UIImage imageNamed:@"clothing1a_1"]];
    [arr addObject:[UIImage imageNamed:@"clothing1a_2"]];
    [arr addObject:[UIImage imageNamed:@"clothing1a_3"]];
    [dClothView addObject:arr];
    
    arr=[[NSMutableArray alloc]init];
    [arr addObject:[UIImage imageNamed:@"clothing1b_1"]];
    [arr addObject:[UIImage imageNamed:@"clothing1b_2"]];
    [dClothView addObject:arr];
    
    arr=[[NSMutableArray alloc]init];
    [arr addObject:[UIImage imageNamed:@"clothing2a_3"]];
    [arr addObject:[UIImage imageNamed:@"clothing2a_4"]];
    [dClothView addObject:arr];
    
    arr=[[NSMutableArray alloc]init];
    [arr addObject:[UIImage imageNamed:@"clothing2b_3"]];
    [arr addObject:[UIImage imageNamed:@"clothing2b_4"]];
    [dClothView addObject:arr];
    
    arr=[[NSMutableArray alloc]init];
    [arr addObject:[UIImage imageNamed:@"clothing3a_1"]];
    [arr addObject:[UIImage imageNamed:@"clothing3a_2"]];
    [arr addObject:[UIImage imageNamed:@"clothing3a_3"]];
    [dClothView addObject:arr];
    
    arr=[[NSMutableArray alloc]init];
    [arr addObject:[UIImage imageNamed:@"clothing3b_1"]];
    [arr addObject:[UIImage imageNamed:@"clothing3b_2"]];
    [arr addObject:[UIImage imageNamed:@"clothing3b_3"]];
    [dClothView addObject:arr];
    
    arr=[[NSMutableArray alloc]init];
    [arr addObject:[UIImage imageNamed:@"clothing3c_1"]];
    [arr addObject:[UIImage imageNamed:@"clothing3c_2"]];
    [arr addObject:[UIImage imageNamed:@"clothing3c_3"]];
    [dClothView addObject:arr];
    
    arr=[[NSMutableArray alloc]init];
    [arr addObject:[UIImage imageNamed:@"clothing4a_1"]];
    [arr addObject:[UIImage imageNamed:@"clothing4a_2"]];
    [arr addObject:[UIImage imageNamed:@"clothing4a_3"]];
    [dClothView addObject:arr];
    
    arr=[[NSMutableArray alloc]init];
    [arr addObject:[UIImage imageNamed:@"clothing4b_1"]];
    [arr addObject:[UIImage imageNamed:@"clothing4b_2"]];
    [arr addObject:[UIImage imageNamed:@"clothing4b_3"]];
    [dClothView addObject:arr];
    
    arr=[[NSMutableArray alloc]init];
    [arr addObject:[UIImage imageNamed:@"clothing5a_1"]];
    [dClothView addObject:arr];
    
    
    //color
    arr=[[NSMutableArray alloc]init];
    [arr addObject:[UIImage imageNamed:@"cloth_color_1_1"]];
    [arr addObject:[UIImage imageNamed:@"cloth_color_2_1"]];
    [arr addObject:[UIImage imageNamed:@"cloth_color_3_1"]];
    [dClothColor addObject:arr];
    
    arr=[[NSMutableArray alloc]init];
    [arr addObject:[UIImage imageNamed:@"cloth_color_1_1"]];
    [arr addObject:[UIImage imageNamed:@"cloth_color_2_1"]];
    [dClothColor addObject:arr];
    
    arr=[[NSMutableArray alloc]init];
    [arr addObject:[UIImage imageNamed:@"cloth_color_3_1"]];
    [arr addObject:[UIImage imageNamed:@"cloth_color_4_1"]];
    [dClothColor addObject:arr];
    
    arr=[[NSMutableArray alloc]init];
    [arr addObject:[UIImage imageNamed:@"cloth_color_3_1"]];
    [arr addObject:[UIImage imageNamed:@"cloth_color_4_1"]];
    [dClothColor addObject:arr];
    
    arr=[[NSMutableArray alloc]init];
    [arr addObject:[UIImage imageNamed:@"cloth_color_1_1"]];
    [arr addObject:[UIImage imageNamed:@"cloth_color_2_1"]];
    [arr addObject:[UIImage imageNamed:@"cloth_color_3_1"]];
    [dClothColor addObject:arr];
    
    arr=[[NSMutableArray alloc]init];
    [arr addObject:[UIImage imageNamed:@"cloth_color_1_1"]];
    [arr addObject:[UIImage imageNamed:@"cloth_color_2_1"]];
    [arr addObject:[UIImage imageNamed:@"cloth_color_3_1"]];
    [dClothColor addObject:arr];
    
    arr=[[NSMutableArray alloc]init];
    [arr addObject:[UIImage imageNamed:@"cloth_color_1_1"]];
    [arr addObject:[UIImage imageNamed:@"cloth_color_2_1"]];
    [arr addObject:[UIImage imageNamed:@"cloth_color_3_1"]];
    [dClothColor addObject:arr];
    
    arr=[[NSMutableArray alloc]init];
    [arr addObject:[UIImage imageNamed:@"cloth_color_1_1"]];
    [arr addObject:[UIImage imageNamed:@"cloth_color_2_1"]];
    [arr addObject:[UIImage imageNamed:@"cloth_color_3_1"]];
    [dClothColor addObject:arr];
    
    arr=[[NSMutableArray alloc]init];
    [arr addObject:[UIImage imageNamed:@"cloth_color_1_1"]];
    [arr addObject:[UIImage imageNamed:@"cloth_color_2_1"]];
    [arr addObject:[UIImage imageNamed:@"cloth_color_3_1"]];
    [dClothColor addObject:arr];
    
    arr=[[NSMutableArray alloc]init];
    [arr addObject:[UIImage imageNamed:@"cloth_color_1_1"]];
    [dClothColor addObject:arr];
    
    listDataProviderCollection=[dTheme objectAtIndex:0];

    
}

-(void) addTheme:(UIImage*)image count:(int)iNums;
{
    
    int iBtnW=56;
    int iBtnH=56;
    int iSpace=5;
    
    NSMutableArray *arr0=[[NSMutableArray alloc]init];
    for(int i=0;i<iNums;i++)
    {
        [arr0 addObject:[Global sticker:image atIndex:i]];
    }
    
    [dTheme addObject:arr0];
    
    UIButton *btnTheme=[[UIButton alloc]initWithFrame:CGRectMake((scrollBtnGroup.subviews.count-2)*(iBtnW+iSpace),0,iBtnW,iBtnH)];

    [btnTheme setImage:[[dTheme objectAtIndex:dTheme.count-1] objectAtIndex:0]    forState:UIControlStateNormal];
    [btnTheme addTarget:self action:@selector(btnGrounpClick:) forControlEvents:UIControlEventTouchUpInside];
    [btnTheme setBackgroundColor:[UIColor whiteColor]];
    [listBtn addObject:btnTheme];
    [scrollBtnGroup addSubview:btnTheme];
    [scrollBtnGroup setContentSize:CGSizeMake((scrollBtnGroup.subviews.count-2)*(iBtnW+iSpace), 0)];
    
}


-(void) addBtn:(NSString*)imageName;
{
    int iBtnW=56;
    int iBtnH=56;
    int iSpace=5;
    UIButton *btnTheme=[[UIButton alloc]initWithFrame:CGRectMake((scrollBtnGroup.subviews.count-2)*(iBtnW+iSpace),0,iBtnW,iBtnH)];
    UIImage *btnImage = [UIImage imageNamed:imageName];
    [btnTheme setImage:btnImage forState:UIControlStateNormal];
    [btnTheme addTarget:self action:@selector(btnGrounpClick:) forControlEvents:UIControlEventTouchUpInside];
    [btnTheme setBackgroundColor:[UIColor whiteColor]];
    [listBtn addObject:btnTheme];
    
    [scrollBtnGroup addSubview:btnTheme];

    [scrollBtnGroup setContentSize:CGSizeMake((scrollBtnGroup.subviews.count-2)*(iBtnW+iSpace), 0)];
    
}




#pragma mark - UIScrollViewDelegate

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


//共幾個cell
-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return listDataProviderCollection.count;//[array count];
}


//建立cell時， “Cell” 對應storybook的identifier
-(UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ItemCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    if(cell==nil)
    {
        cell=[[ItemCell alloc]init];
    }
    
    cell.imageView.image=[listDataProviderCollection objectAtIndex:indexPath.row];
    return cell;
}


-(void)btnGrounpClick:(UIButton*)sender
{
    bool bIsShowCell=true;
    if (sender==[listBtn objectAtIndex:0])
    {
        listDataProviderCollection=[dTheme objectAtIndex:0];
        iThemeIdx=0;
        [_collectionView reloadData];
    }
    else
    {
        bIsShowCell=[self virtualBtnGruopClick:sender];
    }
    
    if (!bIsShowCell)
    {
        _collectionView.hidden=true;
        return;
    }
    //animation
    _collectionView.hidden=false;
    
    CGRect endRect=_collectionView.frame;
    
    CGRect startRect=endRect;
    
    startRect.origin.y=self.view.frame.size.height;
    
    _collectionView.frame=startRect;
    
    [UIView animateWithDuration:0.3 animations:^
     {
         _collectionView.frame=endRect;
     }];
    
    
    
}

//didSelect
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ItemCell *cell = (ItemCell *)[collectionView cellForItemAtIndexPath:indexPath];
    iCellIdx=(int)indexPath.row;
    _collectionView.hidden=true;
    if (iThemeIdx==0)
    {
        viewImage.image=[[dClothView objectAtIndex:iCellIdx] objectAtIndex:0];
        
        btnColor2.hidden=[[dClothView objectAtIndex:iCellIdx]count]<3;
        
        btnColor1.hidden=[[dClothView objectAtIndex:iCellIdx]count]<2;
        
        btnColor0.imageView.image=[[dClothColor objectAtIndex:0]objectAtIndex:0];
        
        if (!btnColor0.isHidden)
            btnColor0.imageView.image=[[dClothColor objectAtIndex:iCellIdx]objectAtIndex:0];
        
        if (!btnColor1.isHidden &&  [[dClothColor objectAtIndex:iCellIdx]count]>1)
            btnColor1.imageView.image=[[dClothColor objectAtIndex:iCellIdx]objectAtIndex:1];
        
        if (!btnColor2.isHidden &&  [[dClothColor objectAtIndex:iCellIdx]count]>2)
            btnColor2.imageView.image=[[dClothColor objectAtIndex:iCellIdx]objectAtIndex:2];
        
    }
    
    else
    {
        
        [self virtualCellClick:cell.imageView];
    }
    
}


- (void)setSelectedView:(ItemStickView *)selectedView
{

    if (_selectedView != selectedView)
    {
        if (_selectedView)
        {
            _selectedView.showEditingHandlers = NO;
        }
        _selectedView = selectedView;
        if (_selectedView)
        {
            _selectedView.showEditingHandlers = YES;
            [_selectedView.superview bringSubviewToFront:_selectedView];
        }
    }
}


- (void)stickerViewDidBeginMoving:(ItemStickView *)stickerView
{
    self.selectedView = stickerView;
}


- (void)stickerViewDidTap:(ItemStickView *)stickerView
{
    self.selectedView = stickerView;
}




- (IBAction)btnNextPress:(UIButton *)sender
{
    [self.view bringSubviewToFront:viewShare];
    viewShare.hidden=false;
}


- (IBAction)btnCancelPress:(UIButton *)sender
{
    viewShare.hidden=true;
}



- (IBAction)btnColorPress:(UIButton *)sender
{
    if (sender==btnColor2)
    {
        iColorIdx=2;
    }
    else if(sender==btnColor1)
    {
        iColorIdx=1;
    }
    else
        iColorIdx=0;
    
    if ([[dClothColor objectAtIndex:iCellIdx] count]>iColorIdx)
        viewImage.image=[[dClothView objectAtIndex:iCellIdx]objectAtIndex:iColorIdx];
}




-(bool) virtualBtnGruopClick:(UIButton*)sender;
{

    return true;
}


-(void) virtualCellClick:(UIImageView*) imageView
{

}
@end
