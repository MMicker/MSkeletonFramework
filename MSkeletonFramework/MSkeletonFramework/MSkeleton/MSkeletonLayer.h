//
//  MSkeletonLayer.h
//  MSkeleton
//
//  Created by Micker on 2018/3/7.
//  Copyright © 2018年 Micker. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SkeletonType) {
    SkeletonTypeSolid,
    SkeletonTypeGradient,
};

/**
 Global defined skeleton infomations
 such as the layer is solid or gradient
 */
@interface MSkeletonConfig : NSObject

@property (nonatomic, strong) NSArray *tintColors;          // default is 236,236,236
@property (nonatomic, assign) SkeletonType type;            // default is solid
@property (nonatomic, assign) CGFloat multilineHeight;      // default is 20
@property (nonatomic, assign) CGFloat multilineSpacing;     // default is 10
@property (nonatomic, assign) CGFloat multilineAllHeight;   // multilineHeight + multilineSpacing

+ (instancetype) sharedInstance;

- (CALayer *) layerWithType;

- (CGFloat) multilineAllHeight;

@end

@interface MSkeletonLayer : NSObject

@property (nonatomic, strong) CALayer *maskLayer;
@property (nonatomic, weak, readonly)   UIView *holder;

- (id) initWithHolder:(UIView *) holder;

- (void) removeLayer;

@end

