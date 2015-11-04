//
//  Property.m
//  Crescendo Homework
//
//  Created by Kent McCullough on 10/28/15.
//  Copyright © 2015 Kent McCullough. All rights reserved.
//

#import "Property.h"
#import "Room.h"

@implementation Property

+ (instancetype)propertyFromData:(NSDictionary *)data
{
    Property *property = [self new];
    property.propertyId = data[@"id"];
    property.address = data[@"address"];
    property.city = data[@"city"];
    property.state = data[@"state"];
    property.postalCode = data[@"zip"];

    return property;
}

- (NSDictionary *)dictionaryRepresenation
{
    NSMutableArray *rooms = [NSMutableArray new];
    for (Room *room in self.rooms) {
        [rooms addObject:[room dictionaryRepresenation]];
    }
    NSDictionary *dict = @{
                           @"id": self.propertyId,
                           @"rooms": rooms,
                           };

    return dict;
}

@end
