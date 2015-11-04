//
//  PropertyListViewController.m
//  Crescendo Homework
//
//  Created by Kent McCullough on 11/2/15.
//  Copyright © 2015 Kent McCullough. All rights reserved.
//

#import "PropertyListViewController.h"
#import "Property.h"
#import <SVHTTPRequest/SVHTTPClient.h>
#import "RoomListViewController.h"

@interface PropertyListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *tableItems;
@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end

@implementation PropertyListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getPropertyList];
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
        NSMutableArray *properties = [NSMutableArray new];
        for (NSDictionary *dict in response) {
            Property *property = [Property propertyFromData:dict];
            [properties addObject:property];
        }
        self.tableItems = [properties copy];
        [self.tableView reloadData];
    }];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    RoomListViewController *destVc = [segue destinationViewController];
    Property *selectedProperty = self.tableItems[[self.tableView indexPathForSelectedRow].row];
    destVc.property = selectedProperty;

    [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:YES];
}

#pragma mark - UITableView


#pragma mark DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"addressCell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];

    Property *prop = self.tableItems[indexPath.row];
    cell.textLabel.text = prop.address;

    return cell;
}

#pragma mark Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

@end
