// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Event.h instead.

#import <CoreData/CoreData.h>

extern const struct EventAttributes {
	__unsafe_unretained NSString *kokDate;
	__unsafe_unretained NSString *kokFloat;
	__unsafe_unretained NSString *kokInteger;
	__unsafe_unretained NSString *kokString;
	__unsafe_unretained NSString *timeStamp;
} EventAttributes;

extern const struct EventRelationships {
	__unsafe_unretained NSString *person;
} EventRelationships;

@class Person;

@interface EventID : NSManagedObjectID {}
@end

@interface _Event : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) EventID* objectID;

@property (nonatomic, strong) NSDate* kokDate;

//- (BOOL)validateKokDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* kokFloat;

@property (atomic) float kokFloatValue;
- (float)kokFloatValue;
- (void)setKokFloatValue:(float)value_;

//- (BOOL)validateKokFloat:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* kokInteger;

@property (atomic) int16_t kokIntegerValue;
- (int16_t)kokIntegerValue;
- (void)setKokIntegerValue:(int16_t)value_;

//- (BOOL)validateKokInteger:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* kokString;

//- (BOOL)validateKokString:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* timeStamp;

//- (BOOL)validateTimeStamp:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) Person *person;

//- (BOOL)validatePerson:(id*)value_ error:(NSError**)error_;

@end

@interface _Event (CoreDataGeneratedPrimitiveAccessors)

- (NSDate*)primitiveKokDate;
- (void)setPrimitiveKokDate:(NSDate*)value;

- (NSNumber*)primitiveKokFloat;
- (void)setPrimitiveKokFloat:(NSNumber*)value;

- (float)primitiveKokFloatValue;
- (void)setPrimitiveKokFloatValue:(float)value_;

- (NSNumber*)primitiveKokInteger;
- (void)setPrimitiveKokInteger:(NSNumber*)value;

- (int16_t)primitiveKokIntegerValue;
- (void)setPrimitiveKokIntegerValue:(int16_t)value_;

- (NSString*)primitiveKokString;
- (void)setPrimitiveKokString:(NSString*)value;

- (NSDate*)primitiveTimeStamp;
- (void)setPrimitiveTimeStamp:(NSDate*)value;

- (Person*)primitivePerson;
- (void)setPrimitivePerson:(Person*)value;

@end
