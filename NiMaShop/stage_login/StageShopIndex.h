//
//  StageShopIndex.h
//  NiMaShop
//
//  Created by 陳晁偉 on 2015/11/26.
//  Copyright © 2015年 RogerChen. All rights reserved.
//

#import "StageSlideBase.h"

@interface StageShopIndex : StageSlideBase<UIScrollViewDelegate>
{
    CGFloat imageW,imageH;
    NSMutableArray *listPickerData;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageCtrl;
@property (weak, nonatomic) IBOutlet UIButton *btnStore;
@property (weak, nonatomic) IBOutlet UIButton *btnFreeCreat;
@end
