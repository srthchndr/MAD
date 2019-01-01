//
//  ViewController.h
//  segmentedControl
//
//  Created by Madala, Sarath Chandra on 9/10/18.
//  Copyright © 2018 Madala, Sarath Chandra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>{
    IBOutlet UISegmentedControl *segment;
    IBOutlet UILabel *label;
}
- (IBAction)segmentChange:(id)sender;

@end

