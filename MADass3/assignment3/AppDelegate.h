//
//  AppDelegate.h
//  assignment3
//
//  Created by Madala, Sarath Chandra on 10/30/18.
//  Copyright © 2018 Madala, Sarath Chandra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

