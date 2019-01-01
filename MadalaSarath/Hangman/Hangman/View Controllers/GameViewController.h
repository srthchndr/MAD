//
//  GameViewController.h
//  Hangman
//
//  Created by CSCI5737 Fall18 on 9/13/18.
//  Copyright © 2018 CSCI5737 Fall18. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


@interface GameViewController : UIViewController <UIAlertViewDelegate>

{
    int _curGuessCount;
    UIAlertView* _loseAlert;
    UIAlertView* _winAlert;
    NSArray* _titlesArray;
    int _successScore;
    int _failureScore;
    int totalScore;
    
    AVAudioPlayer* _correctSoundPlayer;
    AVAudioPlayer* _wrongSoundPlayer;


}

@property (nonatomic, retain) NSString* guessWord;
@property (nonatomic, retain) NSString* level;

@end
