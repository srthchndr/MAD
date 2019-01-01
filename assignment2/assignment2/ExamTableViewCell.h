//
//  ExamTableViewCell.h
//  assignment2
//
//  Created by Madala, Sarath Chandra on 10/9/18.
//  Copyright © 2018 Madala, Sarath Chandra. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExamTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@end

NS_ASSUME_NONNULL_END
