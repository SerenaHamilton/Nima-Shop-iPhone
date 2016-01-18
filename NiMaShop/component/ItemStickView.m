//
//  ItemStickView.m
//  NiMaShop
//
//  Created by 陳晁偉 on 2015/12/9.
//  Copyright © 2015年 RogerChen. All rights reserved.
//


//simple:
//1. class viewcontroller Refencing outlets <ItemStickViewDelegate>
//2. @property (nonatomic, strong) ItemStickView *selectedView;
//3. 
//
//- (void)setSelectedView:(ItemStickView *)selectedView {
//    if (_selectedView != selectedView) {
//        if (_selectedView) {
//            _selectedView.showEditingHandlers = NO;
//        }
//        _selectedView = selectedView;
//        if (_selectedView) {
//            _selectedView.showEditingHandlers = YES;
//            [_selectedView.superview bringSubviewToFront:_selectedView];
//        }
//    }
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 100)];
//    testView.backgroundColor = [UIColor redColor];
//    
//    ItemStickView *stickerView = [[ItemStickView alloc] initWithContentView:testView];
//    stickerView.center = self.view.center;
//    stickerView.delegate = self;
//    stickerView.outlineBorderColor = [UIColor blueColor];
//    [stickerView setImage:[UIImage imageNamed:@"Close"] forHandler:HandlerClose];
//    [stickerView setImage:[UIImage imageNamed:@"Rotate"] forHandler:HandlerRotate];
//    [stickerView setImage:[UIImage imageNamed:@"Flip"] forHandler:HandlerFlip];
//    [stickerView setHandlerSize:40];
//    [self.view addSubview:stickerView];
//    
//    UILabel *testLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
//    testLabel.text = @"Test Label";
//    testLabel.textAlignment = NSTextAlignmentCenter;
//    
//    ItemStickView *stickerView2 = [[ItemStickView alloc] initWithContentView:testLabel];
//    stickerView2.center = CGPointMake(100, 100);
//    stickerView2.delegate = self;
//    [stickerView2 setImage:[UIImage imageNamed:@"Close"] forHandler:HandlerClose];
//    [stickerView2 setImage:[UIImage imageNamed:@"Rotate"] forHandler:HandlerRotate];
//    stickerView2.showEditingHandlers = NO;
//    [self.view addSubview:stickerView2];
//    
//    self.selectedView = stickerView;
//}
//
//- (void)stickerViewDidBeginMoving:(ItemStickView *)stickerView {
//    self.selectedView = stickerView;
//}
//
//- (void)stickerViewDidTap:(ItemStickView *)stickerView {
//    self.selectedView = stickerView;
//}








#import "ItemStickView.h"


CG_INLINE CGPoint CGRectGetCenter(CGRect rect)
{
    return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}

CG_INLINE CGRect CGRectScale(CGRect rect, CGFloat wScale, CGFloat hScale)
{
    return CGRectMake(rect.origin.x, rect.origin.y, rect.size.width * wScale, rect.size.height * hScale);
}

CG_INLINE CGFloat CGAffineTransformGetAngle(CGAffineTransform t)
{
    return atan2(t.b, t.a);
}

CG_INLINE CGFloat CGPointGetDistance(CGPoint point1, CGPoint point2)
{
    CGFloat fx = (point2.x - point1.x);
    CGFloat fy = (point2.y - point1.y);
    return sqrt((fx * fx + fy * fy));
}

@interface ItemStickView () <UIGestureRecognizerDelegate>
{
    /**
     *  Default value
     */
    NSInteger defaultInset;
    NSInteger defaultMinimumSize;
    
    /**
     *  Variables for moving view
     */
    CGPoint beginningPoint;
    CGPoint beginningCenter;
    
    /**
     *  Variables for rotating and resizing view
     */
    CGRect initialBounds;
    CGFloat initialDistance;
    CGFloat deltaAngle;
}

@property (nonatomic, strong, readwrite) UIImageView *contentView;
@property (nonatomic, strong) UIPanGestureRecognizer *moveGesture;
@property (nonatomic, strong) UIImageView *rotateImageView;
@property (nonatomic, strong) UIPanGestureRecognizer *rotateGesture;
@property (nonatomic, strong) UIImageView *closeImageView;
@property (nonatomic, strong) UITapGestureRecognizer *closeGesture;
@property (nonatomic, strong) UIImageView *flipImageView;
@property (nonatomic, strong) UITapGestureRecognizer *flipGesture;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@end

@implementation ItemStickView

#pragma mark - Properties

- (UIPanGestureRecognizer *)moveGesture
{
    if (!_moveGesture)
    {
        _moveGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleMoveGesture:)];
    }
    return _moveGesture;
}

- (UIPanGestureRecognizer *)rotateGesture
{
    if (!_rotateGesture)
    {
        _rotateGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotateGesture:)];
        _rotateGesture.delegate = self;
    }
    return _rotateGesture;
}

- (UITapGestureRecognizer *)closeGesture
{
    if (!_closeGesture)
    {
        _closeGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleCloseGesture:)];
        _closeGesture.delegate = self;
    }
    return _closeGesture;
}

- (UITapGestureRecognizer *)flipGesture
{
    if (!_flipGesture)
    {
        _flipGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleFlipGesture:)];
        _flipGesture.delegate = self;
    }
    return _flipGesture;
}

- (UITapGestureRecognizer *)tapGesture
{
    if (!_tapGesture)
    {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    }
    return _tapGesture;
}

- (UIImageView *)closeImageView
{
    if (!_closeImageView)
    {
        _closeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, defaultInset * 2, defaultInset * 2)];
        _closeImageView.contentMode = UIViewContentModeScaleAspectFit;
        _closeImageView.backgroundColor = [UIColor clearColor];
        _closeImageView.userInteractionEnabled = YES;
        [_closeImageView addGestureRecognizer:self.closeGesture];
    }
    return _closeImageView;
}

- (UIImageView *)rotateImageView
{
    if (!_rotateImageView)
    {
        _rotateImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, defaultInset * 2, defaultInset * 2)];
        _rotateImageView.contentMode = UIViewContentModeScaleAspectFit;
        _rotateImageView.backgroundColor = [UIColor clearColor];
        _rotateImageView.userInteractionEnabled = YES;
        [_rotateImageView addGestureRecognizer:self.rotateGesture];
    }
    return _rotateImageView;
}

- (UIImageView *)flipImageView
{
    if (!_flipImageView)
    {
        _flipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, defaultInset * 2, defaultInset * 2)];
        _flipImageView.contentMode = UIViewContentModeScaleAspectFit;
        _flipImageView.backgroundColor = [UIColor clearColor];
        _flipImageView.userInteractionEnabled = YES;
        [_flipImageView addGestureRecognizer:self.flipGesture];
    }
    return _flipImageView;
}

- (void)setEnableClose:(BOOL)enableClose
{
    _enableClose = enableClose;
    if (self.showEditingHandlers)
    {
        [self _setEnableClose:enableClose];
    }
}

- (void)setEnableRotate:(BOOL)enableRotate
{
    _enableRotate = enableRotate;
    if (self.showEditingHandlers)
    {
        [self _setEnableRotate:enableRotate];
    }
}

- (void)setShowEditingHandlers:(BOOL)showEditingHandlers
{
    _showEditingHandlers = showEditingHandlers;
    if (showEditingHandlers)
    {
        [self _setEnableClose:self.enableClose];
        [self _setEnableRotate:self.enableRotate];
        [self _setEnableFlip:self.enableFlip];
        self.contentView.layer.borderWidth = 2;
    }
    else
    {
        [self _setEnableClose:NO];
        [self _setEnableRotate:NO];
        [self _setEnableFlip:NO];
        self.contentView.layer.borderWidth = 0;
    }
}

- (void)setMinimumSize:(NSInteger)minimumSize
{
    _minimumSize = MAX(minimumSize, defaultMinimumSize);
}

- (void)setOutlineBorderColor:(UIColor *)outlineBorderColor
{
    _outlineBorderColor = outlineBorderColor;
    self.contentView.layer.borderColor = _outlineBorderColor.CGColor;
}

#pragma mark - Private Methods

- (void)_setEnableClose:(BOOL)enableClose
{
    self.closeImageView.hidden = !enableClose;
    self.closeImageView.userInteractionEnabled = enableClose;
}

- (void)_setEnableRotate:(BOOL)enableRotate
{
    self.rotateImageView.hidden = !enableRotate;
    self.rotateImageView.userInteractionEnabled = enableRotate;
}

- (void)_setEnableFlip:(BOOL)enableFlip
{
    self.flipImageView.hidden = !enableFlip;
    self.flipImageView.userInteractionEnabled = enableFlip;
}

#pragma mark - UIView

- (id)initWithContentView:(UIImageView *)contentView
{
    if (!contentView)
    {
        return nil;
    }
    
    defaultInset = 11;
    defaultMinimumSize = 4 * defaultInset;
    
    CGRect frame = contentView.frame;
    frame = CGRectMake(0, 0, frame.size.width + defaultInset * 2, frame.size.height + defaultInset * 2);
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
        [self addGestureRecognizer:self.moveGesture];
        [self addGestureRecognizer:self.tapGesture];
        
        // Setup content view
        self.contentView = contentView;
        self.contentView.center = CGRectGetCenter(self.bounds);
        self.contentView.userInteractionEnabled = NO;
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        if ([self.contentView.layer respondsToSelector:@selector(setAllowsEdgeAntialiasing:)])
        {
            [self.contentView.layer setAllowsEdgeAntialiasing:YES];
        }
        [self addSubview:self.contentView];
        
        // Setup editing handlers
        [self setPosition:PositionTopLeft forHandler:HandlerClose];
        [self addSubview:self.closeImageView];
        [self setPosition:PositionTopRight forHandler:HandlerRotate];
        [self addSubview:self.rotateImageView];
        [self setPosition:PositionBottomLeft forHandler:    HandlerFlip];
        [self addSubview:self.flipImageView];
        
        self.showEditingHandlers = YES;
        self.enableClose = YES;
        self.enableRotate = YES;
        self.enableFlip = YES;
        
        self.minimumSize = defaultMinimumSize;
        self.outlineBorderColor = [UIColor brownColor];
    }
    return self;
}

#pragma mark - Gesture Handlers

- (void)handleMoveGesture:(UIPanGestureRecognizer *)recognizer
{
    CGPoint touchLocation = [recognizer locationInView:self.superview];
    
    switch (recognizer.state)
    {
        case UIGestureRecognizerStateBegan:
            beginningPoint = touchLocation;
            beginningCenter = self.center;
            if ([self.delegate respondsToSelector:@selector(stickerViewDidBeginMoving:)])
            {
                [self.delegate stickerViewDidBeginMoving:self];
            }
            break;
            
        case UIGestureRecognizerStateChanged:
            self.center = CGPointMake(beginningCenter.x + (touchLocation.x - beginningPoint.x),
                                      beginningCenter.y + (touchLocation.y - beginningPoint.y));
            if ([self.delegate respondsToSelector:@selector(stickerViewDidChangeMoving:)])
            {
                [self.delegate stickerViewDidChangeMoving:self];
            }
            break;
            
        case UIGestureRecognizerStateEnded:
            self.center = CGPointMake(beginningCenter.x + (touchLocation.x - beginningPoint.x),
                                      beginningCenter.y + (touchLocation.y - beginningPoint.y));
            if ([self.delegate respondsToSelector:@selector(stickerViewDidEndMoving:)])
            {
                [self.delegate stickerViewDidEndMoving:self];
            }
            break;
            
        default:
            break;
    }
}

- (void)handleRotateGesture:(UIPanGestureRecognizer *)recognizer
{
    CGPoint touchLocation = [recognizer locationInView:self.superview];
    CGPoint center = self.center;
    
    switch (recognizer.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            deltaAngle = atan2f(touchLocation.y - center.y, touchLocation.x - center.x) - CGAffineTransformGetAngle(self.transform);
            initialBounds = self.bounds;
            initialDistance = CGPointGetDistance(center, touchLocation);
            if ([self.delegate respondsToSelector:@selector(stickerViewDidBeginRotating:)])
            {
                [self.delegate stickerViewDidBeginRotating:self];
            }
            break;
        }
            
        case UIGestureRecognizerStateChanged:
        {
            float angle = atan2f(touchLocation.y - center.y, touchLocation.x - center.x);
            float angleDiff = deltaAngle - angle;
            self.transform = CGAffineTransformMakeRotation(-angleDiff);
            
            CGFloat scale = CGPointGetDistance(center, touchLocation) / initialDistance;
            CGFloat minimumScale = self.minimumSize / MIN(initialBounds.size.width, initialBounds.size.height);
            scale = MAX(scale, minimumScale);
            CGRect scaledBounds = CGRectScale(initialBounds, scale, scale);
            self.bounds = scaledBounds;
            [self setNeedsDisplay];
            
            if ([self.delegate respondsToSelector:@selector(stickerViewDidChangeRotating:)])
            {
                [self.delegate stickerViewDidChangeRotating:self];
            }
            break;
        }
            
        case UIGestureRecognizerStateEnded:
            if ([self.delegate respondsToSelector:@selector(stickerViewDidEndRotating:)])
            {
                [self.delegate stickerViewDidEndRotating:self];
            }
            break;
            
        default:
            break;
    }
}

- (void)handleCloseGesture:(UITapGestureRecognizer *)recognizer
{
    if ([self.delegate respondsToSelector:@selector(stickerViewDidClose:)])
    {
        [self.delegate stickerViewDidClose:self];
    }
    [self removeFromSuperview];
}

- (void)handleFlipGesture:(UITapGestureRecognizer *)recognizer
{
    [UIView animateWithDuration:0.3 animations:^
    {
        self.contentView.transform = CGAffineTransformScale(self.contentView.transform, -1, 1);
    }];
}

- (void)handleTapGesture:(UITapGestureRecognizer *)recognizer
{
    if ([self.delegate respondsToSelector:@selector(stickerViewDidTap:)])
    {
        [self.delegate stickerViewDidTap:self];
    }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{

    return YES;
}

#pragma mark - Public Methods

- (void)setImage:(UIImage *)image forHandler:(ItemStickViewHandler)handler
{
    switch (handler)
    {
        case HandlerClose:
            self.closeImageView.image = image;
            break;
            
        case HandlerRotate:
            self.rotateImageView.image = image;
            break;
        
        default:
        case HandlerFlip:

            self.flipImageView.image = image;
            break;
    }
}

- (void)setPosition:(ItemStickViewPosition)position forHandler:(ItemStickViewHandler)handler
{
    CGPoint origin = self.contentView.frame.origin;
    CGSize size = self.contentView.frame.size;
    UIImageView *handlerView = nil;
    
    switch (handler)
    {
        case HandlerClose:
            handlerView = self.closeImageView;
            break;
            
        case HandlerRotate:
            handlerView = self.rotateImageView;
            break;
            
        case HandlerFlip:
            handlerView = self.flipImageView;
            break;
    }
    
    switch (position)
    {
        case PositionTopLeft:
            handlerView.center = origin;
            handlerView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
            break;
            
        case PositionTopRight:
            handlerView.center = CGPointMake(origin.x + size.width, origin.y);
            handlerView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
            break;
            
        case PositionBottomLeft:
            handlerView.center = CGPointMake(origin.x, origin.y + size.height);
            handlerView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
            break;
            
        case PositionBottomRight:
            handlerView.center = CGPointMake(origin.x + size.width, origin.y + size.height);
            handlerView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
            break;
    }
    
    handlerView.tag = position;
}

- (void)setHandlerSize:(NSInteger)size
{
    if (size <= 0)
    {
        return;
    }
    
    defaultInset = round(size / 2);
    defaultMinimumSize = 4 * defaultInset;
    self.minimumSize = MAX(self.minimumSize, defaultMinimumSize);
    
    CGPoint originalCenter = self.center;
    CGAffineTransform originalTransform = self.transform;
    CGRect frame = self.contentView.frame;
    frame = CGRectMake(0, 0, frame.size.width + defaultInset * 2, frame.size.height + defaultInset * 2);
    
    [self.contentView removeFromSuperview];
    
    self.transform = CGAffineTransformIdentity;
    self.frame = frame;
    
    self.contentView.center = CGRectGetCenter(self.bounds);
    [self addSubview:self.contentView];
    [self sendSubviewToBack:self.contentView];
    
    CGRect handlerFrame = CGRectMake(0, 0, defaultInset * 2, defaultInset * 2);
    self.closeImageView.frame = handlerFrame;
    [self setPosition:self.closeImageView.tag forHandler:HandlerClose];
    self.rotateImageView.frame = handlerFrame;
    [self setPosition:self.rotateImageView.tag forHandler:HandlerRotate];
    self.flipImageView.frame = handlerFrame;
    [self setPosition:self.flipImageView.tag forHandler:HandlerFlip];
    
    self.center = originalCenter;
    self.transform = originalTransform;
}

@end

