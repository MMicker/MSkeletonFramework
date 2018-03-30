//
//  UIView+Skeleton.m
//  MSkeleton
//
//  Created by Micker on 2018/3/7.
//  Copyright © 2018年 Micker. All rights reserved.
//

#import "UIView+Skeleton.h"
#import "CALayer+Skeleton.h"
#import "NSObject+Recursive.h"
#import "MSkeletonLayer.h"
#import "UIKit+PrepareForSkeleton.h"
#import "UIScrollView+Skeleton.h"
#import <objc/runtime.h>

@implementation UIView (Skeleton)
@dynamic isSkeletonable,isSkeletonActive,skeletonLayer;

- (void) setIsSkeletonable:(BOOL)isSkeletonable{
    objc_setAssociatedObject(self, @selector(isSkeletonable), [NSNumber numberWithBool:isSkeletonable], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL) isSkeletonable {
    NSNumber *nubmer =  objc_getAssociatedObject(self, @selector(isSkeletonable));
    return [nubmer boolValue];
}

- (void) setIsSkeletonActive:(BOOL)isSkeletonActive {
    objc_setAssociatedObject(self, @selector(isSkeletonActive), [NSNumber numberWithBool:isSkeletonActive], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL) isSkeletonActive {
    NSNumber *nubmer =  objc_getAssociatedObject(self, @selector(isSkeletonActive));
    return [nubmer boolValue];
}

- (void) setSkeletonLayer:(MSkeletonLayer *)skeletonLayer {
    objc_setAssociatedObject(self, @selector(skeletonLayer), skeletonLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (MSkeletonLayer *) skeletonLayer {
    return objc_getAssociatedObject(self, @selector(skeletonLayer));
}

- (NSArray *) subviewsSkeletonables {
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:2];
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        !obj.isSkeletonable?:[result addObject: obj];
    }];
    return [result copy];
}

- (void) showSkeleton {
    [self __internalShowSkeleton];
//    [self performSelector:@selector(__internalShowSkeleton) withObject:nil afterDelay:0];
}

- (void) __internalShowSkeleton {
    
    [self addDummyDataSourceIfNeeded];
    [self recursiveSearch:self.subviewsSkeletonables leafBlock:^{
        MSkeletonLayer *skeleton = [[MSkeletonLayer alloc] initWithHolder:self];
        [self setUserInteractionEnabled:NO];
        if ([self conformsToProtocol:@protocol(PrepareForSkeletonProtocol) ]) {
            id<PrepareForSkeletonProtocol> proto = (id<PrepareForSkeletonProtocol>) self;
            [proto prepareViewForSkeleton];
        }
        self.skeletonLayer = skeleton;
        [self.layer insertSublayer:skeleton.maskLayer atIndex:UINT32_MAX];
        
    } recurisve:^(NSObject *object) {
        [((UIView *) object) __internalShowSkeleton];
    }];
}

- (void) hideSkeleton:(BOOL) reloadAfter {
    NSArray *array = self.subviewsSkeletonables;
    [self removeDummyDataSourceIfNeeded:reloadAfter];
    [self setUserInteractionEnabled:YES];
    [self recursiveSearch:array
                leafBlock:^
    {
        [self.skeletonLayer removeLayer];
        self.skeletonLayer = nil;
    }
                recurisve:^(NSObject *object)
    {
        [((UIView *) object) hideSkeleton:reloadAfter];
    }];
}

@end

@interface UITableView (SkeletonView)


@end

@implementation UITableView (SkeletonView)

- (NSArray *) subviewsSkeletonables {
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:2];

    [result addObjectsFromArray: [self.visibleCells filter:^BOOL(UIView *obj) {
        return [obj isSkeletonable];
    }]];

    !self.tableHeaderView.isSkeletonable?:[result addObject:self.tableHeaderView];
    !self.tableFooterView.isSkeletonable?:[result addObject:self.tableFooterView];

    return [result copy];
}

@end


@interface UITableViewCell (SkeletonView)

@end

@implementation UITableViewCell (SkeletonView)

- (NSArray *) subviewsSkeletonables {
    return [self.contentView.subviews filter:^BOOL(UIView *obj) {
        return [obj isSkeletonable];
    }];
}

- (BOOL) isSkeletonable {
    return YES;
}

@end

@interface UICollectionViewCell (SkeletonView)
@end

@implementation UICollectionViewCell (SkeletonView)

- (NSArray *) subviewsSkeletonables {
    return [self.contentView.subviews filter:^BOOL(UIView *obj) {
        return [obj isSkeletonable];
    }];
}

- (BOOL) isSkeletonable {
    return YES;
}

@end

