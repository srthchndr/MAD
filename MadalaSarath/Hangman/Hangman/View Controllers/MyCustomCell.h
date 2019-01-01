//
//  MyCustomCell.h
//  Hangman
//
//  Created by CSCI5737 Fall18 on 10/4/18.
//  Copyright © 2018 CSCI5737 Fall18. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblMain;
@property (weak, nonatomic) IBOutlet UILabel *lblDescription;

@end
