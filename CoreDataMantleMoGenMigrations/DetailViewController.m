//
//  DetailViewController.m
//  CoreDataMantleMoGenMigrations
//
//  Created by kanybek on 7/30/15.
//  Copyright (c) 2015 kanybek. All rights reserved.
//

#import "DetailViewController.h"
#import "GRCommonReactiveExamples.h"
#import <MediaPlayer/MediaPlayer.h>
#import "PINCache.h"


@interface DetailViewController ()
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(someMethodForVideo:)];
//    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)someMethodForVideo:(id)sender {
    
    NSString *filePathStr = [[NSBundle mainBundle] pathForResource:@"example" ofType:@"mp4"];
    NSURL *fileURL = [NSURL fileURLWithPath:filePathStr];
    
    MPMoviePlayerViewController *movieController = [[MPMoviePlayerViewController alloc] initWithContentURL:fileURL];
    [self presentMoviePlayerViewControllerAnimated:movieController];
    [movieController.moviePlayer play];
}


- (IBAction)saveVideoToCache:(id)sender {
    NSString *filePathStr = [[NSBundle mainBundle] pathForResource:@"example" ofType:@"mp4"];
    NSData *data = [NSData dataWithContentsOfFile:filePathStr];
    
    
    // save to cache video data
    [[PINCache sharedCache] setObject:data forKey:@"video_key" block:NULL];
    // [cache writeToPath:(NSString *)path]; 
}


- (IBAction)playVideoFromDocumentsCache:(id)sender {
    [[PINCache sharedCache] objectForKey:@"video_key"
                                   block:^(PINCache *cache, NSString *key, id object) {
                                       NSData *dataVideoFile = (NSData *)object;
                                       NSLog(@"dataVideoFile.length = %@", @(dataVideoFile.length));
                                   }];
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
