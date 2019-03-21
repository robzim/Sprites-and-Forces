//
//  GameViewController.m
//  Sprites and Forces
//
//  Created by Robert Zimmelman on 12/30/14.
//  Copyright (c) 2014 Robert Zimmelman. All rights reserved.
//


float myGStrength = 1.0;
float myVStrength = 10.0;
float myVDuration = 5000.0;

#import "GameViewController.h"
#import "GameScene.h"


SKScene *myScene2;
SKView *myView2;

@implementation SKScene (Unarchive)


+ (instancetype)unarchiveFromFile:(NSString *)file {
    /* Retrieve scene file path from the application bundle */
    NSString *nodePath = [[NSBundle mainBundle] pathForResource:file ofType:@"sks"];
    /* Unarchive the file to an SKScene object */
    NSData *data = [NSData dataWithContentsOfFile:nodePath
                                          options:NSDataReadingMappedIfSafe
                                            error:nil];
    NSKeyedUnarchiver *arch = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    [arch setClass:self forClassName:@"SKScene"];
    SKScene *scene = [arch decodeObjectForKey:NSKeyedArchiveRootObjectKey];
    [arch finishDecoding];
    myScene2 = scene;
    return scene;
}

@end




@implementation GameViewController

@synthesize myReplayPreviewController;
@synthesize myReplayScreenRecorder;


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = NO;
    skView.showsNodeCount = NO;
    /* Sprite Kit applies additional optimizations to improve rendering performance */
    skView.ignoresSiblingOrder = YES;
    
    // Create and configure the scene.
    GameScene *scene = [GameScene unarchiveFromFile:@"GameScene"];
    //    scene.scaleMode = SKSceneScaleModeAspectFill;
    //    [scene setBackgroundColor:[UIColor lightGrayColor]];
    // Present the scene.
//    myReplayScreenRecorder = [RPScreenRecorder sharedRecorder];
//    // hide the record indicator when the recorder isn't recording
//    [_myRecordingIndicator setHidden:!myReplayScreenRecorder.isRecording];
//    // hide the record button when the recorder is recording
//    [_myRecButton setHidden:myReplayScreenRecorder.isRecording];
//    [_myStopButton setHidden:!myReplayScreenRecorder.isRecording];
//
//    [myReplayScreenRecorder setDelegate:self];
//
//    [_myScreenRecorderStackView setHidden:!myReplayScreenRecorder.isAvailable];
//    NSLog(@"myReplayScreenRecorder %c",myReplayScreenRecorder.recording);
    [skView presentScene:scene];
    myView2 = skView;

    
    
    // set the two top labels correctly
    
}



- (IBAction)myTrailsButtonPressed:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"droptrails" object:self];
}


- (IBAction)mySpaceButtonPressed:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"dropspaceobjects" object:self];
}


-(void)myTexturesButtonPressed:(UIButton *)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"droptextures" object:self];
}


-(void)myColorsButtonPressed:(UIButton *)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"dropcolors" object:self];
}


- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}


- (IBAction)myResetGravityButtonPressed:(UIButton *)sender {
    NSLog(@"Reset Gravity Button Pressed");
    myGStrength = 1.0f;
    [ _myGravityStrength  setText:[NSString stringWithFormat:   @"Gravity = %0.2f",myGStrength/1.0]];
    ///
    //   when there's no gravity this crashes!!!
    
    if ([myScene2 childNodeWithName:@"gravityposition"]) {
        [myScene2 enumerateChildNodesWithName:@"gravityposition" usingBlock:^(SKNode *node, BOOL *stop) {
            // the position sprite is the child , the gravity node is the child of hte position sprite
            [node enumerateChildNodesWithName:@"gravity" usingBlock:^(SKNode *node, BOOL *stop) {
                [ (SKFieldNode *)   node setStrength: myGStrength];
            }];
        }];
    }
    
    //
    //  recorder 101
    //  forces 202
    //  show/hide 303
    //  place objects 999
    //
//    [[myView2 viewWithTag:101] setAlpha:0.0];
    [[myView2 viewWithTag:202] setAlpha:0.0];
    [[myView2 viewWithTag:303] setAlpha:0.0];
}

- (IBAction)myVortexStepperPressed:(UIStepper *)sender {
    NSLog(@"VortexStep Pressed");
    [_myVortexStrength setText:[NSString stringWithFormat:   @"Vortex = %0.2f",_myVortexStepper.value/10.0]];
    myVStrength = [ _myVortexStepper value ];
    [myScene2 enumerateChildNodesWithName:@"vortexposition" usingBlock:^(SKNode *node, BOOL *stop) {
        // the position sprite is the child , the Vortex node is the child of hte position sprite
        [node enumerateChildNodesWithName:@"vortex" usingBlock:^(SKNode *node, BOOL *stop) {
            [ (SKFieldNode *)   node setStrength: myVStrength];
            SKAction *mySlowSpin = [SKAction repeatActionForever:[SKAction sequence:@[
                                                                                      [SKAction rotateByAngle:myVStrength*50 duration:myVDuration/10.0],]]];
            [ (SKSpriteNode *) node.parent removeAllActions];
            [ (SKSpriteNode *) node.parent runAction:mySlowSpin];
            NSLog(@"myVortexStrength after increase vortex = %ld", (long)myVStrength) ;
        }];
    }];
    
}


- (IBAction)myGravityStepperPressed:(UIStepper *)sender {
    //  get the gravity sprites in the scene and set their gravity to the .value
    //   that is stored in the stepper
    //  also update the label to show the new gravity value
    NSLog(@"GravityStep Pressed");
    [_myGravityStrength setText:[NSString stringWithFormat:   @"Gravity = %0.2f",[_myGravityStepper value]]];
    myGStrength = [ _myGravityStepper value ]  ;
    [myScene2 enumerateChildNodesWithName:@"gravityposition" usingBlock:^(SKNode *node, BOOL *stop) {
        // the position sprite is the child , the gravity node is the child of hte position sprite
        [node enumerateChildNodesWithName:@"gravity" usingBlock:^(SKNode *node, BOOL *stop) {
            [ (SKFieldNode *)   node setStrength: myGStrength];
            NSLog(@"myGravityStrength after increase gravity = %f", myGStrength) ;
        }];
    }];
}


- (IBAction)myResetVortexButtonPressed:(UIButton *)sender {
    myVStrength = 10.0;
    [_myVortexStrength setText:[NSString stringWithFormat:   @"Vortex = %0.2f",myVStrength/10.0f]];
    [myScene2 enumerateChildNodesWithName:@"vortexposition" usingBlock:^(SKNode *node, BOOL *stop) {
        // the position sprite is the child , the Vortex node is the child of hte position sprite
        [node enumerateChildNodesWithName:@"vortex" usingBlock:^(SKNode *node, BOOL *stop) {
            [ (SKFieldNode *)   node setStrength: myVStrength];
            SKAction *mySlowSpin = [SKAction repeatActionForever:[SKAction sequence:@[
                                                                                      [SKAction rotateByAngle:myVStrength*50 duration:myVDuration/10.0],]]];
            [ (SKSpriteNode *) node.parent removeAllActions];
            [ (SKSpriteNode *) node.parent runAction:mySlowSpin];
            NSLog(@"myVortexStrength after increase vortex = %ld", (long)myVStrength) ;
        }];
    }];
    [[self.view viewWithTag:202] setAlpha:0.0];
    [[self.view viewWithTag:303] setAlpha:0.0];
}


- (IBAction)myTest:(id)sender {
}


- (IBAction)myTrailsSwitchValueChanged:(id)sender {
    if (_myTrailsSwitch.isOn) {
        [myScene2 enumerateChildNodesWithName:@"trailsprite" usingBlock:^(SKNode *node, BOOL *stop) {
            [node setHidden:NO];
        }];
    } else {
        [myScene2 enumerateChildNodesWithName:@"trailsprite" usingBlock:^(SKNode *node, BOOL *stop) {
            [node setHidden:YES];
        }];
    }
}



- (IBAction)myForcesSwitchValueChanged:(id)sender {
    NSLog(@"forces value changed");
    if (_myForcesSwitch.isOn) {
        [myView2 setShowsFields:YES];
    } else {
        [myView2 setShowsFields:NO];
    }
}

- (IBAction)myBottomControlValueChanged:(UISegmentedControl *)sender {
    [[self.view viewWithTag:999] setAlpha:0.0];
    [[self.view viewWithTag:887] setAlpha:0.0];
    [[self.view viewWithTag:888] setAlpha:0.0];
    [[self.view viewWithTag:202] setAlpha:0.0];
    [[self.view viewWithTag:303] setAlpha:0.0];
    [myScene2 enumerateChildNodesWithName:@"instructionLabelnode" usingBlock:^(SKNode * _Nonnull node, BOOL * _Nonnull stop) {
        [node setAlpha:0.0];
    }];
    NSArray *myForcesArray = [NSArray arrayWithObjects:@"Vortex", @"+Gravity", @"-Gravity",  nil];
    [myScene2 enumerateChildNodesWithName:@"myPrimaryInstructionLabel" usingBlock:^(SKNode * _Nonnull node, BOOL * _Nonnull stop) {
        if ([node respondsToSelector:@selector(setText:)]) {
            NSLog(@"In myBotomControlValue Changed  %@",myForcesArray[sender.selectedSegmentIndex]);
            [(SKLabelNode *) node setText:[NSString stringWithFormat:@"Tap for %@.  Swipe Up or Down for Menus",myForcesArray[sender.selectedSegmentIndex]]];
        }
    }];
    [myScene2 enumerateChildNodesWithName:@"myTopLeftInstructionLabel" usingBlock:^(SKNode * _Nonnull node, BOOL * _Nonnull stop) {
        if ([node respondsToSelector:@selector(setText:)]) {
            NSLog(@"In myBotomControlValue Changed  %@",myForcesArray[sender.selectedSegmentIndex]);
            //            [(SKLabelNode *) node setText:[NSString stringWithFormat:@"Tap =  %@",myForcesArray[sender.selectedSegmentIndex]]];
            [(SKLabelNode *) node setText:[NSString stringWithFormat:@"Force ="]];
        }
    }];
    [myScene2 enumerateChildNodesWithName:@"myTopRightInstructionLabel" usingBlock:^(SKNode * _Nonnull node, BOOL * _Nonnull stop) {
        if ([node respondsToSelector:@selector(setText:)]) {
            NSLog(@"In myBotomControlValue Changed  %@",myForcesArray[sender.selectedSegmentIndex]);
            //            [(SKLabelNode *) node setText:@"Swipe = Menus"];
            [(SKLabelNode *) node setText:[NSString stringWithFormat:@"%@",myForcesArray[sender.selectedSegmentIndex]]];
        }
    }];
    NSLog(@"done with mybotomcontrolvaluechanged method - rz");
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"forcesswitchchanged" object:self];
}




//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//    SCREEN RECORDING STUFF BELOW HERE
//
//
//
//
//
//


//- (void)previewControllerDidFinish:(RPPreviewViewController *)previewController {
//    NSLog(@"Preview Controller Finished");
//    //
//    ///
//    //  ask to share to social media sites
//    //
//
//    myReplayScreenRecorder = [RPScreenRecorder sharedRecorder];
//
//    [previewController dismissViewControllerAnimated:YES completion:^{
//        NSLog(@"dismiss view controller completion block");
//
//        UIAlertController *myAlertController = [UIAlertController alertControllerWithTitle:nil message:@"Completed Recording!!" preferredStyle:UIAlertControllerStyleAlert];
//        [self addChildViewController:myAlertController ];
//
//
//
//        // hide the record indicator when the recorder isn't recording
//        [_myRecordingIndicator setHidden:!myReplayScreenRecorder.isRecording];
//        // hide the record button when the recorder is recording
//        [_myRecButton setHidden:myReplayScreenRecorder.isRecording];
//        [_myStopButton setHidden:!myReplayScreenRecorder.isRecording];
//
//    }];
//}
//
//
//
//
//
//
//-(void)previewController:(RPPreviewViewController *)previewController didFinishWithActivityTypes:(NSSet<NSString *> *)activityTypes{
//    NSLog(@"recording is done");
//    NSLog(@"Activity Types Are %@",activityTypes);
//}
//
//
//
//-(void)screenRecorder:(RPScreenRecorder *)screenRecorder didStopRecordingWithError:(NSError *)error previewViewController:(RPPreviewViewController *)previewViewController{
//    if (!error) {
//        NSLog(@"about to show preview view controller");
//        [self presentViewController:previewViewController animated:YES completion:^{
//            //
//            //  try to get over having to press stop twice
//            //
//            UIAlertController *myAlertController = [UIAlertController alertControllerWithTitle:nil message:@"Completed The Preview!!" preferredStyle:UIAlertControllerStyleAlert];
//            [self addChildViewController:myAlertController ];
//
//            //
//            //            [self myStopPressed:_myStopButton];
//        }];
//
//    } else {
//        NSLog(@"error stopping recording");
//    }
//
//}
//
//
//-(void)screenRecorderDidChangeAvailability:(RPScreenRecorder *)screenRecorder{
//    NSLog(@"screen recorder availability changed");
//}
//
//
//
//- (IBAction)myRecordPressed:(UIButton *)sender {
//    myReplayScreenRecorder = [RPScreenRecorder sharedRecorder];
//    [myReplayScreenRecorder setDelegate:self];
//    //    [myReplayScreenRecorder setCameraEnabled:YES];
//    [myReplayScreenRecorder setMicrophoneEnabled:YES];
//    if (myReplayScreenRecorder.isAvailable) {
////        [myReplayScreenRecorder startRecordingWithMicrophoneEnabled:(myReplayScreenRecorder.isMicrophoneEnabled) handler:^(NSError * _Nullable error) {
//        [myReplayScreenRecorder startRecordingWithHandler:^(NSError * _Nullable error) {
//            if (error) {
//                NSLog(@"ERROR %@ starting recording",error.localizedDescription);
//            }
//            else {
//                NSLog(@"recording");
//                          [myReplayScreenRecorder.cameraPreviewView setFrame:CGRectMake(10, 10, 100, 100)];
//                          [self.view addSubview:myReplayScreenRecorder.cameraPreviewView];
//                [[self.view viewWithTag:101] setHidden:NO];
//                [_myRecordingIndicator setHidden:!myReplayScreenRecorder.recording];
//                [_myRecButton setHidden:myReplayScreenRecorder.recording];
//                [_myStopButton setHidden:!myReplayScreenRecorder.recording];
//            }
//        }];
//    }
//}
//
//
//- (IBAction)myStopPressed:(UIButton *)sender {
//    myReplayScreenRecorder = [RPScreenRecorder sharedRecorder];
//    NSLog(@"Stop Pressed");
//    //
//    [myScene2 setPaused:NO];
//    //
//    //
//    // we're going right to the preview view controller here so the below code is also in viewdidload
//    //
//    //
//    [_myRecordingIndicator setHidden:!myReplayScreenRecorder.isRecording];
//    [_myRecButton setHidden:myReplayScreenRecorder.isRecording];
//    [_myStopButton setHidden:!myReplayScreenRecorder.isRecording];
//    [myReplayScreenRecorder stopRecordingWithHandler:^(RPPreviewViewController * _Nullable previewViewController, NSError * _Nullable error) {
//        if (error) {
//            NSLog(@"ERROR");
//            NSLog(@"%@",error.localizedDescription);
//        }
//        if (!error) {
//            [previewViewController setPreviewControllerDelegate:self];
//            [previewViewController setEditing:YES animated:YES];
//            [self presentViewController:previewViewController animated:YES completion:^{
//                NSLog(@"recording is done");
//            }];
//        } else {
//            NSLog(@"error = %@",error.localizedDescription);
//        }
//
//    }];
//}


@end
