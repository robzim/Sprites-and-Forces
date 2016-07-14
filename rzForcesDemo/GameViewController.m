//
//  GameViewController.m
//  Sprites and Forces
//
//  Created by Robert Zimmelman on 12/30/14.
//  Copyright (c) 2014 Robert Zimmelman. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"


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
    
    return scene;
}

@end

@implementation GameViewController
@synthesize myReplayPreviewController;
@synthesize myReplayScreenRecorder;

- (IBAction)myIncreaseGravityButtonPressed:(UIButton *)sender {
    NSLog(@" Increase Gravity Button Pressed");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"increaseGravity" object:self];
}

- (IBAction)myDecreaseGravityButtonPressed:(UIButton *)sender {
    NSLog(@" Decrease Gravity Button Pressed");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"decreaseGravity" object:self];
}

- (IBAction)myResetGravityButtonPressed:(UIButton *)sender {
    //    [_myGravityValueLabel setText:@"RESET"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"resetGravity" object:self];
}

- (IBAction)myIncreaseVortexButtonPressed:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"increaseVortex" object:self];
}

- (IBAction)myDecreaseVortexButtonPressed:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"decreaseVortex" object:self];
}

- (IBAction)myResetVortexButtonPressed:(UIButton *)sender {
    //    [_myVortexValueLabel setText:@"reSET"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"resetVortex" object:self];
    
}

- (IBAction)myMiddleButtonPressed:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"retimesidebuttons" object:self];
  
}





- (IBAction)myShowForcesButtonPressed:(id)sender {
    //    NSLog(@"Show Forces Button Pressed");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showforces" object:self];
    
}

- (IBAction)myHideForcesButtonPressed:(id)sender {
    //    NSLog(@"Hide Forces Button Pressed");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideforces" object:self];
}

- (IBAction)myShowTrailsButtonPressed:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showtrails" object:self];
}


- (IBAction)myHideTrailsButtonPressed:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hidetrails" object:self];
}







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
    
    // hide the record indicator when the recorder isn't recording
    [_myRecordingIndicator setHidden:!myReplayScreenRecorder.isRecording];
    // hide the record button when the recorder is recording
    [_myRecButton setHidden:myReplayScreenRecorder.isRecording];
    [_myStopButton setHidden:!myReplayScreenRecorder.isRecording];
    
    myReplayScreenRecorder = [RPScreenRecorder sharedRecorder];
    [myReplayScreenRecorder setDelegate:self];

    [_myScreenRecorderStackView setHidden:!myReplayScreenRecorder.isAvailable];
    NSLog(@"myReplayScreenRecorder %c",myReplayScreenRecorder.recording);
    [skView presentScene:scene];

}


- (void)previewControllerDidFinish:(RPPreviewViewController *)previewController {
    NSLog(@"Preview Controller Finished");
    //
    ///
    //  ask to share to social media sites
    //
    
    
    
    [previewController dismissViewControllerAnimated:YES completion:^{
        NSLog(@"dismiss view controller completion block");
        // hide the record indicator when the recorder isn't recording
        [_myRecordingIndicator setHidden:!myReplayScreenRecorder.isRecording];
        // hide the record button when the recorder is recording
        [_myRecButton setHidden:myReplayScreenRecorder.isRecording];
        [_myStopButton setHidden:!myReplayScreenRecorder.isRecording];
        
    }];
}

-(void)previewController:(RPPreviewViewController *)previewController didFinishWithActivityTypes:(NSSet<NSString *> *)activityTypes{
    NSLog(@"Activity Types Are %@",activityTypes);
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


-(void)screenRecorder:(RPScreenRecorder *)screenRecorder didStopRecordingWithError:(NSError *)error previewViewController:(RPPreviewViewController *)previewViewController{
    if (!error) {
        [self presentViewController:previewViewController animated:YES completion:^{
            NSLog(@"recording is done");
            ///
            //
            //
            //  try to get over having to press stop twice
            //
            //
            [self myStopPressed:_myStopButton];
        }];
    } else {
        NSLog(@"error stopping recording");
    }
    
}


-(void)screenRecorderDidChangeAvailability:(RPScreenRecorder *)screenRecorder{
    NSLog(@"screen recorder availability changed");
}





- (IBAction)myRecordPressed:(UIButton *)sender {
    myReplayScreenRecorder = [RPScreenRecorder sharedRecorder];
    [myReplayScreenRecorder setDelegate:self];
    //    [myReplayScreenRecorder setCameraEnabled:NO];
    if (myReplayScreenRecorder.isAvailable) {
        [myReplayScreenRecorder startRecordingWithMicrophoneEnabled:NO handler:^(NSError * _Nullable error) {
            NSLog(@"ERROR startign recording");
            if (!error) {
                NSLog(@"recording");
                [_myRecordingIndicator setHidden:!myReplayScreenRecorder.isRecording];
                [_myRecButton setHidden:myReplayScreenRecorder.isRecording];
                [_myStopButton setHidden:!myReplayScreenRecorder.isRecording];
            }
        }];
        
    }
}


- (IBAction)myStopPressed:(UIButton *)sender {
    myReplayScreenRecorder = [RPScreenRecorder sharedRecorder];
    NSLog(@"stop");
    //
    //
    //
    // we're going right to the preview view controller here so the below code is also in viewdidload
    //
    //
    [_myRecordingIndicator setHidden:!myReplayScreenRecorder.isRecording];
    [_myRecButton setHidden:myReplayScreenRecorder.isRecording];
    [_myStopButton setHidden:!myReplayScreenRecorder.isRecording];
    [myReplayScreenRecorder stopRecordingWithHandler:^(RPPreviewViewController * _Nullable previewViewController, NSError * _Nullable error) {
        NSLog(@"%@",error.localizedDescription);
        if (error) {
            NSLog(@"ERROR");
        }
        if (!error) {
            [previewViewController setPreviewControllerDelegate:self];
            [previewViewController setEditing:YES animated:YES];
            [self presentViewController:previewViewController animated:YES completion:^{
                NSLog(@"recording is done");
            }];
        } else {
            NSLog(@"error = %@",error.localizedDescription);
        }
        
    }];
}


@end
