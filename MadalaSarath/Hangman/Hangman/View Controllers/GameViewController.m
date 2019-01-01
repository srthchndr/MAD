//
//  GameViewController.m
//  Hangman
//
//  Created by CSCI5737 Fall18 on 9/13/18.
//  Copyright © 2018 CSCI5737 Fall18. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *guessWordLabel;
- (IBAction)backButtonAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *hangmanImgView;
@property (weak, nonatomic) IBOutletCollection(UIButton) NSArray *btnCollection;
- (IBAction)btnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *hintButton;
- (IBAction)hintBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *hintLabel;

@end

@implementation GameViewController
//@synthesize guessWord;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _guessWordLabel.text = _guessWord;
    
    if([_level  isEqual: @"Easy"]){
        _successScore = 10;
        _failureScore = 5;
    }else if ([_level  isEqual: @"Medium"]){
        _successScore = 20;
        _failureScore = 7;
    }else if ([_level  isEqual: @"Medium"]){
        _successScore = 30;
        _failureScore = 10;
    }else{
        _successScore = 10;
        _failureScore = 5;
    }
    
    _titlesArray = [NSArray arrayWithObjects:@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z", nil];
    
    [self createHiddenWord];
    
    _loseAlert = [[UIAlertView alloc] initWithTitle:@"Sorry, You lost!" message:[@"Your word was: " stringByAppendingString :self.guessWord] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    _winAlert = [[UIAlertView alloc] initWithTitle:@"Congratulations! You Win!" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [self setupApplicationAudio];

}

- (void) setupApplicationAudio {
    // Gets the file system path to the sound to play.
    NSString *correctSoundFilePath = [[NSBundle mainBundle]pathForResource: @"lasersound" ofType: @"wav"];
    NSString *wrongSoundFilePath = [[NSBundle mainBundle]pathForResource: @"buzzer" ofType: @"wav"];
    // Converts the sound's file path to an NSURL object
    NSURL *correctURL = [[NSURL alloc] initFileURLWithPath: correctSoundFilePath];
    NSURL *wrongURL = [[NSURL alloc] initFileURLWithPath: wrongSoundFilePath];
    // Allow the app sound to continue to play when the screen is locked.
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error: nil];
    // Activates the audio session.
    NSError *activationError = nil;
    [[AVAudioSession sharedInstance] setActive: YES error: &activationError];
    // Instantiates the AVAudioPlayer object, initializing it with the sound
    _correctSoundPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: correctURL error: nil];
    _wrongSoundPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: wrongURL error: nil];
    // "Preparing to play" attaches to the audio hardware and ensures that playback
    //starts quickly when the user taps Play
    [_correctSoundPlayer prepareToPlay];
    [_wrongSoundPlayer prepareToPlay];
}


-(void)UpdateWordWithLetter:(unichar)letter {
    BOOL found = NO;
    for (int i = 0; i < [self.guessWord length]; i++) {
        if([self.guessWord characterAtIndex:i] == letter) {
            NSMutableString * newString = [[NSMutableString alloc] initWithString:_guessWordLabel.text];
            NSRange tempRange;
            tempRange.location = i;
            tempRange.length = 1;
            [newString replaceCharactersInRange:tempRange withString:[NSString stringWithFormat: @"%C", letter]];
            _guessWordLabel.text = newString;
            found = YES;
            [_correctSoundPlayer play];
        }
    }
    if(found == NO) {
        NSString *presentScore = _scoreLabel.text;
        totalScore = [presentScore intValue] - _failureScore;
        _scoreLabel.text = [NSString stringWithFormat:@"%i", totalScore];
        NSLog(@"%i",totalScore);
        [_wrongSoundPlayer play];
        
        _curGuessCount++;
        if(_curGuessCount <= 10) {
            _hangmanImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",_curGuessCount]];
        }
        else {
            _loseAlert.message = [NSString stringWithFormat: @"Your word was: %@", self.guessWord];
            [_loseAlert show];
        }
    }
    if(found == YES){
        NSString *presentScore = _scoreLabel.text;
        totalScore = [presentScore intValue] + _successScore;
        _scoreLabel.text = [NSString stringWithFormat:@"%i", totalScore];
        NSLog(@"%i",totalScore);
    }
    if ([self.guessWord caseInsensitiveCompare:self.guessWordLabel.text] == NSOrderedSame) {
        [_winAlert show];
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

- (IBAction)backButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}


- (IBAction)btnAction:(id)sender {
    int tag = ((UIButton *)sender).tag;
    NSString* letter = [_titlesArray objectAtIndex:tag];
    [self UpdateWordWithLetter:[letter characterAtIndex:0]];
    
    ((UIButton *)sender).enabled = false;
}

-(void) createHiddenWord {
    NSMutableString * newString = [[NSMutableString alloc] initWithString:self.guessWord];
    for (NSUInteger i = 0; i < [newString length]; i++) {
        NSRange tempRange;
        tempRange.location = i;
        tempRange.length = 1;
        [newString replaceCharactersInRange:tempRange withString:[NSString stringWithFormat: @"%s", "-"]];
    }
    _guessWordLabel.text = newString;
    _curGuessCount = 0;
    _hangmanImgView.image = [UIImage imageNamed:@"0.png"];
    for (UIButton *btnItem in _btnCollection) {
        btnItem.enabled = YES;
    }
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)hintBtnAction:(id)sender {
    char letter = '\0';
    NSLog(@"%@", _guessWordLabel.text);
    for(int i=0; i< [self.guessWord length]; i++){
        if([[_guessWordLabel.text substringWithRange:NSMakeRange(i, 1)] isEqual: @"-"]){
            letter = [self.guessWord characterAtIndex:i];
            NSLog(@"%c", letter);
            break;
        }
    }
    
    for (int i = 0; i < [self.guessWord length]; i++) {
        if([self.guessWord characterAtIndex:i] == letter) {
            NSMutableString * newString = [[NSMutableString alloc] initWithString:_guessWordLabel.text];
            NSRange tempRange;
            tempRange.location = i;
            tempRange.length = 1;
            [newString replaceCharactersInRange:tempRange withString:[NSString stringWithFormat: @"%c", letter]];
            _guessWordLabel.text = newString;
            [_correctSoundPlayer play];
        }
    }
    NSString *presentScore = _scoreLabel.text;
    totalScore = [presentScore intValue] - 30;
    _scoreLabel.text = [NSString stringWithFormat:@"%i", totalScore];
    _hintButton.enabled = false;
}
@end
