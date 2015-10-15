//
//  GRCollectionPerformanceExamples.m
//  CoreDataMantleMoGenMigrations
//
//  Created by kanybek on 10/11/15.
//  Copyright (c) 2015 kanybek. All rights reserved.
//

#import "GRCollectionPerformanceExamples.h"

@implementation GRCollectionPerformanceExamples
+ (void)calcaulate
{
    NSInteger iterationIndex;
    
    const NSInteger NUM_ELEMENTS = 10000;
    const NSInteger NUM_TEST_ITERATIONS = 3;
    NSDate *startTime;
    NSDate *endTime;
    NSMutableArray *keys = [NSMutableArray arrayWithCapacity:NUM_ELEMENTS];
    NSMutableArray *objects = [NSMutableArray arrayWithCapacity:NUM_ELEMENTS];
    
    NSLog(@"Constructing test data for %d elements.", NUM_ELEMENTS);
    
    //
    // Preconstruct the arrays of keys and objects to use in the tests
    //
    for (iterationIndex = 0; iterationIndex < NUM_ELEMENTS; iterationIndex++)
    {
        NSString *keyString = [NSString stringWithFormat:@"%010ld", (long)(iterationIndex * 7)];
        [keys addObject:keyString];
        
        NSNumber *objectValue = [NSNumber numberWithInteger:iterationIndex];
        [objects addObject:objectValue];
        
    }
    
    for (int i = 0; i < NUM_TEST_ITERATIONS; i++) {
        
        NSLog(@"=== Beginning test loop. Iteration %d of %d ===", i + 1, NUM_TEST_ITERATIONS);
        
        NSMutableArray       *arrayOfObjects = [NSMutableArray arrayWithCapacity:NUM_ELEMENTS];
        NSMutableArray       *unsizedArray = [NSMutableArray array];
        NSMutableSet         *setOfObjects = [NSMutableSet setWithCapacity:NUM_ELEMENTS];
        NSMutableSet         *setFromArray = nil;
        NSMutableSet         *unsizedSet = [NSMutableSet set];
        NSMutableDictionary  *testDictionary = [NSMutableDictionary dictionary];
        
        //
        // Test 1: Array construction when arrayWithCapacity: is used
        //
        startTime = [NSDate date];
        for (NSNumber *number in objects) {
            [arrayOfObjects addObject:number];
        }
        endTime = [NSDate date];
        NSLog(@"Constructing the preallocated array took %g seconds", [endTime timeIntervalSinceDate:startTime]);
        
        
        //
        // Test 2: Array construction when arrayWithCapacity: is NOT used
        //
        startTime = [NSDate date];
        for (NSNumber *number in objects) {
            [unsizedArray addObject:number];
        }
        endTime = [NSDate date];
        NSLog(@"Constructing the unpreallocated array took %g seconds", [endTime timeIntervalSinceDate:startTime]);
        
        
        //
        // Test 2: Array construction when arrayWithCapacity: is NOT used
        //
        startTime = [NSDate date];
        for (NSNumber *number in arrayOfObjects) {
        }
        endTime = [NSDate date];
        NSLog(@"Iterating the array took %g seconds", [endTime timeIntervalSinceDate:startTime]);
        
        
        //
        // Test 2a: Array querying by isEqualTo:
        //
        startTime = [NSDate date];
        for (NSNumber *number in objects)
        {
            [arrayOfObjects indexOfObject:number];
        }
        endTime = [NSDate date];
        NSLog(@"Array querying by isEqualTo: took %g seconds", [endTime timeIntervalSinceDate:startTime]);
        
        
        //
        // Test 2b: Array querying by pointer value
        //
        startTime = [NSDate date];
        for (NSNumber *number in objects)
        {
            [arrayOfObjects indexOfObjectIdenticalTo:number];
        }
        endTime = [NSDate date];
        NSLog(@"Array querying by pointer value took %g seconds", [endTime timeIntervalSinceDate:startTime]);
        
        
        //
        // Test 3: Set construction when setWithCapacity: is used
        //
        startTime = [NSDate date];
        for (NSNumber *number in objects)
        {
            [setOfObjects addObject:number];
        }
        endTime = [NSDate date];
        NSLog(@"Constructing the preallocated set took %g seconds", [endTime timeIntervalSinceDate:startTime]);
        
        
        //
        // Test 4: Set construction when setWithCapacity: is NOT used
        //
        startTime = [NSDate date];
        for (NSNumber *number in objects)
        {
            [unsizedSet addObject:number];
        }
        endTime = [NSDate date];
        NSLog(@"Constructing the unpreallocated set took %g seconds",[endTime timeIntervalSinceDate:startTime]);
        
        
        //
        // Test 4z: Set construction directly from an array of objects
        //
        startTime = [NSDate date];
        setFromArray = [NSMutableSet setWithArray:objects];
        endTime = [NSDate date];
        NSLog(@"Constructing the set from an array took %g seconds",[endTime timeIntervalSinceDate:startTime]);
        
        
        //
        // Test 4y: Set iterating
        //
        startTime = [NSDate date];
        for (NSNumber *number in setOfObjects)
        {
        }
        endTime = [NSDate date];
        NSLog(@"Iterating the set took %g seconds",[endTime timeIntervalSinceDate:startTime]);
        
        
        //
        // Test 4a: Set querying
        //
        startTime = [NSDate date];
        for (NSNumber *number in objects)
        {
            [setOfObjects containsObject:number];
        }
        endTime = [NSDate date];
        NSLog(@"Set querying took %g seconds", [endTime timeIntervalSinceDate:startTime]);
        
        
        //
        // Test 5: Dictionary construction
        //
        startTime = [NSDate date];
        for (iterationIndex = 0; iterationIndex < NUM_ELEMENTS; iterationIndex++)
        {
            [testDictionary
             setObject:[objects objectAtIndex:iterationIndex]
             forKey:[keys objectAtIndex:iterationIndex]];
        }
        endTime = [NSDate date];
        NSLog(@"Constructing the dictionary took %g seconds", [endTime timeIntervalSinceDate:startTime]);
        
        
        
        
        //
        // Test 6: Dictionary querying
        //
        startTime = [NSDate date];
        for (NSString *key in testDictionary)
        {
            [testDictionary objectForKey:key];
        }
        endTime = [NSDate date];
        NSLog(@"Iterating and querying the dictionary took %g seconds", [endTime timeIntervalSinceDate:startTime]);
        
        
        
        
        //
        // Test 6: Dictionary querying
        //
        startTime = [NSDate date];
        for (NSString *key in keys)
        {
            [testDictionary objectForKey:key];
        }
        endTime = [NSDate date];
        NSLog(@"Querying the dictionary by keys from different source took %g seconds", [endTime timeIntervalSinceDate:startTime]);
    }
}

@end
