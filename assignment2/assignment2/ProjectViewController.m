//
//  ProjectViewController.m
//  assignment2
//
//  Created by Madala, Sarath Chandra on 10/4/18.
//  Copyright © 2018 Madala, Sarath Chandra. All rights reserved.
//

#import "ProjectViewController.h"

@interface ProjectViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *feedLabel;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
- (IBAction)saveBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *saveBtnOutlet;

@end

@implementation ProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _titleLabel.text = @"Enter Project score";
    
    NSUserDefaults* temp = [NSUserDefaults standardUserDefaults];
    if([temp integerForKey:@"Project"] != 0){
        NSInteger score;
        score = [temp integerForKey:@"Project"];
        _inputTextField.text = [NSString stringWithFormat:@"%ld", score];
        _feedLabel.text = @"Score saved";
        _feedLabel.hidden = false;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.inputTextField resignFirstResponder];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveBtn:(id)sender {

    if([_inputTextField.text  isEqual: @""]){
        _feedLabel.text = @"Please enter marks";
        UIColor *color = [UIColor redColor];
        [self.feedLabel setTextColor:color];
        _feedLabel.hidden = false;
    }else{
        NSString *inputString = _inputTextField.text;
        int input = [inputString intValue];
        NSLog(@"%d", input);
        NSUserDefaults *aScore = [NSUserDefaults standardUserDefaults];
        [aScore setInteger:input forKey:@"Project"];
        _feedLabel.text = @"Score saved";
        UIColor *color = [UIColor greenColor];
        [self.feedLabel setTextColor:color];
        _feedLabel.hidden = false;
    }
}
@end
