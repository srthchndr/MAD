//
//  DeadlineCellTableViewCell.h
//  assignment3
//
//  Created by Madala, Sarath Chandra on 10/31/18.
//  Copyright © 2018 Madala, Sarath Chandra. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeadlineCellTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *courseNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *testNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *deadlineLabel;

@end

NS_ASSUME_NONNULL_END
