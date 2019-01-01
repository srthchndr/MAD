//
//  ViewController.m
//  segmentedControl
//
//  Created by Madala, Sarath Chandra on 9/10/18.
//  Copyright © 2018 Madala, Sarath Chandra. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *inputErr;
@property (weak, nonatomic) IBOutlet UILabel *btnErr;
@property (weak, nonatomic) IBOutlet UITextField *inputTextbox;
@property (weak, nonatomic) IBOutlet UITextField *outputTextbox;
- (IBAction)btnSort:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)segmentChange:(id)sender{
    //Segment actions goes here
    NSString *title = [segment titleForSegmentAtIndex:[segment selectedSegmentIndex]];
    [label setText:[NSString stringWithFormat:@"Enter %@s to sort", title]];
    
    _inputTextbox.text = @"";
    _outputTextbox.text = @"";
    
    if([segment selectedSegmentIndex] == 2){
        [_inputErr setHidden:FALSE];
        [_inputErr setText:[NSString stringWithFormat:@"Enter date in this format: YYYY/MM/DD"]];
    }
    else{
        [_inputErr setHidden:TRUE];
    }
}

- (IBAction)btnSort:(id)sender{
    
    //Take input string
    NSString *string = _inputTextbox.text;
    //Remove spaces
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"%@",string);
    
    if([segment selectedSegmentIndex] == 0){

        //String to array
        NSMutableArray<NSNumber *> *arr = [[string componentsSeparatedByString:@","] mutableCopy];
        NSLog(@"temp=%@",arr);
        
        int numLength = (int)[arr count];
        for (int i = 0; i < numLength-1; i++)
        {
            for(int j = i+1; j < numLength; j++)
            {
                NSNumber *temp=[arr objectAtIndex:i];
                int first =(int)[temp integerValue];
                
                NSNumber *temp1=[arr objectAtIndex:j];
                int second =(int)[temp1 integerValue];
                
                if(first > second)
                {
                    [arr replaceObjectAtIndex:j withObject:temp];
                    [arr replaceObjectAtIndex:i withObject:temp1];
                }
            }
        }
        
        NSString * result = [[arr valueForKey:@"description"] componentsJoinedByString:@", "];
        
        _outputTextbox.text = result;
    }
    else if([segment selectedSegmentIndex] == 1){
        
        //String to array
        NSMutableArray<NSString *> *arr = [[string componentsSeparatedByString:@","] mutableCopy];
        NSLog(@"temp=%@",arr);
        
        [arr sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        
        NSString * result = [[arr valueForKey:@"description"] componentsJoinedByString:@", "];
        
        _outputTextbox.text = result;
    }
    else{
        
        NSMutableArray *arr = [[string componentsSeparatedByString:@","] mutableCopy];
        NSLog(@"temp=%@",arr);
        
        /**/
        
        int numLength = (int)[arr count];
        for (int i = 0; i < numLength-1; i++)
        {
            for(int j = i+1; j < numLength; j++)
            {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy/MM/dd"];
                
                NSString *temp=[arr objectAtIndex:i];
                NSDate *date = [formatter dateFromString:temp];
                
                NSString *temp1=[arr objectAtIndex:j];
                NSDate *date1 = [formatter dateFromString:temp1];
                
                
                
                
                if ([date compare:date1] == NSOrderedDescending) {
                    NSLog(@"%@ is later than %@", [arr objectAtIndex:i], [arr objectAtIndex:j]);
                    [arr replaceObjectAtIndex:j withObject:temp];
                    [arr replaceObjectAtIndex:i withObject:temp1];
                } else if ([date compare:date1] == NSOrderedAscending) {
                    NSLog(@"%@ is earlier than %@", [arr objectAtIndex:i], [arr objectAtIndex:j]);
                } else{
                    NSLog(@"dates are equal");
                }
            }
        }
        
        NSString * result = [[arr valueForKey:@"description"] componentsJoinedByString:@", "];
        
        _outputTextbox.text = result;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == _inputTextbox) {
        [_inputTextbox resignFirstResponder];
    }
    return YES;
}

@end
