//
//  DetailedViewController.m
//  assignment3
//
//  Created by Madala, Sarath Chandra on 10/31/18.
//  Copyright © 2018 Madala, Sarath Chandra. All rights reserved.
//

#import "DetailedViewController.h"
#import "DatabaseModel.h"

@interface DetailedViewController ()
@property (weak, nonatomic) IBOutlet UILabel *courseID;
@property (weak, nonatomic) IBOutlet UILabel *courseName;
@property (weak, nonatomic) IBOutlet UILabel *semester;
@property (weak, nonatomic) IBOutlet UILabel *testName;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *updateButton;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UILabel *dueDate;
- (IBAction)editDeadlineBtn:(id)sender;

- (IBAction)deleteDeadlineBtn:(id)sender;
- (IBAction)updateDeadlineBtn:(id)sender;
@end

@implementation DetailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _courseID.text = [_data valueForKey:@"courseID"];
    _courseName.text = [_data valueForKey:@"courseName"];
    _semester.text = [_data valueForKey:@"semester"];
    _testName.text = [_data valueForKey:@"testName"];
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"MM-dd-yyyy"];
    NSString *date = [df stringFromDate:[_data valueForKey:@"dueDate"]];
    _dueDate.text = date;

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)editDeadlineBtn:(id)sender {
    [_datePicker setHidden:false];
    [_editButton setHidden:true];
    [_updateButton setHidden:false];
}

- (IBAction)deleteDeadlineBtn:(id)sender {
    [DatabaseModel deleteWord:_courseName.text testName:_testName.text];
    //[self performSegueWithIdentifier:@"deleteToTable" sender:self];
    //[self dismissModalViewControllerAnimated:YES];
    [self.navigationController popViewControllerAnimated:true];
}

- (IBAction)updateDeadlineBtn:(id)sender {
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"MM-dd-yyyy"];
    NSString *updatedDate = [df stringFromDate:[_datePicker date]];
    _dueDate.text = updatedDate;
    
    [DatabaseModel Update:[_datePicker date] courseName: _courseName.text testName:_testName.text];
    
    [self.navigationController popViewControllerAnimated:true];
    
}


@end
