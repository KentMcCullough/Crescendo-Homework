//
//  Room.m
//  Crescendo Homework
//
//  Created by Kent McCullough on 11/3/15.
//  Copyright © 2015 Kent McCullough. All rights reserved.
//

#import "Room.h"

@implementation Room

+ (instancetype)roomFromData:(NSDictionary *)data
{
    Room *room = [self new];
    room.roomId = data[@"id"];
    room.name = data[@"name"];
    room.photoURL = data[@"photo"];
    return room;
}

- (NSDictionary *)dictionaryRepresenation
{
    NSDictionary *dict = @{
                           @"id": self.roomId,
                           @"rating": self.rating ?: @"Unrated",
                           };

    return dict;
}

@end
