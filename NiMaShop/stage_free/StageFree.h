//
//  StageFree.h
//  NiMaShop
//
//  Created by 陳晁偉 on 2015/11/27.
//  Copyright © 2015年 RogerChen. All rights reserved.
//

#import "StoreCore.h"
#import "LayerRemoveBackground.h"

@interface StageFree : StoreCore<UINavigationControllerDelegate,UIImagePickerControllerDelegate,LayerRemoveBgDelegate>
{
    UIImageView *editImageView;
    UIImage *imageNowEdit;
    
    float fScale;
    
    
    IBOutlet UIView *borderView;
    IBOutlet UIScrollView *scrollEditArea;
    LayerRemoveBackground *m_layerRm;
    IBOutlet UIView *viewTempStyleArea;
}
-(void)editRemoveBackground;

- (UIImage*) maskImage:(UIImage *)image withMask:(UIImage *)maskImage;


@end


