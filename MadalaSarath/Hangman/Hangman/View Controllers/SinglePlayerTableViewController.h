//
//  SinglePlayerTableViewController.h
//  Hangman
//
//  Created by CSCI5737 Fall18 on 9/27/18.
//  Copyright © 2018 CSCI5737 Fall18. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SinglePlayerTableViewController : UITableViewController
{
    NSMutableArray* _dataArray;
    NSMutableArray* _descArray;
    NSString* _guessWord;
    NSString* _level;

}

@end
