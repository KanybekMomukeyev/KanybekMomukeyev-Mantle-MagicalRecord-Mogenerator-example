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


- (void)fetchObjectsFromDatabase {
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"person.name matches[cd] %@", @"1"];
    NSLog(@"%@",[Event MR_findAllWithPredicate:predicate inContext:self.localContext]);
    
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
