//
//  UIKit+PrepareForSkeleton.m
//  MSkeleton
//
//  Created by Micker on 2018/3/8.
//  Copyright © 2018年 Micker. All rights reserved.
//

#import "UIKit+PrepareForSkeleton.h"

@implementation UILabel (PrepareForSkeletonProtocol)

- (void) prepareViewForSkeleton {
    [self setText:nil];
    [self resignFirstResponder];
}

@end

@implementation UITextView (PrepareForSkeletonProtocol)

- (void) prepareViewForSkeleton {
    [self setText:nil];
    [self resignFirstResponder];
}

@end

@implementation UIImageView (PrepareForSkeletonProtocol)

- (void) prepareViewForSkeleton {
    [self setImage:nil];
    [self resignFirstResponder];
}

@end
