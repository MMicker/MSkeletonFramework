//
//  UIKit+MultilineText.m
//  MSkeleton
//
//  Created by Micker on 2018/3/8.
//  Copyright © 2018年 Micker. All rights reserved.
//

#import "UIKit+MultilineText.h"
#import <objc/runtime.h>

@implementation UIView (MultilineTextProtocol)

- (void) setSkeletonNumLines:(int)skeletonNumLines {
    objc_setAssociatedObject(self, @selector(skeletonNumLines), [NSNumber numberWithInt:skeletonNumLines], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (int) skeletonNumLines {
    NSNumber *number =  objc_getAssociatedObject(self, @selector(skeletonNumLines));
    return MIN(100,[number intValue]);
}

- (void) setLastLineFillingPercent:(int)lastLineFillingPercent {
    objc_setAssociatedObject(self, @selector(lastLineFillingPercent), [NSNumber numberWithInt:lastLineFillingPercent], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (int) lastLineFillingPercent {
    NSNumber *number =  objc_getAssociatedObject(self, @selector(lastLineFillingPercent));
    if (!number) {
        return 40;
    }
    return MIN(100,[number intValue]);
}

- (void) setLastLineStartFromRight:(BOOL)lastLineStartFromRight {
    objc_setAssociatedObject(self, @selector(lastLineStartFromRight), [NSNumber numberWithBool:lastLineStartFromRight], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL) lastLineStartFromRight {
    NSNumber *number =  objc_getAssociatedObject(self, @selector(lastLineStartFromRight));
    return [number boolValue];
}

@end

@implementation UILabel (MultilineTextProtocol)
@dynamic skeletonNumLines,lastLineFillingPercent,lastLineStartFromRight;

- (NSUInteger) skeletonNumLines {
    return MIN(100, (0 == [super skeletonNumLines]) ? self.numberOfLines : [super skeletonNumLines]);
}

@end

@implementation UITextView (MultilineTextProtocol)
@dynamic skeletonNumLines,lastLineFillingPercent,lastLineStartFromRight;

@end

