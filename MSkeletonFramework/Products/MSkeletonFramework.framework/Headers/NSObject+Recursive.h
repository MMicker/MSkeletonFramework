//
//  NSObject+Recursive.h
//  MSkeleton
//
//  Created by Micker on 2018/3/7.
//  Copyright © 2018年 Micker. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^LeafBlock)(void);
typedef void (^RecursiveBlock)(NSObject *object);
typedef id (^mapBlock)(id obj);
typedef BOOL (^filterBlock)(id obj);


@interface NSObject (Recursive)


/**
 recurisve search a tree , and execute something on the leaf node;

 @param array initial array
 @param leaf block on leaf node
 @param recurisve recurisve condition
 */
- (void) recursiveSearch:(NSArray *)array
               leafBlock:(LeafBlock) leaf
               recurisve:(RecursiveBlock)recurisve;

@end

@interface NSArray (MapAndFilter)

/**
 execute on each object

 @param map map description
 @return return value description
 */
- (NSArray *) map:(mapBlock) map;


/**
 filter by condition

 @param filter filter description
 @return return value description
 */
- (NSArray *) filter:(filterBlock) filter;

@end

@interface NSSet (MapAndFilter)

/**
 execute on each object
 
 @param map map description
 @return return value description
 */
- (NSSet *) map:(mapBlock) map;

/**
 filter by condition
 
 @param filter filter description
 @return return value description
 */
- (NSSet *) filter:(filterBlock) filter;

@end

