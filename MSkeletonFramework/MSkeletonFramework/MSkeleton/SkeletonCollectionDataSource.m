//
//  SkeletonCollectionDataSource.m
//  MSkeleton
//
//  Created by Micker on 2018/3/9.
//  Copyright © 2018年 Micker. All rights reserved.
//

#import "SkeletonCollectionDataSource.h"
#import "UIView+Skeleton.h"

@implementation SkeletonCollectionDataSource

- (id) initWithTableViewDataSource:(id<SkeletonTableViewDataSource>) tableViewDataSource
                         rowHeight:(CGFloat) rowHeight
{
    self = [super init];
    if (self) {
        self.originalTableViewDataSource = tableViewDataSource;
        self.rowHeight = rowHeight;
    }
    return self;
}

- (id) initWithCollectionDataSource:(id<SkeletonCollectionViewDataSource>) collectionDataSource
                         rowHeight:(CGFloat) rowHeight
{
    self = [super init];
    if (self) {
        self.originalCollectionViewDataSource = collectionDataSource;
        self.rowHeight = rowHeight;
    }
    return self;
}

@end

@implementation SkeletonCollectionDataSource(UITableViewDataSource)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.originalTableViewDataSource) {
        if ([self.originalTableViewDataSource respondsToSelector:@selector(skeletonTableView:numberOfRowsInSection:)]) {
            [self.originalTableViewDataSource skeletonTableView:tableView numberOfRowsInSection:section];
        } else {
            return CGRectGetHeight(tableView.bounds)/self.rowHeight;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [self.originalTableViewDataSource skeletonTableView:tableView cellIdentifierForRowAt:indexPath];
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:identifier];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.originalTableViewDataSource && [self.originalTableViewDataSource respondsToSelector:@selector(skelethonNumberOfSections:)]) {
        return [self.originalTableViewDataSource skelethonNumberOfSections:tableView];
    }
    return 1;
}

@end


@implementation SkeletonCollectionDataSource(UICollectionViewDataSource)

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.originalCollectionViewDataSource) {
        if ([self.originalCollectionViewDataSource respondsToSelector:@selector(skelethonCollectionView:numberOfItemsInSection:)]) {
            [self.originalCollectionViewDataSource skelethonCollectionView:collectionView numberOfItemsInSection:section];
        } else {
            if ([collectionView.collectionViewLayout isKindOfClass: [UICollectionViewFlowLayout class]]) {
                UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *) collectionView.collectionViewLayout;
                if (UICollectionViewScrollDirectionVertical == flowLayout.scrollDirection) {
                    return CGRectGetHeight(collectionView.bounds)/flowLayout.itemSize.height;
                } else {
                    return CGRectGetWidth(collectionView.bounds)/flowLayout.itemSize.width;
                }
            }
        }
    }
    return 0;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [self.originalCollectionViewDataSource skelethonCollectionView:collectionView cellForItemAtIndexPath:indexPath];
    UICollectionViewCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (self.originalCollectionViewDataSource && [self.originalCollectionViewDataSource respondsToSelector:@selector(skelethonNumberOfSectionsInCollectionView:)]) {
        return [self.originalCollectionViewDataSource skelethonNumberOfSectionsInCollectionView:collectionView];
    }
    return 1;
}
@end
