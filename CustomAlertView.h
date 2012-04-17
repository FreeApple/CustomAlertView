//
//  CustomAlertView.h
//  PreviewMaker
//
//  Created by Anthony Cornell on 4/15/12.
//  Copyright (c) 2012 iDevice Designs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@protocol CustomAlertViewDelegate <NSObject>
@optional

-(id)CustomAlertClickedButton:(UIButton *)abutton;
@end


#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

typedef enum CustomAlertView_
{    
    CustomAlertViewTypeSingle,
    CustomAlertViewTypeDouble,
    CustomAlertViewTypeTriple,
} CustomAlertViewType;



@interface CustomAlertView : UIView {
      
@private
    id <CustomAlertViewDelegate> _delegate;   
    
    UIImageView *popBG;
    
    NSMutableArray *butttons;
     NSMutableArray *butttonLabels;
    
    IBOutlet UILabel *AlertText;
    IBOutlet UILabel *alertDetailText;
    IBOutlet UILabel *alertActionTitle;
    IBOutlet UILabel *alertCancelTxt;
    IBOutlet UILabel *alertCancelAloneTxt;
    IBOutlet UIView *alertButtonView;
    IBOutlet UIButton *alertAction;
    IBOutlet UIButton *alertCancel;
    IBOutlet UIButton *alertCancelAlone;    
    IBOutlet UIView *customPop;

    
    CGRect superFrame;
    
    IBOutlet UIView *bigButtonView;
    IBOutlet UIButton *bigButton1;
    IBOutlet UIButton *bigButton2;
    IBOutlet UIButton *bigButton3;
    IBOutlet UIButton *bigCancel;
    
    IBOutlet UILabel *bigLabel1;
    IBOutlet UILabel *bigLabel2;
    IBOutlet UILabel *bigLabel3;
    IBOutlet UILabel *cancelLabel;
    
  
    

}

@property (nonatomic, assign) CGRect superFrame;
@property (nonatomic, retain) UIButton *alertCancel;
@property (nonatomic, retain) UIButton *alertAction;
@property (nonatomic, retain)UILabel *alertCancelAloneTxt;
@property (nonatomic, retain)UILabel *alertCancelTxt;
@property (nonatomic, retain)UILabel *alertActionTitle;
@property (nonatomic, retain)UILabel *alertDetailText;
@property (nonatomic, retain)UILabel *AlertText;
@property (nonatomic, retain) UIButton *alertCancelAlone;
@property (nonatomic, retain)UIView *customPop;
@property (nonatomic, retain) NSMutableArray *butttons;
@property (nonatomic, retain) NSMutableArray *butttonLabels;
@property (nonatomic, retain) UIView *alertButtonView;


@property (nonatomic, retain)UIView *bigButtonView;






- (NSInteger)addButtonWithTitle:(NSMutableArray *)title;    // returns index of button. 0 based.
@property(nonatomic,readonly) NSInteger numberOfButtons;


@property (nonatomic, retain) id <CustomAlertViewDelegate> delegate;


-(IBAction)removeCustomPop:(id)sender;

+(void)showCustomPop:(CustomAlertViewType)type inView:(UIView*)view WithFrame:(CGRect)frame Title:(NSString *)title Message:(NSString *)message  actionButtonTitle:(NSString*)actionTitle action:(void*)sel cancelButtonTitle:(NSString *)cancelTitle;

+(void)showDynamicCustomPop:(CustomAlertViewType)type delegate:(id)delegate inView:(UIView *)view WithTitle:(NSString *)title Message:(NSString *)message cancelButtonTitle:(NSString *)cancelTitle actionButtonTitles:(NSMutableArray *)actionTitles, ... NS_REQUIRES_NIL_TERMINATION ;



@end
