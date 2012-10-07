//
//  CustomCell.m
//  TaskTimer
//
//  Created by rbelford on 9/22/12.
//  Copyright (c) 2012 rbelford. All rights reserved.
//

#import "CustomCell.h"
#import "MasterViewController.h"
extern NSMutableArray *_objects; // give acces to the task names arrray.
// Todo: figure out how to enter names from here into _objects.
@implementation CustomCell

@synthesize nameLabel;
@synthesize nameText;
@synthesize stopWatchLabel;
@synthesize stopWatchTimer;
@synthesize startDate;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) updateTimer // Called by onStartStopPressed.  I suppose oneClearPressed should call this too.
{
    NSDate *currentDate = [NSDate date];
    timeInterval = [currentDate timeIntervalSinceDate:startDate];
    timeInterval += runningTotal;  // total time since last clear
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    NSString *timeString=[dateFormatter stringFromDate:timerDate];
    stopWatchLabel.text = timeString;
}

- (IBAction)onStartStopPressed:(id)sender
{
    if (isRunning) { // stop timer
        isRunning = false;
        [sender setTitle:@"Start" forState:UIControlStateNormal];
        [stopWatchTimer invalidate];
        stopWatchTimer = nil;
        [self updateTimer];
        runningTotal = timeInterval;
        //NSLog(@"runningTotal: %f",runningTotal);
        
    } else { //start timer
        isRunning = true;
        [sender setTitle:@"Stop" forState:UIControlStateNormal];
        startDate = [NSDate date]; // timestamp of current run
        // Create a timer
        stopWatchTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                          target:self
                                                        selector:@selector(updateTimer)
                                                        userInfo:nil
                                                         repeats:YES];
    }
    
}

- (IBAction)onClearPressed:(id)sender
{
    if (!isRunning) { // Take action only if the stopwatch is stopped.
        stopWatchLabel.text = @"00:00:00";
        runningTotal = 0.0;
    }
}

// This is for the text field where the user changes the task name in a tableview cell.
// I haven't figured out how to put it in _objects - which row?
- (IBAction)onReturnPressed:(id)sender;
{
    nameLabel.text = nameText.text;
    if (self.selected) {
        NSLog(@"selected cell.");
    }
    NSLog(@"name: %@", [_objects objectAtIndex:0]);
    //NSIndexPath *indexPath = [super indexPathForSelectedRow];
    [_objects replaceObjectAtIndex:0 withObject:nameText.text];
    NSLog(@"name: %@", [_objects objectAtIndex:0]);
    nameText.text = @"";
    [sender resignFirstResponder];
}
@end
