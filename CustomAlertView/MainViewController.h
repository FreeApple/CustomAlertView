//
//  MainViewController.h
//  CustomAlertView
//
//  Created by Anthony Cornell on 4/17/12.
//  Copyright (c) 2012 iDevice Designs. All rights reserved.
//

#import "FlipsideViewController.h"

#import <CoreData/CoreData.h>

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate>{
    
    IBOutlet UIImageView *Robot;
}

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (IBAction)showInfo:(id)sender;
-(IBAction)popWithAction:(id)sender;
-(IBAction)pop:(id)sender;
-(IBAction)dynamicPop:(id)sender;
    
@end
