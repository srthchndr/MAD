//
//  ViewController.m
//  assignment3
//
//  Created by Madala, Sarath Chandra on 10/30/18.
//  Copyright © 2018 Madala, Sarath Chandra. All rights reserved.
//

#import "ViewController.h"
#import "DeadlineCellTableViewCell.h"
#import "DatabaseModel.h"
#import "Database+CoreDataClass.h"
#import "DetailedViewController.h"

@interface ViewController ()
- (IBAction)addDeadline:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated{
    data = [DatabaseModel fetchFromDatabase];
    NSLog(@"%@", data);
    [_tableView reloadData];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    DeadlineCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"deadlineCell" forIndexPath:indexPath];
    // Configure the cell...
    //cell.textLabel.text = [_dataArray objectAtIndex:indexPath.row];
    Database *db = [data objectAtIndex:indexPath.row];
    
    cell.courseNameLabel.text = [db valueForKey:@"courseName"];
    cell.testNameLabel.text = [db valueForKey:@"testName"];
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"MM-dd-yyyy"];
    NSString *date = [df stringFromDate:[db valueForKey:@"dueDate"]];
    
    cell.deadlineLabel.text = date;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return data.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Database *db = [data objectAtIndex:indexPath.row];
    singleData = db;
    NSLog(@"Hola Amigo: %@", [singleData valueForKey:@"courseName"]);
    [self performSegueWithIdentifier:@"tableToDetailed" sender:self];
}

- (IBAction)addDeadline:(id)sender {
    [self performSegueWithIdentifier:@"tableToAddDeadline" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue is to GameVC
    if ([[segue identifier] isEqualToString:@"tableToDetailed"])
    {
        // Get reference to GameVC
        DetailedViewController *detailed = [segue destinationViewController];
        
        NSLog(@"this is segue: %@", [singleData valueForKey:@"courseName"]);
        // Pass guess word to GameVC
        detailed.data = singleData;
    }
}

@end
