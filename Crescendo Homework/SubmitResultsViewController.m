//
//  SubmitResultsViewController.m
//  Crescendo Homework
//
//  Created by Kent McCullough on 11/3/15.
//  Copyright © 2015 Kent McCullough. All rights reserved.
//

#import "SubmitResultsViewController.h"
#import "Property.h"
#import <SVHTTPRequest/SVHTTPClient.h>

@interface SubmitResultsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITextField *emailField;

@property (nonatomic, strong) NSArray *tableItems;

@end

@implementation SubmitResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableItems = @[ @"Yes", @"No", ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)submitResults
{
    NSString *email = self.emailField.text ?: @"";
    BOOL shouldContact = self.tableView.indexPathForSelectedRow.row == 0; // will default to true if no cell is selected.

    SVHTTPClient *client = [SVHTTPClient sharedClient];
    client.sendParametersAsJSON = YES;
    NSString *postURL = @"https://crescendo.mockable.io/responses";

    NSDictionary *params = @{
                             @"property" : [self.property dictionaryRepresenation],
                             @"contactEmail" : email,
                             @"shouldContact" : shouldContact ? @"true" : @"false",
                             };
    NSLog(@"params = %@", params);
    [client POST:postURL parameters:params completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        NSLog(@"response = %@", response);

    }];

}

- (IBAction)submitButtonTapped:(id)sender
{
    [self submitResults];
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
    static NSString *cellIdentifier = @"cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];

    cell.textLabel.text = self.tableItems[indexPath.row];

    return cell;
}

#pragma mark Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
