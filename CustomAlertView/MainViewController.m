//
//  MainViewController.m
//  CustomAlertView
//
//  Created by Anthony Cornell on 4/17/12.
//  Copyright (c) 2012 iDevice Designs. All rights reserved.
//

#import "MainViewController.h"
#import "CustomAlertView.h"


@implementation MainViewController

@synthesize managedObjectContext = _managedObjectContext;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
 
    
    }


-(IBAction)popWithAction:(id)sender{
    
    [CustomAlertView showCustomPop:CustomAlertViewTypeDouble inView:self.view WithFrame:self.view.frame Title:@"Action Alert" Message:@"Custom action type alert. By FreeAppl3, iDeviceDesignsProduct " actionButtonTitle:@"Do Something" action:@selector(doSomthing) cancelButtonTitle:@"Cancel"];
    
    
}
-(IBAction)pop:(id)sender{
    
    [CustomAlertView showCustomPop:CustomAlertViewTypeSingle inView:self.view WithFrame:self.view.frame Title:@"Info Alert" Message:@"Custom info type alert. By FreeAppl3, iDeviceDesignsProduct" actionButtonTitle:nil action:nil cancelButtonTitle:@"Cancel"];
    
    
}

-(IBAction)dynamicPop:(id)sender{
    
    [CustomAlertView showDynamicCustomPop:CustomAlertViewTypeTriple delegate:self inView:self.view WithTitle:@"Dynamic Alert" Message:@"Custom dynamic type alert. This is not done yet but almost there. This will allow you to add unlimeted amount of text inside the view as it dynamically grows with text. Will be an open source project if anyone has suggestion please feel free By FreeAppl3, iDeviceDesignsProduct" cancelButtonTitle:@"OK" actionButtonTitles:nil, nil];
    
    
}




-(void)doSomthing{
    
    [UIView beginAnimations:@"slide" context:nil];
    [UIView setAnimationDuration:0.5];
    CGRect frame = [Robot frame];
    frame.origin.y = -300;
    frame.size.width = 200;
    frame.size.height = 300;
    Robot.frame = frame;
    [UIView commitAnimations];
    
    [self performSelector:@selector(resetView) withObject:self
               afterDelay:0.5];
    
}


-(void)resetView{
    
    [UIView beginAnimations:@"slide" context:nil];
    [UIView setAnimationDuration:0.5];
    CGRect frame = [Robot frame];
    frame.origin.y = +210;
    frame.size.width = 150;
    frame.size.height = 250;
    Robot.frame = frame;
    [UIView commitAnimations];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)showInfo:(id)sender
{    
     

    FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideViewController" bundle:nil];
    controller.delegate = self;
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:controller animated:YES];
   
}

@end
