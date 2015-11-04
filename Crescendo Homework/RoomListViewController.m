//
//  RoomListViewController.m
//  Crescendo Homework
//
//  Created by Kent McCullough on 11/3/15.
//  Copyright © 2015 Kent McCullough. All rights reserved.
//

#import "RoomListViewController.h"
#import "Property.h"
#import "Room.h"
#import <SVHTTPRequest/SVHTTPClient.h>
#import "RoomDetailViewController.h"
#import "SubmitResultsViewController.h"

@interface RoomListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *tableItems;
@property (nonatomic, strong) IBOutlet UITableView *tableView;


@end

@implementation RoomListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setProperty:(Property *)property
{
    _property = property;
    [self getRoomList];
}

- (void)getRoomList
{
    if (!self.property || !self.property.propertyId) {
        return;
    }
    SVHTTPClient *client = [SVHTTPClient sharedClient];
    NSString *getURL = [NSString stringWithFormat:@"https://crescendo.mockable.io/properties/%@/rooms", self.property.propertyId];
    [client GET:getURL parameters:nil completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        NSMutableArray *rooms = [NSMutableArray new];
        for (NSDictionary *dict in response) {
            Room *room = [Room roomFromData:dict];
            [rooms addObject:room];
        }
        self.property.rooms = [rooms copy];
        self.tableItems = self.property.rooms;
        [self.tableView reloadData];
    }];

}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toRoomDetail"]) {
        RoomDetailViewController *destVc = segue.destinationViewController;
        Room *selectedRoom = self.tableItems[[self.tableView indexPathForSelectedRow].row];
        destVc.room = selectedRoom;

        [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:YES];
    } else if ([segue.identifier isEqualToString:@"toSubmit"]) {
        SubmitResultsViewController *destVc = segue.destinationViewController;
        destVc.property = self.property;
    }
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
    static NSString *cellIdentifier = @"roomCell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];

    Room *room = self.tableItems[indexPath.row];
    cell.textLabel.text = room.name;
    cell.detailTextLabel.text = room.rating;

    return cell;
}

#pragma mark Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
