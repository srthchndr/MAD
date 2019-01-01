//
//  ExamsViewController.m
//  assignment2
//
//  Created by Madala, Sarath Chandra on 10/4/18.
//  Copyright © 2018 Madala, Sarath Chandra. All rights reserved.
//

#import "ExamsViewController.h"
#import "ExamTableViewCell.h"
#import "DetailedViewController.h"

@interface ExamsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ExamsViewController

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
    
    examsArray = [[NSMutableArray alloc] initWithObjects:@"MidTerm", @"Final", nil];
    for (int i=0; i<[examsArray count]; i++) {
        NSString* name = [examsArray objectAtIndex:i];
        NSInteger score = [temp integerForKey:name];
        [marksArray addObject:[NSString stringWithFormat:@"%ld", score]];
    }
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
    return examsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ExamTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"examsCell" forIndexPath:indexPath];
    
    cell.titleLabel.text = [examsArray objectAtIndex:indexPath.row];
    cell.scoreLabel.text = [marksArray objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *tName = [examsArray objectAtIndex:indexPath.row];
    
    testName = tName;
    
    [self performSegueWithIdentifier:@"exams2Detailed" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"exams2Detailed"])
    {
        DetailedViewController *detailedVC = [segue destinationViewController];
        
        detailedVC.testName = testName;
    }
}

@end
