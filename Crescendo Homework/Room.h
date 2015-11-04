//
//  Room.h
//  Crescendo Homework
//
//  Created by Kent McCullough on 11/3/15.
//  Copyright © 2015 Kent McCullough. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Room : NSObject

+ (instancetype)roomFromData:(NSDictionary *)data;

@property (nonatomic, strong) NSString *roomId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *photoURL;

@property (nonatomic, strong) NSString *rating;

- (NSDictionary *)dictionaryRepresenation;

@end
