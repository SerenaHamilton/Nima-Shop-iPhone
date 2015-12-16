//
//  ItemStickView.h
//  NiMaShop
//
//  Created by 陳晁偉 on 2015/12/9.
//  Copyright © 2015年 RogerChen. All rights reserved.
//

#import <UIKit/UIKit.h>


#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, ItemStickViewHandler) {
   HandlerClose,
    HandlerRotate,
    HandlerFlip
};

typedef NS_ENUM (NSInteger, ItemStickViewPosition) {
    PositionTopLeft,
    PositionTopRight,
    PositionBottomLeft,
    PositionBottomRight
};

@class ItemStickView;

@protocol ItemStickViewDelegate <NSObject>
@optional
- (void)stickerViewDidBeginMoving:(ItemStickView *)stickerView;
- (void)stickerViewDidChangeMoving:(ItemStickView *)stickerView;
- (void)stickerViewDidEndMoving:(ItemStickView *)stickerView;
- (void)stickerViewDidBeginRotating:(ItemStickView *)stickerView;
- (void)stickerViewDidChangeRotating:(ItemStickView *)stickerView;
- (void)stickerViewDidEndRotating:(ItemStickView *)stickerView;
- (void)stickerViewDidClose:(ItemStickView *)stickerView;
- (void)stickerViewDidTap:(ItemStickView *)stickerView;
@end

@interface ItemStickView : UIView
@property (nonatomic, weak) id <ItemStickViewDelegate> delegate;
/// The contentView inside the sticker view.
@property (nonatomic, strong, readonly) UIImageView *contentView;
/// Enable the close handler or not. Default value is YES.
@property (nonatomic, assign) BOOL enableClose;
/// Enable the rotate/resize handler or not. Default value is YES.
@property (nonatomic, assign) BOOL enableRotate;
/// Enable the flip handler or not. Default value is YES.
@property (nonatomic, assign) BOOL enableFlip;
/// Show close and rotate/resize handlers or not. Default value is YES.
@property (nonatomic, assign) BOOL showEditingHandlers;
/// Minimum value for the shorter side while resizing. Default value will be used if not set.
@property (nonatomic, assign) NSInteger minimumSize;
/// Color of the outline border. Default: brown color.
@property (nonatomic, strong) UIColor *outlineBorderColor;
/// A convenient property for you to store extra information.
@property (nonatomic, strong) NSDictionary *userInfo;

/**
 *  Initialize a sticker view. This is the designated initializer.
 *
 *  @param contentView The contentView inside the sticker view.
 *                     You can access it via the `contentView` property.
 *
 *  @return The sticker view.
 */
- (id)initWithContentView:(UIImageView *)contentView;

/**
 *  Use image to customize each editing handler.
 *  It is your responsibility to set image for every editing handler.
 *
 *  @param image   The image to be used.
 *  @param handler The editing handler.
 */
- (void)setImage:(UIImage *)image forHandler:(ItemStickViewHandler)handler;

/**
 *  Customize each editing handler's position.
 *  If not set, default position will be used.
 *  @note  It is your responsibility not to set duplicated position.
 *
 *  @param position The position for the handler.
 *  @param handler  The editing handler.
 */
- (void)setPosition:(ItemStickViewPosition)position forHandler:(ItemStickViewHandler)handler;

/**
 *  Customize handler's size
 *
 *  @param size Handler's size
 */
- (void)setHandlerSize:(NSInteger)size;
@end
