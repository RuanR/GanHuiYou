//
//  NSObject+expanded.h
//  AFDFramework
//
//  Created by thomas on 13-7-8.
//  Copyright (c) 2013年 thomas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (expanded)
//perfrom for bool
- (void)performSelector:(SEL)aSelector withBool:(BOOL)aValue;
- (id)performSelector:(SEL)aSelector withObjects:(NSArray *)objects;
- (id)performSelector:(SEL)aSelector withParameters:(void *)firstParameter, ...;
@end
