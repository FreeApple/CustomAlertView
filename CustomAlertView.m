//
//  CustomAlertView.m
//  PreviewMaker
//
//  Created by Anthony Cornell on 4/15/12.
//  Copyright (c) 2012 iDevice Designs. All rights reserved.
//

#import "CustomAlertView.h"

#define FONT_SIZE 14.0f
#define CUSTOM_POP_WIDTH 280.0f
#define CUSTOM_POP_CONTENT_MARGIN 10.0f


@interface CustomAlertView (PrivateMethods)
@property (nonatomic, assign) CustomAlertViewType type;
+ (CustomAlertView*) Animations;
@end

@interface  CustomAlertViewDelegate

+(CustomAlertViewDelegate*)delegate;

@end

@implementation CustomAlertView

@synthesize alertCancel,alertAction,alertCancelAlone,delegate,alertCancelTxt,alertDetailText,alertActionTitle,alertCancelAloneTxt,AlertText,customPop,butttons,butttonLabels,alertButtonView;

@synthesize numberOfButtons;

@synthesize bigButtonView;

@synthesize superFrame;

- (id)initWithFrame:(CGRect)frame
{
    NSLog(@"init with frame %@",frame);
    self = [super initWithFrame:frame];
    if (self) {
        [self setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
    }
    return self;
}

-(void)awakeFromNib{
    printf("debug B\n");

}

+(CustomAlertViewDelegate*)delegate{
    
    CustomAlertView *alert = [[CustomAlertView alloc] init];
    
    
    id delegate = alert.delegate;
    
    return delegate;
    
}




-(void) setType:(CustomAlertViewType)type{
    

    
    UIImage*pressedAction = [UIImage imageNamed:@"AlertActionButtonDown@2x.png"];
    [alertAction setImage:pressedAction forState:UIControlStateHighlighted];
    
    UIImage*pressedCancel = [UIImage imageNamed:@"AlertButtonCancelDown@2x.png"];
    [alertCancel setImage:pressedCancel forState:UIControlStateHighlighted];
    
    
    
    UIImage*pressedLoneCancel = [UIImage imageNamed:@"AlertButtonCancelDown@2x.png"];
    [alertCancelAlone setImage:pressedLoneCancel forState:UIControlStateHighlighted];
    
   
    
    if (type == CustomAlertViewTypeSingle) {
        [alertActionTitle setHidden:YES];
        [alertAction  setHidden:YES];
        
        [alertCancelTxt  setHidden:YES];
        [alertCancel  setHidden:YES];
        
        
        [alertCancelAlone setHidden:NO];
        [alertCancelAloneTxt setHidden:NO];
        
   NSLog(@"setting up custom alert single");
        
        
    }    
    
    if (type == CustomAlertViewTypeDouble) {
        
        [alertActionTitle setHidden:NO];
        [alertAction  setHidden:NO];
        
        [alertCancelTxt  setHidden:NO];
        [alertCancel  setHidden:NO];    
        
        [alertCancelAlone setHidden:YES];
        [alertCancelAloneTxt setHidden:YES];
        
        NSLog(@"setting up custom alert double");        
    }
    
    
    
    
    if (type == CustomAlertViewTypeTriple) {
       
        [alertActionTitle setHidden:YES];
        [alertAction  setHidden:YES];
        
        [alertCancelTxt  setHidden:YES];
        [alertCancel  setHidden:YES];    
        
        [alertCancelAlone setHidden:YES];
        [alertCancelAloneTxt setHidden:YES];
        
               
    }
}





+(void)showCustomPop:(CustomAlertViewType)type inView:(UIView*)view WithFrame:(CGRect)frame Title:(NSString *)title Message:(NSString *)message  actionButtonTitle:(NSString*)actionTitle action:(void*)sel cancelButtonTitle:(NSString *)cancelTitle{
    
    
    NSLog(@"setting up custom alert");
    
    //Set up alertView
    
 
    CustomAlertView *panel = [CustomAlertView Animations];
    
    panel.frame = frame;
    [panel.alertAction addTarget:nil action:sel forControlEvents:UIControlEventTouchUpInside];
    
    panel.AlertText.text = title;
     panel.alertDetailText.text = message;
     panel.alertActionTitle.text = actionTitle;
     panel.alertCancelTxt.text = cancelTitle; 
    
    if ([actionTitle length] == 0) {
              panel.alertCancelAloneTxt.text = cancelTitle;
    }
    
   
    
    if ([[UIDevice currentDevice]orientation] == UIInterfaceOrientationLandscapeLeft){
        //do somthing or rather
        panel.customPop.frame = CGRectMake(frame.origin.x+80, frame.origin.y+20, 320, 200);
        NSLog(@"landscape left");
    }
    if ([[UIDevice currentDevice]orientation] == UIInterfaceOrientationLandscapeRight){
        //do somthing or rather
    panel.customPop.frame = CGRectMake(frame.origin.x+85, frame.origin.y+20, 320, 200);
        NSLog(@"landscape right");
    }
    if ([[UIDevice currentDevice]orientation] == UIInterfaceOrientationPortrait){
        //do somthing or rather
       panel.customPop.frame = CGRectMake(0, frame.origin.y+85, 320, 200);
        NSLog(@"portiat");
    }

    [panel setType:type];

  
    panel.superFrame = frame;
    
    [view addSubview:panel]; 
}



//TODO 
//             Finish dynamic height. Top label acting crazy!!! Fine tune
//___________________________________________________________________________________


+(void)showDynamicCustomPop:(CustomAlertViewType)type delegate:(id)delegate inView:(UIView *)view WithTitle:(NSString *)title Message:(NSString *)message cancelButtonTitle:(NSString *)cancelTitle actionButtonTitles:(NSMutableArray *)actionTitles, ...{
    
    //only universal code in here is phesable
    
    CustomAlertView *panel = [CustomAlertView Animations];
    
    
    panel.AlertText.text = title;
    panel.alertCancelTxt.text = cancelTitle; 
    
    
    
    
    NSString *str = message;
    
    CGSize constraint = CGSizeMake(CUSTOM_POP_WIDTH - (CUSTOM_POP_CONTENT_MARGIN * 2), 20000.0f);
    
    CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    
    CGRect lblFrame = [panel.AlertText frame];
  
    
    
    
    [panel.alertDetailText setFrame:CGRectMake(30, lblFrame.origin.y +5, CUSTOM_POP_WIDTH - (CUSTOM_POP_CONTENT_MARGIN * 2), MAX(size.height, 44.0f))];    
    [panel.alertDetailText setText:str];
    CGFloat height = MAX(size.height, 44.0f);
    
    
    CGRect frame = [panel.customPop frame];
    frame.size.height = height + (CUSTOM_POP_CONTENT_MARGIN * 2 +80); 
    // frame.origin = view.center;
    panel.customPop.frame = frame;
    
    
    
    CGRect buttonFrame = [panel.alertButtonView frame];
    buttonFrame.origin.y = height + (CUSTOM_POP_CONTENT_MARGIN * 2); 
    panel.alertButtonView.frame = buttonFrame;
    
    
    panel.butttons = [[NSMutableArray alloc] initWithObjects:actionTitles, nil];
    
    
    
    
    [panel.alertAction addTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
    
    
    
    if ([actionTitles count] == 0) {
        
        NSLog(@"type single");
        [panel setType:CustomAlertViewTypeSingle];
    }
    if ([actionTitles count] == 1) {
        NSLog(@"type double");
        [panel setType:CustomAlertViewTypeDouble];
    }
    if ([actionTitles count] ==2) {
        NSLog(@"type triple... set up two action buttons");
        //since indexes start at 0 here is our first bigbutton view with only two action buttons
        
        //start set up here for dynamic view
        
        [panel.alertButtonView removeFromSuperview];
        
        CGRect buttonFrame = [panel.bigButtonView frame];
        buttonFrame.origin.y = height + (CUSTOM_POP_CONTENT_MARGIN * 2); 
        panel.bigButtonView.frame = buttonFrame;
        
        [panel.customPop addSubview:panel.bigButtonView];
        
        CGRect frame = [panel.customPop frame];
        
        
        frame.size.height = height + (CUSTOM_POP_CONTENT_MARGIN * 2 +80); 
        panel.customPop.frame = frame;
        
        
        [panel setType:CustomAlertViewTypeTriple];
    }
    if ([actionTitles count] == 3) {
        NSLog(@"set up 3 action button");
        //TODO SET UP 3 ACTION BUTTONS
    }
    
    
    
    [panel addButtonWithTitle:actionTitles];
    
        
    [view addSubview:panel]; 
    
    
    
    
}




//TODO 
//             Finish setting type and adding new button view
//___________________________________________________________________________________



- (NSInteger)addButtonWithTitle:(NSMutableArray *)title{
    
    NSLog(@"Button Titles %@",title);
 
    CustomAlertView *panel = [CustomAlertView Animations];

    
   
    panel.butttonLabels = [[NSMutableArray alloc] init];
    [panel.butttonLabels addObjectsFromArray:title];
    

    return numberOfButtons;
}











+(CustomAlertView*) Animations
{
    CustomAlertView *panel =  (CustomAlertView*) [[[UINib nibWithNibName:@"CustomAlertView" bundle:nil] 
                                                   instantiateWithOwner:self options:nil] objectAtIndex:0];
    
    CAKeyframeAnimation* popInAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    
    popInAnimation.duration = 0.25;
    popInAnimation.values = [NSArray arrayWithObjects:
                             [NSNumber numberWithFloat:0.6],
                             [NSNumber numberWithFloat:1.1],
                             [NSNumber numberWithFloat:.9],
                             [NSNumber numberWithFloat:1],
                             nil];
    popInAnimation.keyTimes = [NSArray arrayWithObjects:
                               [NSNumber numberWithFloat:0.0],
                               [NSNumber numberWithFloat:0.6],
                               [NSNumber numberWithFloat:0.8],
                               [NSNumber numberWithFloat:1.0], 
                               nil];    
    
    
    [panel.customPop.layer addAnimation:popInAnimation forKey:@"transform.scale"]; 
    [UIView commitAnimations];     
      
    return panel;
}


+(CustomAlertView*) Single
{
    CustomAlertView *panel =  (CustomAlertView*) [[[UINib nibWithNibName:@"CustomAlertView" bundle:nil] 
                                                   instantiateWithOwner:self options:nil] objectAtIndex:0];
    
    CAKeyframeAnimation* popInAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    
    popInAnimation.duration = 0.25;
    popInAnimation.values = [NSArray arrayWithObjects:
                             [NSNumber numberWithFloat:0.6],
                             [NSNumber numberWithFloat:1.1],
                             [NSNumber numberWithFloat:.9],
                             [NSNumber numberWithFloat:1],
                             nil];
    popInAnimation.keyTimes = [NSArray arrayWithObjects:
                               [NSNumber numberWithFloat:0.0],
                               [NSNumber numberWithFloat:0.6],
                               [NSNumber numberWithFloat:0.8],
                               [NSNumber numberWithFloat:1.0], 
                               nil];    
    
    
    [panel.customPop.layer addAnimation:popInAnimation forKey:@"transform.scale"]; 
    [UIView commitAnimations];     
    
    return panel;
}






-(IBAction)removeCustomPop:(id)sender{
    
    NSLog(@"removing up custom alert");
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(removeAlertView)];
    self.customPop.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    [UIView commitAnimations];
    
}

-(void)removeAlertView{
    
    [self removeFromSuperview];
    
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    if ([defaults boolForKey:@"rotation"] == YES) {   
        
        
        if ([[UIDevice currentDevice]orientation] == UIInterfaceOrientationLandscapeLeft){
            //do somthing or rather
            self.customPop.frame = CGRectMake(superFrame.origin.x+100, superFrame.origin.y+20, 320, 200);
            NSLog(@"should auto rotate landscape left");
        }
        if ([[UIDevice currentDevice]orientation] == UIInterfaceOrientationLandscapeRight){
            //do somthing or rather
            self.customPop.frame = CGRectMake(superFrame.origin.x+100, superFrame.origin.y+20, 320, 200);
            NSLog(@"should auto rotate  landscape right");
        }
        if ([[UIDevice currentDevice]orientation] == UIInterfaceOrientationPortrait){
            //do somthing or rather
            self.customPop.frame = CGRectMake(0, superFrame.origin.y+80, 320, 200);
            NSLog(@"should auto rotate  portiat");
        }   
        // Return YES for supported orientations
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
        
    }
    else{
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    }
}



@end
