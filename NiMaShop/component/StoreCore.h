//
//  StoreCore.h
//  NiMaShop
//
//  Created by 陳晁偉 on 2015/12/11.
//  Copyright © 2015年 RogerChen. All rights reserved.
//


#import "StageSlideBase.h"
#import "ItemCell.h"
#import "ItemStickView.h"



@interface StoreCore : StageSlideBase <UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,ItemStickViewDelegate>
{

    IBOutlet UIImageView *viewImage;

    __weak IBOutlet UIButton *btnCloth;
    __weak IBOutlet UIScrollView *scrollBtnGroup;
    
    __weak IBOutlet UIButton *btnColor0;
    
    __weak IBOutlet UIButton *btnColor1;
    
    __weak IBOutlet UIButton *btnColor2;
    
    __weak IBOutlet UIView *viewShare;
    int iColorIdx;
    int iCellIdx;
    int iThemeIdx;


    NSMutableArray *dClothView;
    NSMutableArray *dClothColor;
    NSMutableArray *dTheme;
    NSMutableArray *listDataProviderCollection;
    
    NSMutableArray *listBtn;
   // NSMutableArray *dTheme;
}


@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

- (void)tapDetected:(UITapGestureRecognizer *)tapRecognizer;

-(void) setClothing;

-(void) addTheme:(UIImage*)image count:(int)iNums;

-(void) addBtn:(NSString*)imageName;

-(void) btnGrounpClick:(UIButton*)sender;
//return 布林代表按下該按扭要不要顯示cell
-(BOOL) virtualBtnGruopClick:(UIButton*)sender;

-(void) virtualCellClick:(UIImageView*)imageView;

- (void)setSelectedView:(ItemStickView *)selectedView;
@end