//
//  MasterViewController.m
//  CoreDataMantleMoGenMigrations
//
//  Created by kanybek on 7/30/15.
//  Copyright (c) 2015 kanybek. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Event.h"
#import "Person.h"
#import "TestTVCell.h"
#import "GCDispatch.h"

@interface MasterViewController ()
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) NSManagedObjectContext *localContext;
@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.localContext  = [NSManagedObjectContext MR_defaultContext];
    NSFetchRequest *fetchRequest = [Event MR_requestAllSortedBy:@"timeStamp"
                                                              ascending:NO
                                                              inContext:self.localContext];
    
    [fetchRequest setReturnsDistinctResults:YES];
    [fetchRequest setFetchLimit:100000];
    fetchRequest.fetchOffset = 0;
    
    NSError *error = nil;
    NSArray *results = [self.localContext executeFetchRequest:fetchRequest error:&error];
    
    self.items = [[NSMutableArray alloc] initWithArray:results];
    

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    
    UIBarButtonItem *fetchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(fetchObjectsFromDatabase)];
    self.navigationItem.leftBarButtonItem = fetchButton;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self testBackgroundThreadMethod];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    Event *event = [Event MR_createEntityInContext:self.localContext];
    event.kokInteger = @(arc4random()%5);
    event.timeStamp = [NSDate date];
    event.kokString = [NSString stringWithFormat:@"%@",@"1"];
    
    Person *person = [Person MR_createEntityInContext:self.localContext];
    person.name = [NSString stringWithFormat:@"%@",@"1"];
    person.surname = [NSString stringWithFormat:@"%@",@(arc4random()%5)];
    
    event.person = person;

    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.items.count inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    [self.items addObject:event];
    [self.tableView endUpdates];
}

- (void)testBackgroundThreadMethod {
    
    [GCDispatch performBlockInMainQueue:^{
        
        NSManagedObjectContext *anotherContext = [NSManagedObjectContext MR_contextWithParent:self.localContext];
        
        for (NSUInteger idx = 0; idx < 1000; idx ++) {
            Event *event = [Event MR_createEntityInContext:anotherContext];
            event.kokInteger = @(arc4random()%(idx + 1));
            event.timeStamp = [NSDate date];
            event.kokString = [NSString stringWithFormat:@"%@",@(idx)];
            
            
            Person *person = [Person MR_createEntityInContext:anotherContext];
            person.name = [NSString stringWithFormat:@"%@",@(idx)];
            person.surname = [NSString stringWithFormat:@"%@",@(arc4random()%5)];
            
            event.person = person;
        }
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"person.name contains[cd] %@", @"20"];
        [[Event MR_findAllWithPredicate:predicate inContext:anotherContext] enumerateObjectsUsingBlock:^(Event *obj, NSUInteger idx, BOOL *stop) {
            NSLog(@"obj.person.name = %@", obj.person.name);
        }];
    } completion:^{
        //[self fetchObjectsFromDatabase];
    }];
    
    return;
    
    [GCDispatch performBlockInBackgroundQueue:^{
    
        // ---- BEGIN background queue
        
        NSManagedObjectContext *backgroundContext = [NSManagedObjectContext MR_contextWithParent:self.localContext];
        
        for (NSUInteger idx = 0; idx < 1000; idx ++) {
            Event *event = [Event MR_createEntityInContext:backgroundContext];
            event.kokInteger = @(arc4random()%(idx + 1));
            event.timeStamp = [NSDate date];
            event.kokString = [NSString stringWithFormat:@"%@",@(idx)];
            
            
            Person *person = [Person MR_createEntityInContext:backgroundContext];
            person.name = [NSString stringWithFormat:@"%@",@(idx)];
            person.surname = [NSString stringWithFormat:@"%@",@(arc4random()%5)];

            event.person = person;
        }
        
        // save our changes made in background thread
        [backgroundContext MR_saveToPersistentStoreAndWait];
    
        
        // ---- END background queue
        
    } completion:^{
        
        // ----  Main queue
        
        [self fetchObjectsFromDatabase];
    }];
    // working with background threads
    
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"person.name matches[cd] %@", @"1"];
//    Event *event = [[Event MR_findAllWithPredicate:predicate inContext:self.localContext] lastObject];
//    
//    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext){
//        
//        Event *someEvent = [event MR_inContext:localContext];
//        someEvent.kokInteger = @(arc4random()%5);
//        someEvent.timeStamp = [NSDate date];
//        someEvent.kokString = [NSString stringWithFormat:@"%@",@"1"];
//
//    }];
}


- (void)fetchObjectsFromDatabase {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"person.name contains[cd] %@", @"20"];
    NSLog(@"%@",@([Event MR_countOfEntitiesWithPredicate:predicate inContext:self.localContext]));

    
    NSLog(@"________________________");
    [[Event MR_findAllWithPredicate:predicate inContext:self.localContext] enumerateObjectsUsingBlock:^(Event *obj, NSUInteger idx, BOOL *stop) {
        NSLog(@"obj.person.name = %@", obj.person.name);
    }];
    NSLog(@"++++++++++++++++++++++++");
}

#pragma mark -
#pragma mark - Table View
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TestTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TestTVCell" forIndexPath:indexPath];
    Event *eventModel = [self.items objectAtIndex:indexPath.row];
    cell.testLabel.text = [NSString stringWithFormat:@"%@ ||| %@ ", eventModel.person.name, eventModel.timeStamp.description];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

@end
