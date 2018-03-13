//
//  CALayer+Skeleton.m
//  MSkeleton
//
//  Created by Micker on 2018/3/7.
//  Copyright © 2018年 Micker. All rights reserved.
//

#import "CALayer+Skeleton.h"
#import "NSObject+Recursive.h"
#import <UIKit/UIKit.h>

NSString *const SkeletonSubLayersName = @"SkeletonSubLayersName";

@implementation CALayer (Skeleton)

- (NSArray *) skeletonSublayers {
  
    return [self.sublayers filter:^BOOL(CALayer *obj) {
        return (SkeletonSubLayersName  == obj.name);
    }];
}

- (void) tintWithColors:(NSArray *) colors {
    
    [self recursiveSearch:[self skeletonSublayers] leafBlock:^{
        self.backgroundColor = ((UIColor *)[colors firstObject]).CGColor;
        
    } recurisve:^(NSObject *object) {
        [(CALayer *)object tintWithColors:colors];
    }];
}
@end


@implementation CAGradientLayer (Skeleton)

- (void) tintWithColors:(NSArray *) colors {
    
    [self recursiveSearch:[self skeletonSublayers] leafBlock:^{
        self.colors = [colors map:^id(UIColor *obj) {
            return (id)(obj.CGColor);
        }];
    } recurisve:^(NSObject *object) {
        [(CALayer *)object tintWithColors:colors];
    }];
}
@end
