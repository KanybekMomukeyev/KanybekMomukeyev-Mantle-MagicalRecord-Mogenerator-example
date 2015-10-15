//
//  DetailViewController.m
//  CoreDataMantleMoGenMigrations
//
//  Created by kanybek on 7/30/15.
//  Copyright (c) 2015 kanybek. All rights reserved.
//

#import "DetailViewController.h"
#import "GRCommonReactiveExamples.h"

@interface DetailViewController ()
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)testMethod1 {
    NSMutableArray *allObjects = [NSMutableArray new];
    int Amount = 1000000;
    for (NSUInteger index = 0; index < Amount; index ++) {
        CPPerson *p = [CPPerson new];
        p.personName = [NSString stringWithFormat:@"MY Name is %@ %@",@(index),@(arc4random()%(index+1))];
        [allObjects addObject:p];
    }
    
    CPPerson *person = [CPPerson new];
    person.personName = [NSString stringWithFormat:@"MY NAME IS MAKS"];
    [allObjects addObject:person];
    
    ARpS_measure(^{
        [allObjects enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
        }];
    });
    
    NSLog(@"-------------------------------------------------------------");
    
    ARpS_measure(^{
        
        //        NSUInteger barIndex = [allObjects indexOfObjectWithOptions:NSEnumerationConcurrent passingTest:^BOOL(CPPerson *obj, NSUInteger idx, BOOL *stop) {
        //            return [obj.personName isEqualToString:@"MY NAME IS MAKS"];
        //        }];
        
        NSUInteger barIndex = [allObjects indexOfObjectPassingTest:^BOOL(CPPerson *obj, NSUInteger idx, BOOL *stop) {
            return (obj == person);
        }];
        
        NSLog(@"barIndex = %@",@(barIndex));
        
    });
    
    NSLog(@"-------------------------------------------------------------");
    
    ARpS_measure(^{
        
        NSUInteger barIndex = [allObjects indexOfObject:person];
        NSLog(@"barIndex = %@",@(barIndex));
        
    });
}


- (void)testMethod2 {
    GRCommonReactiveExamples *commonExamples = [GRCommonReactiveExamples new];
    [commonExamples racSequenceExamples];
}


@end
