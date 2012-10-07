//
//  CustomCell.h
//  TaskTimer
//
//  Created by rbelford on 9/22/12.
//  Copyright (c) 2012 rbelford. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MasterViewController.h"

@interface CustomCell : UITableViewCell
{
    NSTimeInterval runningTotal, timeInterval;
    BOOL isRunning;
}
@property (nonatomic,retain) IBOutlet UILabel *stopWatchLabel;
@property (nonatomic,retain) IBOutlet UILabel *nameLabel;
@property (nonatomic,retain) IBOutlet UITextField *nameText;
@property (nonatomic,retain) NSTimer *stopWatchTimer;
@property (nonatomic,retain) NSDate *startDate;

- (IBAction)onStartStopPressed:(id)sender;
- (IBAction)onReturnPressed:(id)sender;
- (IBAction)onClearPressed:(id)sender;

@end
