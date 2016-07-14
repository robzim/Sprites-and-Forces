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
- (IBAction)myRecordPressed:(UIButton *)sender;
- (IBAction)myStopPressed:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *myRecButton;
@property (weak, nonatomic) IBOutlet UIButton *myStopButton;
@property (weak, nonatomic) IBOutlet UIButton *myRecordingIndicator;
@property (weak, nonatomic) IBOutlet UIStackView *myScreenRecorderStackView;


- (IBAction)myShowTrailsButtonPressed:(UIButton *)sender;
- (IBAction)myHideTrailsButtonPressed:(UIButton *)sender;
- (IBAction)myShowForcesButtonPressed:(UIButton *)sender;
- (IBAction)myHideForcesButtonPressed:(UIButton *)sender;




- (IBAction)myIncreaseGravityButtonPressed:(UIButton *)sender;
- (IBAction)myDecreaseGravityButtonPressed:(UIButton *)sender;
- (IBAction)myResetGravityButtonPressed:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *myGravityStrength;


- (IBAction)myIncreaseVortexButtonPressed:(UIButton *)sender;
- (IBAction)myDecreaseVortexButtonPressed:(UIButton *)sender;
- (IBAction)myResetVortexButtonPressed:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *myVortexStrength;




- (IBAction)myMiddleButtonPressed:(UIButton *)sender;






@end
