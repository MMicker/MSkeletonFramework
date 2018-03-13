//
//  SkeletonCollectionViewController.m
//  MSkeleton
//
//  Created by Micker on 2018/3/12.
//  Copyright © 2018年 Micker. All rights reserved.
//

#import "SkeletonCollectionViewController.h"
#import <MSkeletonFramework/MSkeletonFramework.h>

@interface UISkeletonCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *introLabel;
@end

@implementation UISkeletonCollectionViewCell

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
        self.headImageView.isSkeletonable = YES;
        self.headImageView.layer.masksToBounds = YES;
        self.headImageView.layer.cornerRadius = 25.0;
        [self.contentView addSubview:self.headImageView];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 10, CGRectGetWidth(self.bounds)-70, 30)];
        self.nameLabel.isSkeletonable = YES;
        [self.contentView addSubview:self.nameLabel];
        
        self.introLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 40, CGRectGetWidth(self.bounds)-70, 60)];
        self.introLabel.skeletonNumLines = 4;
        self.introLabel.isSkeletonable = YES;
        self.contentView.isSkeletonable = YES;
        [self.contentView addSubview:self.introLabel];
        self.isSkeletonable = YES;
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


@end

@interface SkeletonCollectionViewController ()<SkeletonCollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation SkeletonCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    
    [self.view showSkeleton];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view hideSkeleton:YES];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UICollectionViewFlowLayout*) layout {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(CGRectGetWidth(self.view.bounds), 100);
    return layout;
}

- (UICollectionView *) collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:[self layout]];
        _collectionView.dataSource = self;
        _collectionView.isSkeletonable = YES;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:NSClassFromString(@"UISkeletonCollectionViewCell") forCellWithReuseIdentifier:@"SkeletonCollectionViewController"];
    
    }
    return _collectionView;
}

- (NSString *)skelethonCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return @"SkeletonCollectionViewController";
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UISkeletonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SkeletonCollectionViewController" forIndexPath:indexPath];
    
    cell.nameLabel.text = [NSString stringWithFormat:@"%@ - name", @(indexPath.item)];
    cell.introLabel.text = [NSString stringWithFormat:@"%@ - %@",@(indexPath.item), @"Skeleton"];
    return cell;
}
@end

@implementation SkeletonHCollectionViewController


- (UICollectionViewFlowLayout*) layout {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(CGRectGetWidth(self.view.bounds)/2, CGRectGetHeight(self.view.bounds));
    return layout;
}
@end
