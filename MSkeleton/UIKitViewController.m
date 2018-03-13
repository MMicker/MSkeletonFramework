//
//  UIKitViewController.m
//  MSkeleton
//
//  Created by Micker on 2018/3/7.
//  Copyright © 2018年 Micker. All rights reserved.
//

#import "UIKitViewController.h"
#import <MSkeletonFramework/MSkeletonFramework.h>


@interface UIKitViewController ()

@end

@implementation UIKitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *contentView = [self contentView];
    {
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, CGRectGetWidth(self.view.bounds)-20, 30)];
        label1.isSkeletonable = YES;
        label1.text = @"fodfod";
        [contentView addSubview:label1];
    }
    
    {
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 140, CGRectGetWidth(self.view.bounds)-20, 90)];
        label1.isSkeletonable = YES;
        label1.numberOfLines = 30;
        label1.lastLineFillingPercent = 60;
        label1.lastLineStartFromRight = YES;
        [contentView addSubview:label1];
    }

    {
        UITextView *label1 = [[UITextView alloc] initWithFrame:CGRectMake(10, 250, CGRectGetWidth(self.view.bounds)-20, 90)];
        label1.isSkeletonable = YES;
        label1.skeletonNumLines = 30;
        [contentView addSubview:label1];
    }

    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 360, 80, 80)];
        imageView.isSkeletonable = YES;
        imageView.backgroundColor = [UIColor orangeColor];
        [contentView addSubview:imageView];

        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 360, 80, 80)];
        imageView.isSkeletonable = YES;
        imageView.backgroundColor = [UIColor orangeColor];
        imageView.layer.cornerRadius = CGRectGetWidth(imageView.bounds)/2.0f;
        imageView.layer.masksToBounds = YES;
        [contentView addSubview:imageView];

        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(190, 360, CGRectGetWidth(self.view.bounds)-200, 80)];
        label1.isSkeletonable = YES;
        label1.skeletonNumLines = 4;
        [contentView addSubview:label1];
    }
    [self showSkeleton];
    // Do any additional setup after loading the view, typically from a nib.
}


- (UIView *) contentView {
    return self.view;
}

- (void) showSkeleton {
    [self.view showSkeleton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end


@implementation UIScrollViewController {
    UIScrollView *_scrollView;
}

- (void) viewDidLoad {
    [super viewDidLoad];
}

- (UIView *) contentView {
    if (!_scrollView) {

        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.isSkeletonable = YES;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}
@end


