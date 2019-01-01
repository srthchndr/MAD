//
//  AppDelegate.h
//  Hangman
//
//  Created by CSCI5737 Fall18 on 9/13/18.
//  Copyright © 2018 CSCI5737 Fall18. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

