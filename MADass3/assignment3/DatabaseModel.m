//
//  DatabaseModel.m
//  assignment3
//
//  Created by Madala, Sarath Chandra on 10/31/18.
//  Copyright © 2018 Madala, Sarath Chandra. All rights reserved.
//

#import "DatabaseModel.h"
#import "Database+CoreDataClass.h"
#import "AppDelegate.h"

@implementation DatabaseModel

+ (NSManagedObjectContext *) getManagedObjectContext
{
    AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    return appDelegate.persistentContainer.viewContext;
}

+ (bool)addDeadline:(NSString *)courseID courseName:(NSString *)courseName semester: (NSString *)semester testName: (NSString *)testName dueDate: (NSDate *)dueDate
{
    //Get managed object context
    NSManagedObjectContext* context =[[self class] getManagedObjectContext];
    //Create a blank new record
    Database *db = (Database *)[NSEntityDescription insertNewObjectForEntityForName:@"Database" inManagedObjectContext:context];
    //Fill the new record
    db.courseID = courseID;
    db.courseName = courseName;
    db.semester = semester;
    [db setTestName:testName];
    db.dueDate = dueDate;
    
    //Save the new record
    NSError *error;
    if(![context save:&error])
    {
        return false;
    }
    else
    {
        return true;
    }
}
    
    + (NSMutableArray *)fetchFromDatabase
    {
        //Get managed object context
        NSManagedObjectContext* context =[[self class] getManagedObjectContext];
        // Define our table/entity to use
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Database" inManagedObjectContext:context];
        // Setup the fetch request
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:entity];

        // Define how we will sort the records
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"dueDate" ascending:YES];
        NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        [request setSortDescriptors:sortDescriptors];
        // Fetch the records and handle an error
        NSError *error;
        NSMutableArray *mutableFetchResults = [[context executeFetchRequest:request error:&error] mutableCopy];
        
        for(NSObject *obj in mutableFetchResults) {
            NSLog(@"%@", [obj valueForKey:@"courseID"]);
        }

        return mutableFetchResults;
    }

+ (bool)deleteWord:(NSString *)courseName testName: (NSString *)testName
{
    //Get managed object context
    NSManagedObjectContext* context =[[self class] getManagedObjectContext];
    // Define our table/entity to use
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Database" inManagedObjectContext:context];
    // Setup the fetch request
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"courseName=%@", courseName];
    [request setPredicate:predicate];
    NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"testName=%@", testName];
    [request setPredicate:predicate2];
    // Fetch the records and handle an error
    NSError *error;
    NSMutableArray *mutableFetchResults = [[context executeFetchRequest:request error:&error] mutableCopy];
    if(mutableFetchResults.count > 0)
    {
        NSManagedObject *managedObject = [mutableFetchResults objectAtIndex:0];
        [context deleteObject:managedObject];
        if (![context save:&error])
        {
            return false;
        }
    }
    return true;
}

+ (bool)Update:(NSDate *)dueDate courseName:(NSString *)courseName testName: (NSString *)testName {
    NSManagedObjectContext* context =[[self class] getManagedObjectContext];
    // Define our table/entity to use
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Database" inManagedObjectContext:context];
    // Setup the fetch request
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"courseName=%@", courseName];
    [request setPredicate:predicate];
    NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"testName=%@", testName];
    [request setPredicate:predicate2];
    // Fetch the records and handle an error
    NSError *error;
    NSMutableArray *mutableFetchResults = [[context executeFetchRequest:request error:&error] mutableCopy];
    if(mutableFetchResults.count > 0)
    {
        NSManagedObject *managedObject = [mutableFetchResults objectAtIndex:0];
        [managedObject setValue:dueDate forKey:@"dueDate"];
        if (![context save:&error])
        {
            return false;
        }
    }
    return true;
}

@end
