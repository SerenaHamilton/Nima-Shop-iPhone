//
//  StageFree.h
//  NiMaShop
//
//  Created by 陳晁偉 on 2015/11/27.
//  Copyright © 2015年 RogerChen. All rights reserved.
//

#import "StoreCore.h"
#import "LayerRemoveBackground.h"

@interface StageFree : StoreCore<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    ItemStickView *stickerView;
    UIImage *imageNowEdit;
    LayerRemoveBackground *m_layerRm;
}
-(void)editRemoveBackground;
@end


