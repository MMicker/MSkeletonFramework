//
//  NSObject+Recursive.m
//  MSkeleton
//
//  Created by Micker on 2018/3/7.
//  Copyright © 2018年 Micker. All rights reserved.
//

#import "NSObject+Recursive.h"

@implementation NSObject (Recursive)

- (void) recursiveSearch:(NSArray *)array
               leafBlock:(LeafBlock) leaf
               recurisve:(RecursiveBlock)recurisve {
    if (0 == [array count]) {
        !leaf?:leaf();
    }
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        recurisve(obj);
    }];
}
@end

@implementation NSArray (MapAndFilter)

- (NSArray *) map:(mapBlock) map {
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:self.count];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id content = map(obj);
        !content?:[result addObject:content];
    }];
    return [result copy];
}

- (NSArray *) filter:(filterBlock) filter {
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:self.count];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        !filter(obj)?:[result addObject:obj];
    }];
    return [result copy];
}
@end


@implementation NSSet (MapAndFilter)

- (NSSet *) map:(mapBlock) map {
    NSMutableSet *result = [NSMutableSet setWithCapacity:self.count];
    [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        id content = map(obj);
        !content?:[result addObject:content];
    }];
    return [result copy];
}

- (NSSet *) filter:(filterBlock) filter {
    NSMutableSet *result = [NSMutableSet setWithCapacity:self.count];
    [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        !filter(obj)?:[result addObject:obj];
    }];
    return [result copy];
}
@end
