//
//  CPPerson.m
//  CollectionPerformance
//
//  Created by Maxim Nizhurin on 10/10/15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import "CPPerson.h"

@implementation CPPerson

- (BOOL)isEqual:(CPPerson *)object {
    return [self.personName isEqualToString:object.personName];
}

@end
