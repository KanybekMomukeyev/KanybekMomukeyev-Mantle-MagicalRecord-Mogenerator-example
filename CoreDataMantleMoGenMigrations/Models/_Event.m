// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Event.m instead.

#import "_Event.h"

const struct EventAttributes EventAttributes = {
	.kokDate = @"kokDate",
	.kokFloat = @"kokFloat",
	.kokInteger = @"kokInteger",
	.kokString = @"kokString",
	.timeStamp = @"timeStamp",
};

const struct EventRelationships EventRelationships = {
	.person = @"person",
};

@implementation EventID
@end

@implementation _Event

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Event";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Event" inManagedObjectContext:moc_];
}

- (EventID*)objectID {
	return (EventID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"kokFloatValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"kokFloat"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"kokIntegerValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"kokInteger"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic kokDate;

@dynamic kokFloat;

- (float)kokFloatValue {
	NSNumber *result = [self kokFloat];
	return [result floatValue];
}

- (void)setKokFloatValue:(float)value_ {
	[self setKokFloat:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveKokFloatValue {
	NSNumber *result = [self primitiveKokFloat];
	return [result floatValue];
}

- (void)setPrimitiveKokFloatValue:(float)value_ {
	[self setPrimitiveKokFloat:[NSNumber numberWithFloat:value_]];
}

@dynamic kokInteger;

- (int16_t)kokIntegerValue {
	NSNumber *result = [self kokInteger];
	return [result shortValue];
}

- (void)setKokIntegerValue:(int16_t)value_ {
	[self setKokInteger:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveKokIntegerValue {
	NSNumber *result = [self primitiveKokInteger];
	return [result shortValue];
}

- (void)setPrimitiveKokIntegerValue:(int16_t)value_ {
	[self setPrimitiveKokInteger:[NSNumber numberWithShort:value_]];
}

@dynamic kokString;

@dynamic timeStamp;

@dynamic person;

@end

