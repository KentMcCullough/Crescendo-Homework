//
//  Property.h
//  Crescendo Homework
//
//  Created by Kent McCullough on 10/28/15.
//  Copyright © 2015 Kent McCullough. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Property : NSObject

@property (nonatomic, strong) NSString *propertyId;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *postalCode;
@property (nonatomic, strong) NSArray *rooms;

@end

/*
address = "251 Green Bay Road";
city = Cedarburg;
id = 1;
state = WI;
zip = 53012;
*/