//
//  ExamsViewController.h
//  assignment2
//
//  Created by Madala, Sarath Chandra on 10/4/18.
//  Copyright © 2018 Madala, Sarath Chandra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExamsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *examsArray;
    NSMutableArray *marksArray;
    NSString* testName;
}

@end
