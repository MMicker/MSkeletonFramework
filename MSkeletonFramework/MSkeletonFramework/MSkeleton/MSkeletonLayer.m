//
//  MSkeletonLayer.m
//  MSkeleton
//
//  Created by Micker on 2018/3/7.
//  Copyright © 2018年 Micker. All rights reserved.
//

#import "MSkeletonLayer.h"
#import "NSObject+Recursive.h"
#import "CALayer+Skeleton.h"
#import "UIKit+MultilineText.h"


@implementation MSkeletonConfig

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.type = SkeletonTypeSolid;
        self.multilineHeight = 20.0f;
        self.multilineSpacing = 10.0f;
    }
    return self;
}

+ (instancetype) sharedInstance {
    static dispatch_once_t onceToken;
    static MSkeletonConfig *instance;
    dispatch_once(&onceToken, ^{
        instance = [[MSkeletonConfig alloc] init];
    });
    return instance;
}

- (NSArray *) tintColors {
    if (0 == [_tintColors count]) {
        return @[[UIColor colorWithRed:236.0/255.0f green:236.0/255.0f blue:236.0/255.0f alpha:1]];
    }
    return _tintColors;
}

- (CALayer *) layerWithType {
    return (SkeletonTypeGradient == [MSkeletonConfig sharedInstance].type)?[CAGradientLayer layer]:[CALayer new];
}

- (CGFloat) multilineAllHeight {
    return self.multilineSpacing + self.multilineHeight;
}
@end

@interface MSkeletonLayer()

@property (nonatomic, strong) CALayer *maskLayer;
@property (nonatomic, weak)   UIView *holder;
@end

@implementation MSkeletonLayer


- (id) initWithHolder:(UIView *) holder {
    self = [super init];
    if (self) {
        self.holder = holder;
        self.maskLayer = [[MSkeletonConfig sharedInstance] layerWithType];
        self.maskLayer.anchorPoint = CGPointZero;
        self.maskLayer.frame = holder.bounds;
        [self addMultilinesIfNeeded];
        [self.maskLayer tintWithColors:[MSkeletonConfig sharedInstance].tintColors];
    }
    return self;
}

- (void) addMultilinesIfNeeded {
    if (![self.holder conformsToProtocol:@protocol(MultilineTextProtocol)]) {
        return;
    }
    id<MultilineTextProtocol> proto = (id<MultilineTextProtocol>)self.holder;
    [self addMultilinesLayers:proto.skeletonNumLines lastLineFillPercent:proto.lastLineFillingPercent];
}

- (void) addMultilinesLayers:(int) lines lastLineFillPercent:(int) percent {
    
    int numberOfSublayers = [self calculateskeletonNumLines:lines];
    int startX = 0;
    
    CGFloat width = CGRectGetWidth(self.maskLayer.bounds);
    for (int i = 0 ; i < numberOfSublayers; i++) {
        int targetWidth = width;
        if (numberOfSublayers -1 == i && numberOfSublayers != 1) {
            targetWidth = width * ((CGFloat)percent) / 100;
            if ([self.holder conformsToProtocol:@protocol(MultilineTextProtocol) ]) {
                id<MultilineTextProtocol>proto = (id<MultilineTextProtocol>) self.holder;
                startX = !proto.lastLineStartFromRight ? startX : width - targetWidth;
            }
        }
        [self.maskLayer addSublayer:[self makeMultilineLayerIndex:i x:startX width:targetWidth]];
    }
}

- (CALayer *)makeMultilineLayerIndex:(NSUInteger) index x:(CGFloat)x width:(CGFloat) width {
    
    CALayer *layer = [[MSkeletonConfig sharedInstance] layerWithType];
    layer.name = SkeletonSubLayersName;
    layer.anchorPoint = CGPointZero;
    layer.frame = CGRectMake(x, index * ([[MSkeletonConfig sharedInstance] multilineAllHeight]), width, [MSkeletonConfig sharedInstance].multilineHeight);
    return layer;
}

- (int) calculateskeletonNumLines:(int) maxLines {

    int numberOfSublayers =  (int)(round(CGRectGetHeight(self.maskLayer.bounds)/[[MSkeletonConfig sharedInstance] multilineAllHeight]));
    
    if (0 != maxLines && maxLines <= numberOfSublayers) {
        numberOfSublayers =  maxLines;
    }
    return numberOfSublayers;
}

- (void) removeLayer {
    [self.maskLayer removeFromSuperlayer];
}



@end
