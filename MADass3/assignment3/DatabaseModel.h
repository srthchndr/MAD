//
//  DatabaseModel.h
//  assignment3
//
//  Created by Madala, Sarath Chandra on 10/31/18.
//  Copyright © 2018 Madala, Sarath Chandra. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DatabaseModel : NSObject

+ (bool)addDeadline:(NSString *)courseID courseName:(NSString *)courseName semester: (NSString *)semester testName: (NSString *)testName dueDate: (NSDate *)dueDate;
+ (NSMutableArray *)fetchFromDatabase;
+ (bool)deleteWord:(NSString *)courseName testName: (NSString *)testName;
+ (bool)Update:(NSDate *)dueDate courseName:(NSString *)courseName testName: (NSString *)testName;

@end

NS_ASSUME_NONNULL_END
