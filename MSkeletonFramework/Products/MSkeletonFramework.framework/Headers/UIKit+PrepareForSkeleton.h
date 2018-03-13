//
//  UIKit+PrepareForSkeleton.h
//  MSkeleton
//
//  Created by Micker on 2018/3/8.
//  Copyright © 2018年 Micker. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PrepareForSkeletonProtocol <NSObject>

/**
 Before show skelethon , do some addtional action

 Example : label.text = nil , resigin first responder..
 */
- (void) prepareViewForSkeleton;
@end


@interface UILabel (PrepareForSkeletonProtocol) <PrepareForSkeletonProtocol>

@end

@interface UITextView (PrepareForSkeletonProtocol)<PrepareForSkeletonProtocol>

@end

@interface UIImageView (PrepareForSkeletonProtocol)

@end
