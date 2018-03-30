//
//  UIScrollView+Skeleton.h
//  MSkeleton
//
//  Created by Micker on 2018/3/9.
//  Copyright © 2018年 Micker. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SkeletonCollectionDataSource;

@protocol CollectionSkeletonProtocol <NSObject>

@property(nonatomic, strong) SkeletonCollectionDataSource *skeletonDataSource;

/**
 add dummy datasource to the view which has conform CollectionSkeletonProtocol protocol
 */
- (void) addDummyDataSource;

/**
 remove dummy datasouce , and reset the datasource to the initial datasource

 @param reloadAfter need to reload after remove
 */
- (void) removeDummyDataSource:(BOOL) reloadAfter;

/**
 enable scrolling on scroll view
 */
- (void) enableScrolling;

/**
 disable scrolling on skeleton is showing
 */
- (void) disableScrolling;

@end

@interface UIView (SkeletonDummy)

/**
 add dummy datasource which implemente the CollectionSkeletonProtocol
 */
- (void) addDummyDataSourceIfNeeded;


/**
 remove dummy datasource

 @param reloadAfter need to reload after remove
 */
- (void) removeDummyDataSourceIfNeeded:(BOOL) reloadAfter;

@end

@interface UIScrollView (Skeleton)<CollectionSkeletonProtocol>

@end

@interface UITableView (Skeleton)<CollectionSkeletonProtocol>

@end

@interface UICollectionView (Skeleton)<CollectionSkeletonProtocol>

@end
