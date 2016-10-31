//
//  GameViewController.h
//  Sprites and Forces
//

//  Copyright (c) 2014 Robert Zimmelman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import <ReplayKit/ReplayKit.h>

@interface GameViewController : UIViewController<RPPreviewViewControllerDelegate, RPScreenRecorderDelegate>
@property RPPreviewViewController *myReplayPreviewController;
@property RPScreenRecorder *myReplayScreenRecorder;



- (IBAction)myTrailsButtonPressed:(UIButton *)sender;
- (IBAction)myColorsButtonPressed:(UIButton *)sender;
- (IBAction)mySpaceButtonPressed:(UIButton *)sender;
- (IBAction)myTexturesButtonPressed:(UIButton *)sender;




- (IBAction)myRecordPressed:(UIButton *)sender;
- (IBAction)myStopPressed:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *myRecButton;
@property (weak, nonatomic) IBOutlet UIButton *myStopButton;
@property (weak, nonatomic) IBOutlet UIButton *myRecordingIndicator;
@property (weak, nonatomic) IBOutlet UIStackView *myScreenRecorderStackView;




- (IBAction)myTrailsSwitchValueChanged:(id)sender;
- (IBAction)myForcesSwitchValueChanged:(id)sender;


- (IBAction)myBottomControlValueChanged:(UISegmentedControl *)sender;


@property (weak, nonatomic) IBOutlet UISwitch *myTrailsSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *myForcesSwitch;




- (IBAction)myResetGravityButtonPressed:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *myGravityStrength;
@property (weak, nonatomic) IBOutlet UIStepper *myGravityStepper;


@property (weak, nonatomic) IBOutlet UIStepper *myVortexStepper;
- (IBAction)myVortexStepperPressed:(UIStepper *)sender;
- (IBAction)myGravityStepperPressed:(UIStepper *)sender;
- (IBAction)myResetVortexButtonPressed:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *myVortexStrength;







@end
