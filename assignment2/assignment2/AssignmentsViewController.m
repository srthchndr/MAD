//
//  AssignmentsViewController.m
//  assignment2
//
//  Created by Madala, Sarath Chandra on 10/4/18.
//  Copyright © 2018 Madala, Sarath Chandra. All rights reserved.
//

#import "AssignmentsViewController.h"
#import "TableViewCell.h"
#import "DetailedViewController.h"

@interface AssignmentsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation AssignmentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [self updateFunc];
    _tableView.reloadData;
}

- (void)updateFunc{
    NSUserDefaults* temp = [NSUserDefaults standardUserDefaults];
    marksArray = [[NSMutableArray alloc] init];
    
    assignmentArray = [[NSMutableArray alloc] initWithObjects:@"Assignment 1", @"Assignment 2", @"Assignment 3", @"Assignment 4", nil];
    for (int i=0; i<[assignmentArray count]; i++) {
        NSString* name = [assignmentArray objectAtIndex:i];
        NSInteger score = [temp integerForKey:name];
        [marksArray addObject:[NSString stringWithFormat:@"%ld", score]];
    }
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    [self updateFunc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return assignmentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"assignmentCell" forIndexPath:indexPath];

    cell.NameLabel.text = [assignmentArray objectAtIndex:indexPath.row];
    cell.MarksLabel.text = [marksArray objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *tName = [assignmentArray objectAtIndex:indexPath.row];
    
    testName = tName;
        
    [self performSegueWithIdentifier:@"assignments2Detailed" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"assignments2Detailed"])
    {
        DetailedViewController *detailedVC = [segue destinationViewController];

        detailedVC.testName = testName;
    }
}


@end
