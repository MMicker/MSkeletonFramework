//
//  SkeletonCollectionDataSource.h
//  MSkeleton
//
//  Created by Micker on 2018/3/9.
//  Copyright © 2018年 Micker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma mark SkeletonTableViewDataSource

@protocol SkeletonTableViewDataSource <UITableViewDataSource>

@required

/**
 config the identifier for each cell, the identifier needs to be registed before use

 @param tableView tableView description
 @param indexPath indexPath description
 @return return value description
 */
- (NSString *)skeletonTableView:(UITableView *)tableView cellIdentifierForRowAt:(NSIndexPath *)indexPath;

@optional
- (NSInteger)skelethonNumberOfSections:(UITableView *)tableView;

- (NSInteger)skeletonTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

@end

#pragma mark SkeletonCollectionViewDataSource

@protocol SkeletonCollectionViewDataSource <UICollectionViewDataSource>

@required
- (NSString *)skelethonCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;

@optional
- (NSInteger)skelethonCollectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;

- (NSInteger)skelethonNumberOfSectionsInCollectionView:(UICollectionView *)collectionView;

@end


#pragma mark SkeletonCollectionDataSource

@interface SkeletonCollectionDataSource : NSObject

@property (nonatomic, weak) id<SkeletonTableViewDataSource> originalTableViewDataSource;
@property (nonatomic, weak) id<SkeletonCollectionViewDataSource> originalCollectionViewDataSource;
@property (nonatomic, assign) CGFloat rowHeight;

- (id) initWithTableViewDataSource:(id<SkeletonTableViewDataSource>) tableViewDataSource
                         rowHeight:(CGFloat) rowHeight;

- (id) initWithCollectionDataSource:(id<SkeletonCollectionViewDataSource>) collectionDataSource
                         rowHeight:(CGFloat) rowHeight;
@end


#pragma mark SkeletonCollectionDataSource(UITableViewDataSource)

@interface SkeletonCollectionDataSource(UITableViewDataSource) <UITableViewDataSource>


@end

#pragma mark SkeletonCollectionDataSource(UICollectionViewDataSource)

@interface SkeletonCollectionDataSource(UICollectionViewDataSource) <UICollectionViewDataSource>


@end
