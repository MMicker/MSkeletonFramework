//
//  UIView+Skeleton.h
//  MSkeleton
//
//  Created by Micker on 2018/3/7.
//  Copyright © 2018年 Micker. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MSkeletonLayer;

@interface UIView (Skeleton)

@property(nonatomic, assign) BOOL isSkeletonable;

@property(nonatomic, assign) BOOL isSkeletonActive;

@property(nonatomic, strong) MSkeletonLayer *skeletonLayer;


/**
 Show skeleton on this view and subviews
 */
- (void) showSkeleton;


/**
 hide the skeleton layer on this view and all subviews

 @param reloadAfter  is need to reload collections view ,including tableview and collectionview
 */
- (void) hideSkeleton:(BOOL) reloadAfter;


/**
 the subviews that the view is skeletonable

 @return return value description
 */
- (NSArray *) subviewsSkeletonables;

@end

