//
//  GradesViewController.m
//  assignment2
//
//  Created by Madala, Sarath Chandra on 10/4/18.
//  Copyright © 2018 Madala, Sarath Chandra. All rights reserved.
//

#import "GradesViewController.h"

@interface GradesViewController ()
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *gradeLabel;

@end

@implementation GradesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)viewWillAppear:(BOOL)animated{
    NSInteger midtermExamScore=0, finalExamScore = 0, assignmentsTotalScore = 0, projectScore, temp, totalAssignments = 4, totalExams = 2;
    double totalScore = 0.0;
    
    NSUserDefaults* tempDefault = [NSUserDefaults standardUserDefaults];
    
    projectScore = [tempDefault integerForKey:@"Project"];
    
    if([tempDefault integerForKey:@"MidTerm"] == 0){
        temp = 0;
        midtermExamScore += temp;
        totalExams--;
    }else{
        temp = [tempDefault integerForKey:@"MidTerm"];
        midtermExamScore += temp;
    }
    
    if([tempDefault integerForKey:@"Final"] == 0){
        temp = 0;
        finalExamScore += temp;
        totalExams--;
    }else{
        temp = [tempDefault integerForKey:@"Final"];
        finalExamScore += temp;
    }
    
    if([tempDefault integerForKey:@"Assignment 1"] == 0){
        temp = 0;
        assignmentsTotalScore += temp;
        totalAssignments--;
    }else{
        temp = [tempDefault integerForKey:@"Assignment 1"];
        assignmentsTotalScore += temp;
    }
    
    if([tempDefault integerForKey:@"Assignment 2"] == 0){
        temp = 0;
        assignmentsTotalScore += temp;
        totalAssignments--;
    }else{
        temp = [tempDefault integerForKey:@"Assignment 2"];
        assignmentsTotalScore += temp;
    }
    
    if([tempDefault integerForKey:@"Assignment 3"] == 0){
        temp = 0;
        assignmentsTotalScore += temp;
        totalAssignments--;
    }else{
        temp = [tempDefault integerForKey:@"Assignment 3"];
        assignmentsTotalScore += temp;
    }
    
    if([tempDefault integerForKey:@"Assignment 4"] == 0){
        temp = 0;
        assignmentsTotalScore += temp;
        totalAssignments--;
    }else{
        temp = [tempDefault integerForKey:@"Assignment 4"];
        assignmentsTotalScore += temp;
    }
    
    if(totalAssignments == 0){
        totalAssignments = 1;
    }
    
    
    totalScore = (assignmentsTotalScore*0.25)/totalAssignments + finalExamScore * 0.25 + midtermExamScore * 0.2 + projectScore * 0.3;
    
    _scoreLabel.text = [NSString stringWithFormat:@"Total Score: %.2f", totalScore];
    
    if(totalScore >= 91){
        _gradeLabel.text = @"A";
    }else if(totalScore >= 89 && totalScore <= 90.9){
        _gradeLabel.text = @"A-";
    }else if(totalScore >= 86 && totalScore <= 88.9){
        _gradeLabel.text = @"B+";
    }else if(totalScore >= 82 && totalScore <= 85.9){
        _gradeLabel.text = @"B";
    }else if(totalScore >= 79 && totalScore <= 81.9){
        _gradeLabel.text = @"B-";
    }else if(totalScore >= 76 && totalScore <= 78.9){
        _gradeLabel.text = @"C+";
    }else if(totalScore >= 72.0 && totalScore <= 75.9){
        _gradeLabel.text = @"C";
    }else if(totalScore >= 70.0 && totalScore <= 71.9){
        _gradeLabel.text = @"C-";
    }else if(totalScore >= 60.0 && totalScore <= 69.9){
        _gradeLabel.text = @"D";
    }else if(totalScore < 60.0){
        _gradeLabel.text = @"F";
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

@end
