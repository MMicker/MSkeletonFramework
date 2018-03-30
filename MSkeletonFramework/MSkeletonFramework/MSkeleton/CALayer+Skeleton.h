//
//  CALayer+Skeleton.h
//  MSkeleton
//
//  Created by Micker on 2018/3/7.
//  Copyright © 2018年 Micker. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

extern NSString *const SkeletonSubLayersName;

@interface CALayer (Skeleton)


/**
 the skeleton sublayers

 @return return value description
 */
- (NSArray *) skeletonSublayers;


/**
 config the skeleton layer's backgrond color

 @param colors colors description
 */
- (void) tintWithColors:(NSArray *) colors;

@end


@interface CAGradientLayer (Skeleton)

@end
