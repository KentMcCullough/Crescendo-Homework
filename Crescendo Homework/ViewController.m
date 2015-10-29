//
//  ViewController.m
//  Crescendo Homework
//
//  Created by Kent McCullough on 10/28/15.
//  Copyright © 2015 Kent McCullough. All rights reserved.
//

#import "ViewController.h"
#import "Property.h"
#import <SVHTTPRequest/SVHTTPClient.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)getPropertyList
{
    SVHTTPClient *client = [SVHTTPClient sharedClient];
    NSString *getURL = @"https://crescendo.mockable.io/properties";
    [client GET:getURL parameters:nil completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        NSLog(@"response = %@", response);
    }];
}

@end
