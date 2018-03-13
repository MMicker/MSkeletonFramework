//
//  UIScrollView+Skeleton.m
//  MSkeleton
//
//  Created by Micker on 2018/3/9.
//  Copyright © 2018年 Micker. All rights reserved.
//

#import "UIScrollView+Skeleton.h"
#import "SkeletonCollectionDataSource.h"
#import <objc/runtime.h>


@implementation UIView (SkeletonDummy)

- (void) addDummyDataSourceIfNeeded {
    if ([self conformsToProtocol:@protocol(CollectionSkeletonProtocol) ]) {
        id<CollectionSkeletonProtocol> prot = (id<CollectionSkeletonProtocol>)self;
        [prot addDummyDataSource];
        [prot disableScrolling];
    }
}

- (void) removeDummyDataSourceIfNeeded:(BOOL) reloadAfter {
    if ([self conformsToProtocol:@protocol(CollectionSkeletonProtocol) ]) {
        id<CollectionSkeletonProtocol> prot = (id<CollectionSkeletonProtocol>)self;
        [prot removeDummyDataSource:reloadAfter];
        [prot enableScrolling];
    }
}
@end

@implementation UIScrollView (Skeleton)
@dynamic skeletonDataSource;

- (void) setSkeletonDataSource:(SkeletonCollectionDataSource *)skeletonDataSource {
    objc_setAssociatedObject(self, @selector(skeletonDataSource), skeletonDataSource, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id<CollectionSkeletonProtocol>) skeletonDataSource {
    return objc_getAssociatedObject(self, @selector(skeletonDataSource));
}

- (void) addDummyDataSource {
}

- (void) removeDummyDataSource:(BOOL) reloadAfter {
}

- (void) enableScrolling {
    [self setScrollEnabled:YES];
}

- (void) disableScrolling {
    [self setScrollEnabled:NO];
}
@end

@implementation UITableView (Skeleton)

- (void) addDummyDataSource {
    id originDataSource = self.dataSource;
    if ([originDataSource conformsToProtocol:@protocol(SkeletonTableViewDataSource)] &&
        ![originDataSource isKindOfClass:[SkeletonCollectionDataSource class]])
    {
        SkeletonCollectionDataSource *dataSource = [[SkeletonCollectionDataSource alloc] initWithTableViewDataSource:originDataSource
                                                                                                           rowHeight: [self skeletonRowHeight] ];
        self.dataSource = self.skeletonDataSource = dataSource;
        !self.skeletonDataSource?:[self reloadData];
    }
}

- (void) removeDummyDataSource:(BOOL) reloadAfter {
    id originDataSource = self.dataSource;
    if ([originDataSource isKindOfClass:[SkeletonCollectionDataSource class]])
    {
        self.dataSource = self.skeletonDataSource.originalTableViewDataSource;
        self.skeletonDataSource = nil;
        self.rowHeight = self.skeletonDataSource.rowHeight;
        !reloadAfter?:[self reloadData];
    }
}

- (CGFloat) skeletonRowHeight {
    return self.rowHeight = self.estimatedRowHeight;
}

@end


@implementation UICollectionView (Skeleton)

- (void) addDummyDataSource {
    id originDataSource = self.dataSource;
    if ([originDataSource conformsToProtocol:@protocol(SkeletonCollectionViewDataSource)] &&
        ![originDataSource isKindOfClass:[SkeletonCollectionDataSource class]])
    {
        SkeletonCollectionDataSource *dataSource = [[SkeletonCollectionDataSource alloc] initWithCollectionDataSource:originDataSource
                                                                                                            rowHeight:0];
        self.dataSource = self.skeletonDataSource = dataSource;
        [self reloadData];
    }
}

- (void) removeDummyDataSource:(BOOL) reloadAfter {
    id originDataSource = self.dataSource;
    if ([originDataSource isKindOfClass:[SkeletonCollectionDataSource class]])
    {
        self.dataSource = self.skeletonDataSource.originalCollectionViewDataSource;
        self.skeletonDataSource = nil;
        !reloadAfter?:[self reloadData];
    }
}

@end
