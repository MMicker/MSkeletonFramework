//
//  UIKit+MultilineText.h
//  MSkeleton
//
//  Created by Micker on 2018/3/8.
//  Copyright © 2018年 Micker. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MultilineTextProtocol <NSObject>

/**
 the skeleton number lines ,
 */
@property (nonatomic, assign) int skeletonNumLines;

/**
 the last skeleton layer's width , the max is 100
 */
@property (nonatomic, assign) int lastLineFillingPercent;

/**
 the last skeleton is started from right ,defautl is NO
 */
@property (nonatomic, assign) BOOL lastLineStartFromRight;
@end


@interface UIView (MultilineTextProtocol)

@end

@interface UILabel (MultilineTextProtocol) <MultilineTextProtocol>

@end

@interface UITextView (MultilineTextProtocol)<MultilineTextProtocol>

@end
