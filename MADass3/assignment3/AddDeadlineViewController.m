//
//  AddDeadlineViewController.m
//  assignment3
//
//  Created by Madala, Sarath Chandra on 10/31/18.
//  Copyright © 2018 Madala, Sarath Chandra. All rights reserved.
//

#import "AddDeadlineViewController.h"
#import "DatabaseModel.h"

@interface AddDeadlineViewController ()
@property (weak, nonatomic) IBOutlet UITextField *courseIDTextfield;
@property (weak, nonatomic) IBOutlet UITextField *courseNameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *semesterTextfield;
@property (weak, nonatomic) IBOutlet UITextField *testNameTextfield;
@property (weak, nonatomic) IBOutlet UIDatePicker *datepicker;
- (IBAction)addDeadlineButton:(id)sender;

@end

@implementation AddDeadlineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addDeadlineButton:(id)sender {
    [DatabaseModel addDeadline: self.courseIDTextfield.text courseName: self.courseNameTextfield.text semester: self.semesterTextfield.text testName: self.testNameTextfield.text dueDate:[self.datepicker date]];
    /*self.courseIDTextfield.text = @"";
    self.courseNameTextfield.text = @"";
    self.semesterTextfield.text = @"";
    self.testNameTextfield.text = @"";
    [self.datepicker reloadInputViews];*/
    [self.navigationController popViewControllerAnimated:true];
}


@end
