//
//  GameScene.m
//  Sprites and Forces
//
//  Created by Robert Zimmelman on 12/23/14.
//  Copyright (c) 2014 Robert Zimmelman. All rights reserved.
//

#import "GameScene.h"

NSTimeInterval myTouchStartTime;
NSTimeInterval myTouchEndTime;


int mySpaceSpriteImageNumber = 1;
int mySpaceObjectSize = 20.0;
float mySpaceObjectScale = 0.2;
float mySpaceObjectRestitution = 0.9;
float mySpaceObjectLinearDampingFactor = 300;

float myCircleMass = 1.0;
int mySpaceObjectLoops = 1;


float myMenuScale = 1.0;
NSInteger myObjectToBePlaced = 0;
long mySpringStrength = -1.1;
long mySpringStartStrength = -1;

long myGravityStartStrength = 1.0;
float myGravityStrength = 1.0;


float myVortexStrength = 10;
long myVortexStartStrength = 10.0 ;
float myVortexDuration = 500.0;


int myLabelFontSize = 14;



long myRadialGravityStrength = 10.0;


long myRadialGravityFalloff = 0.5;
long mySpringFieldFalloff = 2.0;




long myVortexFalloff = 2.0;






//int myForceVisibilityIndex = 4;
int myControlHeight = 40;
int myColorSpriteDuration = 120;
float myColorSpriteSize = 7.0;
int myColorSpriteCount = 13;
BOOL myTrailsIndicator = NO;


float myElapsedTime = 0;




//long myVortexSpringStrength = 1;
float myTempMass = 0.0;
float myMassIncrement = 10.0;



float myYOffset = 30;



int myMenuNumber = 1;

SKSpriteNode *myTextureSprite;
@implementation GameScene
@synthesize myQueue;
@synthesize myBG;
@synthesize myPositionSprite;
@synthesize myCursorSprite;
//@synthesize myColorSprite;

@synthesize mySecondaryHelperLabel;
@synthesize myDropItemsControl;
@synthesize myTopControlValues;
@synthesize myShowHideForcesStackView;
@synthesize myAdjustForcesStackView;
@synthesize myScreenRecorderStackView;

@synthesize myPlaceForcesControl;
@synthesize myBottomControlValues;
@synthesize  myLabelAction;
//@synthesize mySpriteTrail;

float myLastTime = 0;

-(void)update:(NSTimeInterval)currentTime{
    //
    myElapsedTime = currentTime - myLastTime;
    if ((myElapsedTime > 0.5) && (myElapsedTime < 100.0) ) {
        [self myRemoveMovingSprites];
    }
    //
    // store the current time.  next frame we'll compare this time to the current time
    //  and dump the sprites if the time is too long meaning the frame took too long to refresh
    //
    myLastTime = currentTime;
    
    
}




-(float)myRandom{
    float myRandomValue = 0;
    myRandomValue = arc4random()%1000;
    myRandomValue = myRandomValue / 1000;
    //    NSLog(@"%f",myRandomValue);
    return myRandomValue;
}



-(void)willMoveFromView:(SKView *)view {
    [self setPaused:YES];
    //    [[NSNotificationCenter defaultCenter] removeObserver:self
    //                                                 name:@"forcesswitchchanged" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"droptextures" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"droptrails" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"dropcolors" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"dropspaceobjects" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"retimesidebuttons" object:nil];
}



-(void)myDropTrails{
    [self myMakeColorsWithTrails:YES];
}

-(void)myDropColors{
    [self myMakeColorsWithTrails:NO];
}








-(void)didMoveToView:(SKView *)view {
    

    

    
    myDropItemsControl = [self.view viewWithTag:999];
    myPlaceForcesControl = [self.view viewWithTag:888];
    
    myShowHideForcesStackView = [self.view viewWithTag:303];
    myAdjustForcesStackView = [self.view viewWithTag:202];
    myScreenRecorderStackView = [self.view viewWithTag:101];
    
    [self setPaused:NO];
    
    //    [[NSNotificationCenter defaultCenter] addObserver:self
    //                                             selector:@selector(myBottomSwitchChanged:)
    //                                                 name:@"forcesswitchchanged" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(myMakeTextures)
                                                 name:@"droptextures" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(myDropColors)
                                                 name:@"dropcolors" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(myDropTrails)
                                                 name:@"droptrails" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(myMakeSpaceObjects)
                                                 name:@"dropspaceobjects" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(myRetimeSideControlAnimation)
                                                 name:@"retimesidebuttons" object:nil];
    
    [self setBackgroundColor:[UIColor blackColor]];
    
    //
    //
    //   ASPECTFILL WORKS FOR SCREEN BOUNDS PHYSICSBODY
    [self setScaleMode:SKSceneScaleModeAspectFill];
    //
    //        self.scaleMode = SKSceneScaleModeAspectFit;
    //    self.scaleMode = SKSceneScaleModeFill;
    
    [self.physicsWorld setGravity:CGVectorMake(0.0, -0.4)];
    
    
    [self.scene setSize:self.view.bounds.size];
    self.scene.scaleMode = SKSceneScaleModeAspectFit;
    
    
    [self setPhysicsBody:[SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame] ];
    
    
    
    NSLog(@"height = %f, width = %f",[self frame].size.height,[self frame].size.width );
    
    
    switch ( (int) [[UIScreen mainScreen] bounds].size.height ) {
        case 736:
            // it's a 6 plus
//            myMenuScale = 1.2;
            //            [myTopControl setFont:[UIFont fontWithName:@"Helvetica" size:24]];
            break;
        case 667:
            // it's a 6
//            myMenuScale = 1.2;
            //            [tView setFont:[UIFont fontWithName:@"Helvetica" size:20]];
            break;
        case 568:
            // it's a 5
//            myMenuScale = 1.0;
            //            [tView setFont:[UIFont fontWithName:@"Helvetica" size:18]];
            break;
        case 480:
            // it's a 4s
            
//            myMenuScale = 1.0;
            //            [tView setFont:[UIFont fontWithName:@"Helvetica" size:16]];
            break;
        default:
            break;
    }
    
    
    UILongPressGestureRecognizer *myLongPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(myLongPressAction)];
    [self.view addGestureRecognizer:myLongPressGestureRecognizer];
    
    UISwipeGestureRecognizer *myUpSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(myUpSwipeAction)];
    [myUpSwipeGestureRecognizer setDirection:UISwipeGestureRecognizerDirectionUp];
    [self.view addGestureRecognizer:myUpSwipeGestureRecognizer];
    
    
    
    
    UISwipeGestureRecognizer *myDownSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(myDownSwipeAction)];
    [myDownSwipeGestureRecognizer setDirection:UISwipeGestureRecognizerDirectionDown];
    [self.view addGestureRecognizer:myDownSwipeGestureRecognizer];
    
    
    UISwipeGestureRecognizer *myLeftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                                       action:@selector(myLeftSwipeAction)];
    [myLeftSwipeGestureRecognizer setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:myLeftSwipeGestureRecognizer];
    
    
    UISwipeGestureRecognizer *myRightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(myRightSwipeAction)];
    [myRightSwipeGestureRecognizer setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:myRightSwipeGestureRecognizer];
    
    
    myBottomControlValues  = @[@"Vortex",@"Gravity",@"Anti-Gravity"] ;
    //    [myBottomControl addTarget:self action:@selector(myBottomSwitchChanged:) forControlEvents:UIControlEventValueChanged ];
    myObjectToBePlaced = 0;
    [myPlaceForcesControl setSelectedSegmentIndex:myObjectToBePlaced];
    //    [self.view addSubview:myBottomControl];
    
    [myDropItemsControl setAlpha:0.0];
    [myPlaceForcesControl setAlpha:0.0];
    
    [myScreenRecorderStackView setHidden:YES];
    
    [myScreenRecorderStackView setCenter:CGPointMake(myScreenRecorderStackView.frame.origin.x, myScreenRecorderStackView.frame.origin.y - 1000)];
    [[self.view viewWithTag:202] setCenter:CGPointMake([self.view viewWithTag:202].frame.origin.x, [self.view viewWithTag:202].frame.origin.y - 1000)];
    [[self.view viewWithTag:303] setCenter:CGPointMake([self.view viewWithTag:303].frame.origin.x, [self.view viewWithTag:303].frame.origin.y - 1000)];
    [myScreenRecorderStackView setHidden:YES];
    
    
    /* Setup your scene here */
    
    myLabelAction = [SKAction sequence:@[
                                         [SKAction waitForDuration:15.0],
                                         [SKAction scaleTo:1.0 duration:0.1],
                                         [SKAction fadeInWithDuration:1.0],
                                         [SKAction waitForDuration:5.0],
                                         [SKAction fadeOutWithDuration:1.0],
                                         [SKAction waitForDuration:60.0],]];
    
    [self myMakeInstructionLabels];
    
    [(SKLabelNode *) [self childNodeWithName:@"myPrimaryInstructionLabel"] setPosition:CGPointMake(self.scene.size.width/2 ,  2 )];
    
    
    // by making primaryinstructinolabel an instructionlabelnode it can get hidden with the other instructinos
    //    [(SKLabelNode *) [self childNodeWithName:@"myPrimaryInstructionLabel"] setName:@"instructionLabelnode"];
}



-(void)myMakeVortex{
    myQueue = [NSOperationQueue mainQueue];
    [myQueue addOperationWithBlock: ^{
        
        NSString *myVortexEmitterPath = [[NSBundle mainBundle] pathForResource:@"myVortexParticle" ofType:@"sks"] ;
        //                SKPhysicsBody *myVortexEmitterPhysicsBody = [SKPhysicsBody bodyWithCircleOfRadius:1];
        SKEmitterNode *myVortexEmitterNode = [NSKeyedUnarchiver unarchiveObjectWithFile:myVortexEmitterPath];
        SKFieldNode *myVortexFieldNode = [SKFieldNode vortexField];
        
        SKAction *mySlowSpin = [SKAction  repeatActionForever:  [SKAction rotateByAngle:M_PI*50 duration:myColorSpriteDuration]];
        
        [myVortexFieldNode setStrength:myVortexStartStrength];
        [myVortexFieldNode setFalloff: myVortexFalloff ];
        [myVortexFieldNode setName:@"vortex"];
//        [myVortexEmitterNode setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:0.25]];
//        [myVortexFieldNode.physicsBody setAngularVelocity:100.0];
//        [myVortexFieldNode.physicsBody setDynamic:YES];
//        [myVortexFieldNode.physicsBody setMass:10000];
        //    [myPositionSprite addChild:myEmitterNode];
        [myPositionSprite setName:@"vortexposition"];
        [myPositionSprite addChild:myVortexFieldNode];
        [myPositionSprite addChild:myVortexEmitterNode];
        [self addChild:myPositionSprite];
        [myPositionSprite runAction:mySlowSpin];
    }];
}



-(void)myMakeGravity{
    myQueue = [NSOperationQueue mainQueue];
    [myQueue addOperationWithBlock:^{
        NSLog(@"Gravity   Gravity   Gravity   Gravity   Gravity   ");
        //
        //    SKSpriteNode *myForceImage = [SKSpriteNode spriteNodeWithImageNamed:@"rzForces Image.png"];
        
        NSString *mySpringEmitterNodePath = [[NSBundle mainBundle] pathForResource:@"myGravityParticle" ofType:@"sks"];
        SKEmitterNode *mySpringNodeEmitter =  [NSKeyedUnarchiver unarchiveObjectWithFile:mySpringEmitterNodePath];
        
        SKFieldNode *myRadialGravityNode = [SKFieldNode radialGravityField ];
        [myRadialGravityNode setStrength:myRadialGravityStrength];
        [myRadialGravityNode setName:@"gravity"];
        [myPositionSprite setName:@"gravityposition"];
        [myRadialGravityNode setFalloff:myRadialGravityFalloff];
        [myPositionSprite addChild:mySpringNodeEmitter];
        [myPositionSprite addChild:myRadialGravityNode];
        [myPositionSprite setZPosition:10.0];
        [self addChild:myPositionSprite];
    }];
    
}




-(void)myPlaceForce: (CGPoint) atPosition{
    //  reset the swipe-up menus to number 1
    myMenuNumber = 1;
    //
    myObjectToBePlaced = [myPlaceForcesControl selectedSegmentIndex];
    // we are placing forces, so remove all the instructions and buttons
    //
    [self myRemoveAllControlsAndInstructions];
    /* Called when a touch begins */
    myPositionSprite = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(1, 1)];
    [myPositionSprite setPosition:atPosition];
    switch (myObjectToBePlaced) {
        case 0:
            [self myMakeVortex];
            break;
        case 1:
            // rz gravity
            [self myMakeGravity];
            break;
        case 2:
            [self myMakeAntiGravity];
            break;
        default:
            break;
    }
    
}

-(void)myExposeMenus{
    // scale the menus to 0.2
    float myMenuScale = 0.6;
    float myMenuOffset = 100;
    //
    
    
    [myDropItemsControl setAlpha:1.0];
    [myPlaceForcesControl setAlpha:1.0];
    [myScreenRecorderStackView setAlpha:1.0];
    [myShowHideForcesStackView setAlpha:1.0];
    [myAdjustForcesStackView setAlpha:1.0];
    
    [myDropItemsControl setHidden:NO];
    [myPlaceForcesControl setHidden:NO];
    [myScreenRecorderStackView setHidden:NO];
    [myShowHideForcesStackView setHidden:NO];
    [myAdjustForcesStackView setHidden:NO];
    [myAdjustForcesStackView removeConstraints:myAdjustForcesStackView.constraints];
    [myDropItemsControl removeConstraints:myDropItemsControl.constraints];
    [myPlaceForcesControl removeConstraints:myPlaceForcesControl.constraints];
    [myScreenRecorderStackView removeConstraints:myScreenRecorderStackView.constraints];
    [myShowHideForcesStackView removeConstraints:myShowHideForcesStackView.constraints];

    // the control view are in order below
    [myDropItemsControl setTransform:CGAffineTransformMakeScale(myMenuScale,myMenuScale)];
    [myPlaceForcesControl setTransform:CGAffineTransformMakeScale(myMenuScale,myMenuScale)];
    [myScreenRecorderStackView setTransform:CGAffineTransformMakeScale(myMenuScale,myMenuScale)];
    [myShowHideForcesStackView setTransform:CGAffineTransformMakeScale(myMenuScale,myMenuScale)];
    [myAdjustForcesStackView setTransform:CGAffineTransformMakeScale(myMenuScale,myMenuScale)];
    //
    // place the controls in center, up, down, left, right positions
    
    [myDropItemsControl setAlignment:UIStackViewAlignmentLeading];
    //    [myPlaceForcesControl  setAlignment:UIStackViewAlignmentLeading];
    [myScreenRecorderStackView  setAlignment:UIStackViewAlignmentLeading];
    [myShowHideForcesStackView  setAlignment:UIStackViewAlignmentLeading];
    [myAdjustForcesStackView  setAlignment:UIStackViewAlignmentLeading];
    
    
    [myDropItemsControl setCenter:CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2)];
    [myPlaceForcesControl setCenter:CGPointMake(self.view.bounds.size.width/2, (self.view.bounds.size.width/2)+myMenuOffset)];
    [myScreenRecorderStackView setCenter:CGPointMake(self.view.bounds.size.width/2, (self.view.bounds.size.width/2)-myMenuOffset)];
    [myShowHideForcesStackView setCenter:CGPointMake((self.view.bounds.size.width/2)+myMenuOffset, self.view.bounds.size.width/2)];
    [myAdjustForcesStackView setCenter:CGPointMake((self.view.bounds.size.width/2)-myMenuOffset, self.view.bounds.size.width/2)];
    
    
    
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    myTouchStartTime = event.timestamp;
//    [self myExposeMenus];
//    NSLog(@"touches began");
//    for (UITouch *touch in touches) {
//        CGPoint location = [touch locationInNode:self];
//        NSLog(@"touches began      my loc = %f %f",location.x,location.y);
//    }
}


//-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"touches moved");
//    [self myExposeMenus];
//    for (UITouch *touch in touches) {
//        CGPoint location = [touch locationInNode:self];
//        NSLog(@"touches moved     my loc = %f %f",location.x,location.y);
//    }
//
//}


-(void)myLongPressAction{
    [self myRemoveMovingSprites];
    [self myRemoveAllControlsAndInstructions];
    [self myMakeInstructionLabels];
}



-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    myTouchEndTime = event.timestamp;
    NSTimeInterval myTouchDuration = myTouchEndTime - myTouchStartTime;
    NSLog(@"Tocuch Duration = %f",myTouchDuration);
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
            [self myPlaceForce: location];
    }
}


-(void)myMakeAntiGravity{
    myQueue =   [NSOperationQueue mainQueue];
    [myQueue addOperationWithBlock:^{
        
        // rz spring
        //
        NSString *mySpringEmitterNodePath = [[NSBundle mainBundle] pathForResource:@"MyParticle" ofType:@"sks"];
        SKEmitterNode *mySpringNodeEmitter =  [NSKeyedUnarchiver unarchiveObjectWithFile:mySpringEmitterNodePath];
        SKFieldNode *mySpringFieldNode = [SKFieldNode springField];
        [mySpringFieldNode setStrength:myGravityStrength];
        //        SKSpriteNode *myForceImage = [SKSpriteNode spriteNodeWithImageNamed:@"rzForces Image.png"];
        //        NSLog(@"NOW myforce = %ld",myForce);
        
        //
        SKAction *mySpringNodeFade = [SKAction sequence:@[
                                                          [SKAction fadeInWithDuration:(NSTimeInterval) 0.25],
                                                          [SKAction fadeOutWithDuration:(NSTimeInterval) 0.25],
                                                          ]];
        [mySpringNodeEmitter setScale:1.5];
        [mySpringNodeEmitter runAction:[SKAction repeatActionForever:mySpringNodeFade]];
        
        //
        [mySpringFieldNode setStrength: mySpringStrength ];
        [mySpringFieldNode setFalloff:mySpringFieldFalloff];
        [mySpringFieldNode setName:@"spring"];
        //                [myPositionSprite runAction:myEffectSpriteAction];
        [myPositionSprite setName:@"springposition"];
        [myPositionSprite addChild:mySpringNodeEmitter];
        [myPositionSprite addChild:mySpringFieldNode];
        [self addChild:myPositionSprite];
    }];
    
}


- (IBAction)myBottomSwitchChanged:(UISegmentedControl *)sender{
    //
    //  reset the swipe-up menus to number 1
    myMenuNumber = 1;
    //
    
    
    //  if the user touched the bottom switch, cancel the 'remove' animation
    //
    //    [UIView cancelPreviousPerformRequestsWithTarget:self];
    
    
    
    
    myObjectToBePlaced = sender.selectedSegmentIndex;
    //    myObjectToBeDropped = myValue;
    //    [sender setSelectedSegmentIndex:myObjectToBeDropped];
    //
    //
    // set the primary instruction label with the proper text
    //
    [ (SKLabelNode *) [self childNodeWithName:@"myPrimaryInstructionLabel"] setText:[NSString stringWithFormat:@"Tap to Place %@ or Swipe Up for Menus", myBottomControlValues[myObjectToBePlaced]]];
    
    //
    //
    //
    //  if the user touched the bottom switch, remove all controls and instructions
    [self myRemoveAllControlsAndInstructions];
    
    
    // now restart the 'remove' animation
    [self performSelector:@selector(myRemoveTopControlAndInstructions) withObject:self afterDelay:5.0];
}


//-(void)myIncreaseColorSpriteMass{
//    [self enumerateChildNodesWithName:@"colorsprite" usingBlock:^(SKNode *node, BOOL *stop) {
//        myTempMass = node.physicsBody.mass + myMassIncrement;
//        NSLog(@"Mass=%f",myTempMass);
//        [node.physicsBody setMass:myTempMass];
//    }];
//}
//
//-(void)myDecreaseColorSpriteMass{
//    [self enumerateChildNodesWithName:@"colorsprite" usingBlock:^(SKNode *node, BOOL *stop) {
//        myTempMass = node.physicsBody.mass - myMassIncrement;
//        NSLog(@"Mass=%f",myTempMass);
//        [node.physicsBody setMass:myTempMass];
//    }];
//}
//
//
//-(void)myResetColorSpriteMass{
//    [self enumerateChildNodesWithName:@"colorsprite" usingBlock:^(SKNode *node, BOOL *stop) {
//        [node.physicsBody setMass:1];
//    }];
//}


-(void)myRetimeTopControlAnimation{
    NSLog(@"Want to stop removal of top  control");
    [UIView cancelPreviousPerformRequestsWithTarget:self];
    [self performSelector:@selector(myRemoveTopControlAndInstructions) withObject:self afterDelay:5.0];
}

-(void)myRetimeSideControlAnimation{
    NSLog(@"Want to stop removal of bottom control");
    [UIView cancelPreviousPerformRequestsWithTarget:self];
    [self performSelector:@selector(myRemoveSideControls) withObject:self afterDelay:5.0];
}


-(void)myShowSideControls{
    
    
    //
    // show the forces buttons and show/hide buttons
    //
    [myScreenRecorderStackView setHidden:NO];
    [myShowHideForcesStackView setHidden:NO];
    [myAdjustForcesStackView setHidden:NO];
    
    
    [myScreenRecorderStackView setAlpha:1.0];
    [myAdjustForcesStackView setAlpha:1.0];
    [myShowHideForcesStackView setAlpha:1.0];
    
    //
    //  show the vortex and gravity value sklabel nodes
    
    //
    //  trigger the disappearance of the middle menus if the user doesn't raise the top/bottom menus
    //
    [self performSelector:@selector(myRemoveSideControls) withObject:self afterDelay:5.0];
    
    // adjust  the primary instruction label to ask for top/bottom labels
    [ (SKLabelNode *) [self childNodeWithName:@"myPrimaryInstructionLabel"] setText:[NSString stringWithFormat:@"Tap to Place %@ or Swipe Up for Menus", myBottomControlValues[myObjectToBePlaced]]];
    
}


-(void)myShowTopAndBottomControls{
    
    //    before raising the top and bottom controls, remove the animation that is removing the side menus
    [UIView cancelPreviousPerformRequestsWithTarget:self];
    
    
    
    // adjust  the primary instruction label to just place forces
    [ (SKLabelNode *) [self childNodeWithName:@"myPrimaryInstructionLabel"] setText:[NSString stringWithFormat:@"Tap to Place %@ or Swipe Up for Menus", myBottomControlValues[myObjectToBePlaced]]];
    
    
    [myDropItemsControl setHidden:NO];
    [myPlaceForcesControl setHidden:NO];
    [myDropItemsControl setAlpha:1.0];
    [myPlaceForcesControl setAlpha:1.0];
    //
    //
    //  show the instruction labels also
    //
    [self enumerateChildNodesWithName:@"instructionLabelnode" usingBlock:^(SKNode * _Nonnull node, BOOL * _Nonnull stop) {
        [node setScale:1.0];
        [node setAlpha:1.0];
    }];
    
    
}


-(void)myToggleMenus{
    switch (myMenuNumber) {
        case 1:
        {
            //
            // hide the screen recorder
            [UIView animateWithDuration:0.5 animations:^{
                [myScreenRecorderStackView setTransform:CGAffineTransformMakeScale(0.1, 0.1)];
                [myScreenRecorderStackView setHidden:YES];
                [myScreenRecorderStackView setAlpha:0.0];
                // show the drop items menu
                [myDropItemsControl setHidden:NO];
                [myDropItemsControl setAlpha:1.0];
                [myDropItemsControl setTransform:CGAffineTransformMakeScale(myMenuScale,myMenuScale)];
                // increment the menu number
            }];
            myMenuNumber++;
            break;
        }
        case 2:
        {
            [UIView animateWithDuration:0.5 animations:^{
                [myDropItemsControl setHidden:YES];
                [myDropItemsControl setAlpha:0.0];
                [myPlaceForcesControl setHidden:NO];
                [myPlaceForcesControl setAlpha:1.0];
                [myPlaceForcesControl setTransform:CGAffineTransformMakeScale(myMenuScale,myMenuScale)];
                // show the place forces menu
            }];
            myMenuNumber++;
            break;
        }
        case 3:
        {
            [UIView animateWithDuration:0.5 animations:^{
                [myPlaceForcesControl setHidden:YES];
                [myPlaceForcesControl setAlpha:0.0];
                //
                // hide the place forces control
                // show the adjust forces menu
                [myAdjustForcesStackView setHidden:NO];
                [myAdjustForcesStackView setAlpha:1.0];
                [myAdjustForcesStackView setTransform:CGAffineTransformMakeScale(myMenuScale,myMenuScale)];
                
            }];
            myMenuNumber++;
            break;
        }
        case 4:
        {
            [UIView animateWithDuration:0.5 animations:^{
                [myAdjustForcesStackView setHidden:YES];
                [myAdjustForcesStackView setAlpha:0.0];
                // show the show hide menu
                [myShowHideForcesStackView setHidden:NO];
                [myShowHideForcesStackView setAlpha:1.0];
                [myShowHideForcesStackView setTransform:CGAffineTransformMakeScale(myMenuScale,myMenuScale)];
                
            }];
            myMenuNumber++;
            break;
        }
        case 5:
        {
            [UIView animateWithDuration:0.5 animations:^{
                [myShowHideForcesStackView setHidden:YES];
                [myShowHideForcesStackView setAlpha:0.0];
                // show the recording menu
                //
                [myScreenRecorderStackView setHidden:NO];
                [myScreenRecorderStackView setAlpha:1.0];
                [myScreenRecorderStackView setTransform:CGAffineTransformMakeScale(myMenuScale,myMenuScale)];
                // reset the menu number
            }];
            myMenuNumber = 1;
            
            break;
        }
        default:
            break;
    }
}



-(void)myUpSwipeAction{
    //
    [self myToggleMenus];
    //
}

-(void)myRemoveInstructionLabels{
    myQueue = [NSOperationQueue mainQueue];
    [myQueue addOperationWithBlock:^{
        [self enumerateChildNodesWithName:@"instructionLabelnode" usingBlock:^(SKNode * _Nonnull node, BOOL * _Nonnull stop) {
            [node setScale:0.1];
            [node runAction:[SKAction waitForDuration:0.5] completion:^{
                [node setAlpha:0.0];
            }];
        }];
    }];
}

-(void)myRemoveAllControlsAndInstructions{
    myQueue = [NSOperationQueue mainQueue];
    [myQueue addOperationWithBlock:^{
        [UIView cancelPreviousPerformRequestsWithTarget:self];
        [myDropItemsControl setHidden:YES];
        [myPlaceForcesControl setHidden:YES];
        [myDropItemsControl setAlpha:0.0];
        [myPlaceForcesControl setAlpha:0.0];
        [myScreenRecorderStackView setHidden:YES];
        [myAdjustForcesStackView setHidden:YES];
        [myShowHideForcesStackView setHidden:YES];
        [myScreenRecorderStackView setAlpha:0.0];
        [myAdjustForcesStackView setAlpha:0.0];
        [myShowHideForcesStackView setAlpha:0.0];
        [self enumerateChildNodesWithName:@"instructionLabelnode" usingBlock:^(SKNode * _Nonnull node, BOOL * _Nonnull stop) {
            [node setScale:1.0];
            [node setAlpha:0.0];
        }];
    }];
}


-(void)myRemoveTopControlAndInstructions{
    //
    //
    //
    //  if we just removed the top control, reset the side  control removal timer
    //    [self myRetimeSideControlAnimation];
    //
    //
    
    
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [myDropItemsControl setTintColor:[UIColor redColor]];
        [myPlaceForcesControl setTintColor:[UIColor redColor]];
        [myScreenRecorderStackView setTintColor:[UIColor redColor]];
        //
        // resize the top and bottom  controls frame
        [myDropItemsControl setTransform:CGAffineTransformMakeScale(0.1, 0.1)];
        [myPlaceForcesControl setTransform:CGAffineTransformMakeScale(0.1, 0.1)];
        [myScreenRecorderStackView setTransform:CGAffineTransformMakeScale(0.1, 0.1)];
        
    } completion:^(BOOL finished) {
        // when we're finished fully hide the top control
        
        // set up the primary instruction label
        [ (SKLabelNode *) [self childNodeWithName:@"myPrimaryInstructionLabel"] setText:[NSString stringWithFormat:@"Tap to Place %@ or Swipe Up for Menus", myBottomControlValues[myObjectToBePlaced]]];
        
        // reset the top and bottom controls size
        [myDropItemsControl setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
        [myPlaceForcesControl setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
        [myScreenRecorderStackView setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
        //
        [myDropItemsControl setTintColor:nil];
        [myPlaceForcesControl setTintColor:nil];
        [myScreenRecorderStackView setTintColor:nil];
        //
        //
        //        [myTopControl setHidden:YES];
        //        [myBottomControl setHidden:YES];
        [myDropItemsControl setAlpha:0.0];
        [myPlaceForcesControl setAlpha:0.0];
        
        [self performSelector:@selector(myRemoveInstructionLabels) withObject:self afterDelay:0.0];
    }];
    
}

-(void)myRemoveSideControls{
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [myShowHideForcesStackView setTintColor:[UIColor redColor]];
        [myAdjustForcesStackView setTintColor:[UIColor redColor]];
        
        [myShowHideForcesStackView setTransform:CGAffineTransformMakeScale(0.1, 0.1)];
        [myAdjustForcesStackView setTransform:CGAffineTransformMakeScale(0.1, 0.1)];
        
    } completion:^(BOOL finished) {
        // set up the primary instruction label
        [ (SKLabelNode *) [self childNodeWithName:@"myPrimaryInstructionLabel"] setText:[NSString stringWithFormat:@"Tap to Place %@ or Swipe Up for Menus", myBottomControlValues[myObjectToBePlaced]]];
        
        [myShowHideForcesStackView setTintColor:nil];
        [myAdjustForcesStackView setTintColor:nil];
        //
        [myShowHideForcesStackView setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
        [myAdjustForcesStackView setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
        //
        // explicitly hide the side controls here
        [myScreenRecorderStackView setAlpha:0.0];
        [myShowHideForcesStackView setAlpha:0.0];
        [myAdjustForcesStackView setAlpha:0.0];
    }];
}



-(void)myDownSwipeAction{
    
}


-(void)myRightSwipeAction{
    [self myRemoveAllControlsAndInstructions];
    [self performSelector:@selector(myMakeInstructionLabels) withObject:self afterDelay:10];
}


-(void)myLeftSwipeAction{
    [self myRemoveAllControlsAndInstructions];
    [self performSelector:@selector(myMakeInstructionLabels) withObject:self afterDelay:10];
}





-(void)myResetScene{
    [self myRemoveAllControlsAndInstructions];
    [self removeAllChildren];
    [self performSelector:@selector(myMakeInstructionLabels) withObject:self afterDelay:10];
}



//
-(void)myMakeSpaceObjects{
    SKSpriteNode *mySpaceObject = [SKSpriteNode spriteNodeWithImageNamed:@"flame"];

    NSArray *mySpaceImages = [NSArray arrayWithObjects:@"alpha-5052129615_e3ea876e19_o", @"5052743686_77244d3b97_o",  @"5052744574_cc6c7338be_o",  @"alpha-5277460575_a1b324700d_o",  @"5278071900_c040282c2d_o", @"9460973502_7e62edc019_o", @"9464655973_9d00c231a0_o",  @"9464658509_0d53eda5e3_o",  @"9464665031_08eb5304d1_o", @"9467442336_db3d40cb53_o",  @"9467448026_7d146fb585_o", @"17125224860_dfdc354bd4_o",   @"etacarinae_hubble_900", @"hubble_friday_08212015",@"flame",nil];
    SKAction *mySpaceObjectAction =    [SKAction sequence:@[
                                                            [SKAction waitForDuration:300.0 withRange:1.5],
                                                            [SKAction removeFromParent],
                                                            ]];
    
    myQueue = [NSOperationQueue mainQueue];
    [myQueue addOperationWithBlock: ^{
        for ( int i = 1 ; i <= mySpaceObjectLoops ; i++){
            SKSpriteNode *mySpaceNode = [mySpaceObject copy];
            [mySpaceNode setTexture:[SKTexture textureWithImageNamed:mySpaceImages[mySpaceSpriteImageNumber]]];
            [mySpaceNode setScale: mySpaceObjectScale ];
            [mySpaceNode setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:mySpaceObjectSize]];
            [mySpaceNode.physicsBody setAffectedByGravity:YES];
            [mySpaceNode.physicsBody setRestitution:mySpaceObjectRestitution];
            //        [mySpaceNode.physicsBody setContactTestBitMask:0x03];
            [mySpaceNode.physicsBody setLinearDamping:mySpaceObjectLinearDampingFactor];
            [mySpaceNode.physicsBody setMass:myCircleMass];
            //                mySpaceNode.position = CGPointMake(CGRectGetMidX(self.frame) + 175 , CGRectGetMaxY(self.frame) - myYOffset );
            [mySpaceNode setPosition:CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-30)];
            
            [mySpaceNode setName:@"space object"];
            [self addChild:mySpaceNode];
            [mySpaceNode runAction:mySpaceObjectAction];
        }
    }];

    mySpaceSpriteImageNumber ++;
    if (mySpaceSpriteImageNumber == mySpaceImages.count - 1) {
        mySpaceSpriteImageNumber = 1;
    }

    
    // rz if there are too many little flying things, remove them
    //
    if ( self.children.count > 1000) {
        
        [self myRemoveMovingSprites];
        
    }

    
}





- (void)myMakeTextures{
    NSInteger myNumberOfLoops = 1;
    
    myQueue = [NSOperationQueue mainQueue];
    [myQueue addOperationWithBlock: ^{
        
        
        for ( int i = 1 ; i <= myNumberOfLoops ; i++){
            for (int mySpriteCounter = 1; mySpriteCounter <= 13; mySpriteCounter++) {
                //            NSLog(@"*");
                switch (mySpriteCounter) {
                    case 1:
                        myTextureSprite =  [SKSpriteNode spriteNodeWithImageNamed:@"flame.png"];
                        break;
                    case 2:
                        myTextureSprite =  [SKSpriteNode spriteNodeWithImageNamed:@"Stars.png"];
                        break;
                    case 3:
                        myTextureSprite =  [SKSpriteNode spriteNodeWithImageNamed:@"Swirly.png"];
                        break;
                    case 4:
                        myTextureSprite =  [SKSpriteNode spriteNodeWithImageNamed:@"Wood.png"];
                        break;
                    case 5:
                        myTextureSprite =  [SKSpriteNode spriteNodeWithImageNamed:@"Yellow.png"];
                        break;
                    case 6:
                        myTextureSprite =  [SKSpriteNode spriteNodeWithImageNamed:@"Basket.png"];
                        break;
                    case 7:
                        myTextureSprite =  [SKSpriteNode spriteNodeWithImageNamed:@"Blue.png"];
                        break;
                    case 8:
                        myTextureSprite =  [SKSpriteNode spriteNodeWithImageNamed:@"Bricks.png"];
                        break;
                    case 9:
                        myTextureSprite =  [SKSpriteNode spriteNodeWithImageNamed:@"Checker.png"];
                        break;
                    case 10:
                        myTextureSprite =  [SKSpriteNode spriteNodeWithImageNamed:@"Green.png"];
                        break;
                    case 11:
                        myTextureSprite =  [SKSpriteNode spriteNodeWithImageNamed:@"Grey.png"];
                        break;
                    case 12:
                        myTextureSprite =  [SKSpriteNode spriteNodeWithImageNamed:@"Leopard.png"];
                        break;
                    case 13:
                        myTextureSprite =  [SKSpriteNode spriteNodeWithImageNamed:@"Marble.png"];
                        break;
                    default:
                        break;
                }  // end of switch
                //
                // rz spread the color sprites around just a little bit
                // randomly
                //
                //            int myXOffset = arc4random()%20;
                //            int myYOffset = arc4random()%20;
                //            CGPoint myColorLocation = CGPointMake(myStaticLocation.x - myXOffset, myStaticLocation.y - myYOffset);
                
                [myTextureSprite setSize:CGSizeMake(20.0, 20.0)];
                
                //            [myColorSprite setPosition:myColorLocation];
                [myTextureSprite setPosition:CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-30)];
                
                myTextureSprite.physicsBody = [ SKPhysicsBody bodyWithRectangleOfSize:myTextureSprite.size];
                myTextureSprite.physicsBody.mass = 1;
                myTextureSprite.physicsBody.restitution = .9;
                myTextureSprite.physicsBody.affectedByGravity = YES;
                myTextureSprite.physicsBody.linearDamping = 13.0;
                [myTextureSprite setName:@"texture"];
                [self addChild:myTextureSprite];
                SKAction *mycolorSpriteAction =    [SKAction sequence:@[
                                                                        [SKAction waitForDuration:myColorSpriteDuration withRange:1.5],
                                                                        [SKAction removeFromParent],
                                                                        ]];
                [myTextureSprite runAction:mycolorSpriteAction];
            }  // end of mySpriteCounter Loop
        }  // end of myNUmberOfLoops Loop
        // rz if there are too many little flying things, remove them
        //
        
    }];
    
    
    if ( self.children.count > 1000) {
        [self myRemoveMovingSprites];
    }
    
}









-(void)myMakeInstructionLabels{
    
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
    
    UIColor *myLabelColor = [UIColor greenColor];
    //    float myPrimaryLabelYValue = 10;
    float mySecondaryLabelYValue = 150;
    float myInstructionLabelYValue = -150;
    
    // set up the primary instruction label
    [ (SKLabelNode *) [self childNodeWithName:@"myPrimaryInstructionLabel"] setText:[NSString stringWithFormat:@"Tap to Place %@ or Swipe Up for Menus", myBottomControlValues[myObjectToBePlaced]]];
    mySecondaryHelperLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    [mySecondaryHelperLabel setText:@"Choose an Item Above and Press Play/Pause to Use"];
    mySecondaryHelperLabel.fontSize = 12;
    mySecondaryHelperLabel.position = CGPointMake(CGRectGetMidX(self.frame),   CGRectGetMaxY(self.frame) - mySecondaryLabelYValue);
    [mySecondaryHelperLabel setHidden:YES];
    [self addChild:mySecondaryHelperLabel];
    
    
    
    SKLabelNode *myLabel1 = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    [myLabel1 setText:@"Top Buttons Drop"];
    //    , tap with two fingers to create snow, tap with three fingers to create smoke, swipe right to clear the screen!"];
    [myLabel1 setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + myInstructionLabelYValue )];
    [myLabel1 setFontSize:myLabelFontSize];
    [myLabel1 setFontColor:myLabelColor];
    [myLabel1 setAlpha:0.0];
    [myLabel1 setName:@"instructionLabelnode"];
    [self addChild:myLabel1];
    //    [myLabel1 runAction:[SKAction repeatActionForever:myLabelAction]];
    
    
    SKLabelNode *myLabel2 = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    //    , tap with two fingers to create snow, tap with three fingers to create smoke, swipe right to clear the screen!"];
    [myLabel2 setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + (myInstructionLabelYValue - 20) )];
    [myLabel2 setFontSize:myLabelFontSize];
    [myLabel2 setFontColor:myLabelColor];
    [myLabel2 setText:@"Colors, Textures, Pictures"];
    [myLabel2 setAlpha:0.0];
    [myLabel2 setName:@"instructionLabelnode"];
    [self addChild:myLabel2];
    //    [myLabel2 runAction:[SKAction repeatActionForever:myLabelAction]];
    
    SKLabelNode *myLabel3 = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    //    , tap with two fingers to create snow, tap with three fingers to create smoke, swipe right to clear the screen!"];
    [myLabel3 setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + (myInstructionLabelYValue - 40))];
    [myLabel3 setFontSize:myLabelFontSize];
    [myLabel3 setFontColor:myLabelColor];
    [myLabel3 setText:@"Bottom Buttons for "];
    [myLabel3 setName:@"instructionLabelnode"];
    [myLabel3 setAlpha:0.0];
    [self addChild:myLabel3];
    //    [myLabel3 runAction:[SKAction repeatActionForever:myLabelAction]];
    
    
    SKLabelNode *myLabel4 = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    //    , tap with two fingers to create snow, tap with three fingers to create smoke, swipe right to clear the screen!"];
    [myLabel4 setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)+(myInstructionLabelYValue - 60))];
    [myLabel4 setFontSize:myLabelFontSize];
    [myLabel4 setFontColor:myLabelColor];
    [myLabel4 setText:@"Vortex Gravity Force"];
    [myLabel4 setName:@"instructionLabelnode"];
    [myLabel4 setAlpha:0.0];
    [self addChild:myLabel4];
    //    [myLabel4 runAction:[SKAction repeatActionForever:myLabelAction]];
    
    
    
    SKLabelNode *myLabel5 = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    //    , tap with two fingers to create snow, tap with three fingers to create smoke, swipe right to clear the screen!"];
    [myLabel5 setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + (myInstructionLabelYValue - 80) )];
    [myLabel5 setFontSize:myLabelFontSize];
    [myLabel5 setFontColor:myLabelColor];
    [myLabel5 setText:@"Swipe Up for Menus"];
    [myLabel5 setName:@"instructionLabelnode"];
    [myLabel5 setAlpha:0.0];
    [self addChild:myLabel5];
    //    [myLabel5 runAction:[SKAction repeatActionForever:myLabelAction]];
    
    
    SKLabelNode *myLabel6 = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    //    , tap with two fingers to create snow, tap with three fingers to create smoke, swipe right to clear the screen!"];
    [myLabel6 setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + (myInstructionLabelYValue - 100))];
    [myLabel6 setFontSize:myLabelFontSize];
    [myLabel6 setFontColor:myLabelColor];
    [myLabel6 setText:@"Swipe Down to Exit Menus"];
    [myLabel6 setName:@"instructionLabelnode"];
    [myLabel6 setAlpha:0.0];
    [self addChild:myLabel6];
    //    [myLabel6 runAction:[SKAction repeatActionForever:myLabelAction]];
    
    
    SKLabelNode *myLabel7 = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    //    , tap with two fingers to create snow, tap with three fingers to create smoke, swipe right to clear the screen!"];
    [myLabel7 setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + (myInstructionLabelYValue - 120))];
    [myLabel7 setFontSize:myLabelFontSize];
    [myLabel7 setFontColor:myLabelColor];
    [myLabel7 setText:@"Long Press to"];
    [myLabel7 setName:@"instructionLabelnode"];
    [myLabel7 setAlpha:0.0];
    [self addChild:myLabel7];
    //    [myLabel7 runAction:[SKAction repeatActionForever:myLabelAction]];
    
    SKLabelNode *myLabel8 = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    //    , tap with two fingers to create snow, tap with three fingers to create smoke, swipe right to clear the screen!"];
    [myLabel8 setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + (myInstructionLabelYValue - 140))];
    [myLabel8 setFontSize:myLabelFontSize];
    [myLabel8 setFontColor:myLabelColor];
    [myLabel8 setText:@"Remove all Objects"];
    [myLabel8 setName:@"instructionLabelnode"];
    [myLabel8 setAlpha:0.0];
    [self addChild:myLabel8];
    //    [myLabel8 runAction:[SKAction repeatActionForever:myLabelAction]];
    
    
    [self enumerateChildNodesWithName:@"instructionLabelnode" usingBlock:^(SKNode * _Nonnull node, BOOL * _Nonnull stop) {
        [node runAction:[SKAction repeatActionForever:myLabelAction]];
    }];
    
    
    }];

    
    //@"Swipe Left to Reset Color Mass to Default Values"
    
}



-(CGPoint)myGetSpritePosition: (SKSpriteNode *) theSprite {
    return(theSprite.position);
}


- (void)myMakeColorsWithTrails:  (BOOL) theTrailsIndicator {
    //    SKAction *myWaitBetweekTrailBlocks = [SKAction waitForDuration:0.5];
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
    SKAction *mySpriteScaleUpDownAction = [SKAction sequence:
                                           @[[SKAction scaleBy: 2.0 duration:0.05],
                                             [SKAction scaleBy: 0.5 duration:0.1]]];
    
        

        
        
    // rz only scale up and down if we're not making trails
    SKAction *myColorSpriteChangeColor = [SKAction sequence: @[[SKAction colorizeWithColor:[UIColor whiteColor] colorBlendFactor:1.0 duration:0.5],                                                                     [SKAction colorizeWithColor:[UIColor colorWithRed:[self myRandom] green:[self myRandom] blue:[self myRandom] alpha:1.0] colorBlendFactor:1.0 duration:0.2],]];
    
    
    
    SKAction *mycolorSpriteAction =    [SKAction repeatActionForever:               [SKAction group:@[mySpriteScaleUpDownAction,myColorSpriteChangeColor]]];
    
    NSInteger myNumberOfLoops = 1;
        
        
        SKSpriteNode *myColorSprite =  [SKSpriteNode spriteNodeWithColor:[UIColor clearColor]  size:CGSizeMake (myColorSpriteSize, myColorSpriteSize)];


    
    for ( int i = 1 ; i <= myNumberOfLoops ; i++){
        for (int mySpriteCounter = 1; mySpriteCounter <= myColorSpriteCount; mySpriteCounter++) {
            //            NSLog(@"*");
            switch (mySpriteCounter) {
                case 1:
                {
//                    [myColorSprite setColor:[UIColor blackColor]];
                                        myColorSprite = [ SKSpriteNode spriteNodeWithColor:[UIColor blackColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
                }
                    
                    break;
                case 2:{
//                    [myColorSprite setColor:[UIColor darkGrayColor]];
                    myColorSprite = [ SKSpriteNode spriteNodeWithColor:[UIColor darkGrayColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
                }
                    break;
                case 3:{
//                    [myColorSprite setColor:[UIColor lightGrayColor]];
                    myColorSprite = [ SKSpriteNode spriteNodeWithColor:[UIColor lightGrayColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
                }
                    break;
                case 4:{
//                    [myColorSprite setColor:[UIColor whiteColor]];
                    myColorSprite = [ SKSpriteNode spriteNodeWithColor:[UIColor whiteColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
                }
                    break;
                case 5:{
//                    [myColorSprite setColor:[UIColor redColor]];
                    myColorSprite = [ SKSpriteNode spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
                }
                    break;
                case 6:{
//                    [myColorSprite setColor:[UIColor greenColor]];
                    myColorSprite = [ SKSpriteNode spriteNodeWithColor:[UIColor greenColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
                }
                    break;
                case 7:{
//                    [myColorSprite setColor:[UIColor blueColor]];
                    myColorSprite = [ SKSpriteNode spriteNodeWithColor:[UIColor blueColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
                }
                    break;
                case 8:{
//                    [myColorSprite setColor:[UIColor cyanColor]];
                    myColorSprite = [ SKSpriteNode spriteNodeWithColor:[UIColor cyanColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
                }
                    break;
                case 9:{
//                    [myColorSprite setColor:[UIColor yellowColor]];
                    myColorSprite = [ SKSpriteNode spriteNodeWithColor:[UIColor yellowColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
                }
                    break;
                case 10:{
//                    [myColorSprite setColor:[UIColor magentaColor]];

                    myColorSprite = [ SKSpriteNode spriteNodeWithColor:[UIColor magentaColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
                }
                    break;
                case 11:{
//                    [myColorSprite setColor:[UIColor orangeColor]];

                    myColorSprite = [ SKSpriteNode spriteNodeWithColor:[UIColor orangeColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
                }
                    break;
                case 12:{
//                    [myColorSprite setColor:[UIColor purpleColor]];

                    myColorSprite = [ SKSpriteNode spriteNodeWithColor:[UIColor purpleColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
                }
                    break;
                case 13:{
//                    [myColorSprite setColor:[UIColor brownColor]];

                    myColorSprite = [ SKSpriteNode spriteNodeWithColor:[UIColor brownColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
                }
                    break;
                default:
                    break;
            }  // end of switch
            //
            // rz spread the color sprites around just a little bit
            [myColorSprite setPosition:CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-30)];
            
            myColorSprite.physicsBody = [ SKPhysicsBody bodyWithRectangleOfSize: myColorSprite.size];
            myColorSprite.physicsBody.mass = 1;
            myColorSprite.physicsBody.restitution = .9;
            myColorSprite.physicsBody.affectedByGravity = YES;
            myColorSprite.physicsBody.linearDamping = 20.0;
            //            myColorSprite.blendMode = SKBlendModeReplace ;
            //            myColorSprite.physicsBody.contactTestBitMask = 0x03;
            [myColorSprite setName:@"color"];
            [self addChild:myColorSprite];
            //
            //  rz trying to add a trail of sprites to draw out the path that a color node takes
            //
            
            //            CGPoint myFirstSpritePosition = myColorSprite.position;
            //            CGPoint mySecondSpritePosition = myColorSprite.position;
            
            // now draw a line from the first position (where we were) to second position (where we are now)
            
            //
            if (!theTrailsIndicator) {
                [myColorSprite runAction:mycolorSpriteAction];
            }
            
            
            if (theTrailsIndicator) {
                
                SKAction *mySpriteTrail = [SKAction sequence:@[
                                                               [SKAction runBlock:
                                                                ^{
                                                                    SKSpriteNode *myTrailSprite = [SKSpriteNode spriteNodeWithColor:myColorSprite.color size:CGSizeMake(4.0, 4.0)];
                                                                    [myTrailSprite setPosition:myColorSprite.position ];
                                                                    [myTrailSprite setBlendMode:SKBlendModeReplace];
                                                                    [myTrailSprite setName:@"trailsprite"];
                                                                    [self addChild:myTrailSprite];
                                                                    [myTrailSprite runAction:[SKAction sequence:@[ [SKAction waitForDuration:5.0], [SKAction removeFromParent],      ]]];
                                                                }
                                                                ],
                                                               [SKAction waitForDuration:0.2],
                                                               ]];
                

                
                //                if  (fabs(myFirstSpritePosition.x - mySecondSpritePosition.x) > 2.0f) {
                //                [myColorSprite runAction:[SKAction repeatActionForever: mySpriteTrail]];
                [myColorSprite runAction:[SKAction repeatActionForever: mySpriteTrail]];
                //                }
            }
            
        }  // end of mySpriteCounter Loop
    }  // end of myNUmberOfLoops Loop
    
    }];

}


- (void)myRemoveMovingSprites{
    NSLog(@"Elapsed Time  %f  Is Too Large, REMOVING OBJECTS!!!",myElapsedTime);
    [mySecondaryHelperLabel setHidden:NO];
    [mySecondaryHelperLabel setAlpha:1.0];
    [mySecondaryHelperLabel setText:@"Too Much SPACE JUNK!!! Cleaning Up Your Mess"];
    SKAction *myNodeFade = [SKAction sequence:@[[SKAction fadeOutWithDuration:(NSTimeInterval) 5.00],]];
    [mySecondaryHelperLabel runAction:myNodeFade];
    
    [self enumerateChildNodesWithName:@"color" usingBlock:^(SKNode *node, BOOL *stop) {
        [node removeFromParent];
    }];
    [self enumerateChildNodesWithName:@"texture" usingBlock:^(SKNode *node, BOOL *stop) {
        [node removeFromParent];
    }];
    [self enumerateChildNodesWithName:@"space object" usingBlock:^(SKNode *node, BOOL *stop) {
        [node removeFromParent];
    }];
    [self enumerateChildNodesWithName:@"trailsprite" usingBlock:^(SKNode *node, BOOL *stop) {
        [node removeFromParent];
    }];
    //
    //
    //
    //
    // rz doesn't seem to be working so force everything to go
}




@end


//-(void)myOldMakeSpaceObjects{
//    mySpaceSpriteImageNumber ++;
//    SKAction *mySpaceObjectAction =    [SKAction sequence:@[
//                                                            [SKAction waitForDuration:300.0 withRange:1.5],
//                                                            [SKAction removeFromParent],
//                                                            ]];
//    myQueue = [NSOperationQueue mainQueue];
//    [myQueue addOperationWithBlock: ^{
//        for ( int i = 1 ; i <= mySpaceObjectLoops ; i++){
//            switch (mySpaceSpriteImageNumber) {
//                case 1:
//                {
//                    SKSpriteNode *mySpaceObject1 = [ SKSpriteNode spriteNodeWithImageNamed:@"alpha-5052129615_e3ea876e19_o"];
//                    [mySpaceObject1 setScale: (mySpaceObjectScale * 2) ];
//                    [mySpaceObject1 setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:(mySpaceObjectScale * 4) ]];
//                    [mySpaceObject1.physicsBody setAffectedByGravity:YES];
//                    [mySpaceObject1.physicsBody setAllowsRotation:NO];
//                    [mySpaceObject1.physicsBody setRestitution:mySpaceObjectRestitution];
//                    //        [mySpaceObject1.physicsBody setContactTestBitMask:0x03];
//                    [mySpaceObject1.physicsBody setLinearDamping:mySpaceObjectLinearDampingFactor];
//                    [mySpaceObject1.physicsBody setMass:myCircleMass];
//                    mySpaceObject1.position = CGPointMake(CGRectGetMidX(self.frame) - 175 , CGRectGetMaxY(self.frame) - myYOffset );
//                    [mySpaceObject1 setName:@"space object"];
//                    [self addChild:mySpaceObject1];
//                    [mySpaceObject1 runAction:mySpaceObjectAction];
//                    break;
//                }
//
//                case 2:
//                {
//                    SKSpriteNode *mySpaceObject2 = [ SKSpriteNode spriteNodeWithImageNamed:@"5052743686_77244d3b97_o"];
//                    [mySpaceObject2 setScale: mySpaceObjectScale ];
//                    [mySpaceObject2 setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:mySpaceObjectSize]];
//                    [mySpaceObject2.physicsBody setAffectedByGravity:YES];
//                    [mySpaceObject2.physicsBody setRestitution:mySpaceObjectRestitution];
//                    //        [mySpaceObject2.physicsBody setContactTestBitMask:0x03];
//                    [mySpaceObject2.physicsBody setLinearDamping:mySpaceObjectLinearDampingFactor];
//                    [mySpaceObject2.physicsBody setMass:myCircleMass];
//                    [mySpaceObject2 setPosition:CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-30)];
//
//                    [mySpaceObject2 setName:@"space object"];
//                    [self addChild:mySpaceObject2];
//                    [mySpaceObject2 runAction:mySpaceObjectAction];
//
//                    break;
//                }
//
//                case 3:
//                {
//                    SKSpriteNode *mySpaceObject3 = [ SKSpriteNode spriteNodeWithImageNamed:@"5052744574_cc6c7338be_o"];
//                    [mySpaceObject3 setScale: mySpaceObjectScale ];
//                    [mySpaceObject3 setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:mySpaceObjectSize]];
//                    [mySpaceObject3.physicsBody setAffectedByGravity:YES];
//                    [mySpaceObject3.physicsBody setRestitution:mySpaceObjectRestitution];
//                    //        [mySpaceObject3.physicsBody setContactTestBitMask:0x03];
//                    [mySpaceObject3.physicsBody setLinearDamping:mySpaceObjectLinearDampingFactor];
//                    [mySpaceObject3.physicsBody setMass:myCircleMass];
//                    //                mySpaceObject3.position = CGPointMake(CGRectGetMidX(self.frame) - 125 , CGRectGetMaxY(self.frame) - myYOffset );
//                    [mySpaceObject3 setPosition:CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-30)];
//
//                    [mySpaceObject3 setName:@"space object"];
//                    [self addChild:mySpaceObject3];
//                    [mySpaceObject3 runAction:mySpaceObjectAction];
//                    break;
//                }
//
//                case 4:
//                {
//                    SKSpriteNode *mySpaceObject4 = [ SKSpriteNode spriteNodeWithImageNamed:@"alpha-5277460575_a1b324700d_o"];
//                    [mySpaceObject4 setScale: (mySpaceObjectScale * 2) ];
//                    [mySpaceObject4 setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:(mySpaceObjectScale * 2)]];
//                    [mySpaceObject4.physicsBody setAffectedByGravity:YES];
//                    [mySpaceObject4.physicsBody setAllowsRotation:NO];
//
//                    [mySpaceObject4.physicsBody setRestitution:mySpaceObjectRestitution];
//                    //        [mySpaceObject4.physicsBody setContactTestBitMask:0x03];
//                    [mySpaceObject4.physicsBody setLinearDamping:mySpaceObjectLinearDampingFactor];
//                    [mySpaceObject4.physicsBody setMass:myCircleMass];
//                    //                mySpaceObject4.position = CGPointMake(CGRectGetMidX(self.frame) - 100 , CGRectGetMaxY(self.frame) - myYOffset );
//                    [mySpaceObject4 setPosition:CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-30)];
//
//                    [mySpaceObject4 setName:@"space object"];
//                    [self addChild:mySpaceObject4];
//                    [mySpaceObject4 runAction:mySpaceObjectAction];
//                    break;
//                }
//
//                case 5:
//                {
//                    SKSpriteNode *mySpaceObject5 = [ SKSpriteNode spriteNodeWithImageNamed:@"5278071900_c040282c2d_o"];
//                    [mySpaceObject5 setScale: mySpaceObjectScale ];
//                    [mySpaceObject5 setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:mySpaceObjectSize]];
//                    [mySpaceObject5.physicsBody setAffectedByGravity:YES];
//                    [mySpaceObject5.physicsBody setRestitution:mySpaceObjectRestitution];
//                    //        [mySpaceObject5.physicsBody setContactTestBitMask:0x03];
//                    [mySpaceObject5.physicsBody setLinearDamping:mySpaceObjectLinearDampingFactor];
//                    [mySpaceObject5.physicsBody setMass:myCircleMass];
//                    //                mySpaceObject5.position = CGPointMake(CGRectGetMidX(self.frame) - 75 , CGRectGetMaxY(self.frame) - myYOffset );
//                    [mySpaceObject5 setPosition:CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-30)];
//
//                    [mySpaceObject5 setName:@"space object"];
//                    [self addChild:mySpaceObject5];
//                    [mySpaceObject5 runAction:mySpaceObjectAction];
//                    break;
//                }
//
//                case 6:
//                {
//                    SKSpriteNode *mySpaceObject6 = [ SKSpriteNode spriteNodeWithImageNamed:@"9460973502_7e62edc019_o"];
//                    [mySpaceObject6 setScale: mySpaceObjectScale ];
//                    [mySpaceObject6 setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:mySpaceObjectSize]];
//                    [mySpaceObject6.physicsBody setAffectedByGravity:YES];
//                    [mySpaceObject6.physicsBody setRestitution:mySpaceObjectRestitution];
//                    //        [mySpaceObject6.physicsBody setContactTestBitMask:0x03];
//                    [mySpaceObject6.physicsBody setLinearDamping:mySpaceObjectLinearDampingFactor];
//                    [mySpaceObject6.physicsBody setMass:myCircleMass];
//                    //                mySpaceObject6.position = CGPointMake(CGRectGetMidX(self.frame) - 50 , CGRectGetMaxY(self.frame) - myYOffset );
//                    [mySpaceObject6 setPosition:CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-30)];
//
//                    [mySpaceObject6 setName:@"space object"];
//                    [self addChild:mySpaceObject6];
//                    [mySpaceObject6 runAction:mySpaceObjectAction];
//                    break;
//                }
//
//                case 7:
//                {
//                    SKSpriteNode *mySpaceObject7 = [ SKSpriteNode spriteNodeWithImageNamed:@"9464655973_9d00c231a0_o"];
//                    [mySpaceObject7 setScale: mySpaceObjectScale ];
//                    [mySpaceObject7 setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:mySpaceObjectSize]];
//                    [mySpaceObject7.physicsBody setAffectedByGravity:YES];
//                    [mySpaceObject7.physicsBody setRestitution:mySpaceObjectRestitution];
//                    //        [mySpaceObject7.physicsBody setContactTestBitMask:0x03];
//                    [mySpaceObject7.physicsBody setLinearDamping:mySpaceObjectLinearDampingFactor];
//                    [mySpaceObject7.physicsBody setMass:myCircleMass];
//                    [mySpaceObject7 setName:@"space object"];
//                    //                mySpaceObject7.position = CGPointMake(CGRectGetMidX(self.frame) - 25 , CGRectGetMaxY(self.frame) - myYOffset );
//                    [mySpaceObject7 setPosition:CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-30)];
//
//                    [self addChild:mySpaceObject7];
//                    [mySpaceObject7 runAction:mySpaceObjectAction];
//                    break;
//                }
//
//                case 8:
//                {
//                    SKSpriteNode *mySpaceObject8 = [ SKSpriteNode spriteNodeWithImageNamed:@"9464658509_0d53eda5e3_o"];
//                    [mySpaceObject8 setScale: mySpaceObjectScale ];
//                    [mySpaceObject8 setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:mySpaceObjectSize]];
//                    [mySpaceObject8.physicsBody setAffectedByGravity:YES];
//                    [mySpaceObject8.physicsBody setRestitution:mySpaceObjectRestitution];
//                    //        [mySpaceObject8.physicsBody setContactTestBitMask:0x03];
//                    [mySpaceObject8.physicsBody setLinearDamping:mySpaceObjectLinearDampingFactor];
//                    [mySpaceObject8.physicsBody setMass:myCircleMass];
//                    //                mySpaceObject8.position = CGPointMake(CGRectGetMidX(self.frame)  , CGRectGetMaxY(self.frame) - myYOffset );
//                    [mySpaceObject8 setPosition:CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-30)];
//
//                    [mySpaceObject8 setName:@"space object"];
//                    [self addChild:mySpaceObject8];
//                    [mySpaceObject8 runAction:mySpaceObjectAction];
//                    break;
//                }
//
//                case 9:
//                {
//                    SKSpriteNode *mySpaceObject9 = [ SKSpriteNode spriteNodeWithImageNamed:@"9464665031_08eb5304d1_o"];
//                    [mySpaceObject9 setScale: mySpaceObjectScale ];
//                    [mySpaceObject9 setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:mySpaceObjectSize]];
//                    [mySpaceObject9.physicsBody setAffectedByGravity:YES];
//                    [mySpaceObject9.physicsBody setRestitution:mySpaceObjectRestitution];
//                    //        [mySpaceObject9.physicsBody setContactTestBitMask:0x03];
//                    [mySpaceObject9.physicsBody setLinearDamping:mySpaceObjectLinearDampingFactor];
//                    [mySpaceObject9.physicsBody setMass:myCircleMass];
//                    //                mySpaceObject9.position = CGPointMake(CGRectGetMidX(self.frame) + 25 , CGRectGetMaxY(self.frame) - myYOffset );
//                    [mySpaceObject9 setPosition:CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-30)];
//
//                    [mySpaceObject9 setName:@"space object"];
//                    [self addChild:mySpaceObject9];
//                    [mySpaceObject9 runAction:mySpaceObjectAction];
//                    break;
//                }
//
//                case 10:
//                {
//                    SKSpriteNode *mySpaceObject10 = [ SKSpriteNode spriteNodeWithImageNamed:@"9467442336_db3d40cb53_o"];
//                    [mySpaceObject10 setScale: mySpaceObjectScale ];
//                    [mySpaceObject10 setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:mySpaceObjectSize]];
//                    [mySpaceObject10.physicsBody setAffectedByGravity:YES];
//                    [mySpaceObject10.physicsBody setRestitution:mySpaceObjectRestitution];
//                    //        [mySpaceObject10.physicsBody setContactTestBitMask:0x03];
//                    [mySpaceObject10.physicsBody setLinearDamping:mySpaceObjectLinearDampingFactor];
//                    [mySpaceObject10.physicsBody setMass:myCircleMass];
//                    //                mySpaceObject10.position = CGPointMake(CGRectGetMidX(self.frame) + 50 , CGRectGetMaxY(self.frame) - myYOffset );
//                    [mySpaceObject10 setPosition:CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-30)];
//
//                    [mySpaceObject10 setName:@"space object"];
//                    [self addChild:mySpaceObject10];
//                    [mySpaceObject10 runAction:mySpaceObjectAction];
//                    break;
//                }
//
//                case 11:
//                {
//                    SKSpriteNode *mySpaceObject11 = [ SKSpriteNode spriteNodeWithImageNamed:@"9467448026_7d146fb585_o"];
//                    [mySpaceObject11 setScale: mySpaceObjectScale ];
//                    [mySpaceObject11 setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:mySpaceObjectSize]];
//                    [mySpaceObject11.physicsBody setAffectedByGravity:YES];
//                    [mySpaceObject11.physicsBody setRestitution:mySpaceObjectRestitution];
//                    //        [mySpaceObject11.physicsBody setContactTestBitMask:0x03];
//                    [mySpaceObject11.physicsBody setLinearDamping:mySpaceObjectLinearDampingFactor];
//                    [mySpaceObject11.physicsBody setMass:myCircleMass];
//                    //                mySpaceObject11.position = CGPointMake(CGRectGetMidX(self.frame) + 75 , CGRectGetMaxY(self.frame) - myYOffset );
//                    [mySpaceObject11 setPosition:CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-30)];
//
//                    [mySpaceObject11 setName:@"space object"];
//                    [self addChild:mySpaceObject11];
//                    [mySpaceObject11 runAction:mySpaceObjectAction];
//                    break;
//                }
//
//                case 12:
//                {
//                    SKSpriteNode *mySpaceObject12 = [ SKSpriteNode spriteNodeWithImageNamed:@"17125224860_dfdc354bd4_o"];
//                    [mySpaceObject12 setScale: mySpaceObjectScale ];
//                    [mySpaceObject12 setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:mySpaceObjectSize]];
//                    [mySpaceObject12.physicsBody setAffectedByGravity:YES];
//                    [mySpaceObject12.physicsBody setRestitution:mySpaceObjectRestitution];
//                    //        [mySpaceObject12.physicsBody setContactTestBitMask:0x03];
//                    [mySpaceObject12.physicsBody setLinearDamping:mySpaceObjectLinearDampingFactor];
//                    [mySpaceObject12.physicsBody setMass:myCircleMass];
//                    //                mySpaceObject12.position = CGPointMake(CGRectGetMidX(self.frame) + 100 , CGRectGetMaxY(self.frame) - myYOffset );
//                    [mySpaceObject12 setPosition:CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-30)];
//
//                    [mySpaceObject12 setName:@"space object"];
//                    [self addChild:mySpaceObject12];
//                    [mySpaceObject12 runAction:mySpaceObjectAction];
//                    break;
//                }
//
//                case 13:
//                {
//                    SKSpriteNode *mySpaceObject13 = [ SKSpriteNode spriteNodeWithImageNamed:@"etacarinae_hubble_900"];
//                    [mySpaceObject13 setScale: mySpaceObjectScale ];
//                    [mySpaceObject13 setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:mySpaceObjectSize]];
//                    [mySpaceObject13.physicsBody setAffectedByGravity:YES];
//                    [mySpaceObject13.physicsBody setRestitution:mySpaceObjectRestitution];
//                    //        [mySpaceObject13.physicsBody setContactTestBitMask:0x03];
//                    [mySpaceObject13.physicsBody setLinearDamping:mySpaceObjectLinearDampingFactor];
//                    [mySpaceObject13.physicsBody setMass:myCircleMass];
//                    //                mySpaceObject13.position = CGPointMake(CGRectGetMidX(self.frame) + 125 , CGRectGetMaxY(self.frame) - myYOffset );
//                    [mySpaceObject13 setPosition:CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-30)];
//
//                    [mySpaceObject13 setName:@"space object"];
//                    [self addChild:mySpaceObject13];
//                    [mySpaceObject13 runAction:mySpaceObjectAction];
//
//                    break;
//                }
//
//                case 14:
//                {
//                    SKSpriteNode *mySpaceObject14 = [ SKSpriteNode spriteNodeWithImageNamed:@"hubble_friday_08212015"];
//                    [mySpaceObject14 setScale: mySpaceObjectScale ];
//                    [mySpaceObject14 setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:mySpaceObjectSize]];
//                    [mySpaceObject14.physicsBody setAffectedByGravity:YES];
//                    [mySpaceObject14.physicsBody setRestitution:mySpaceObjectRestitution];
//                    //        [mySpaceObject14.physicsBody setContactTestBitMask:0x03];
//                    [mySpaceObject14.physicsBody setLinearDamping:mySpaceObjectLinearDampingFactor];
//                    [mySpaceObject14.physicsBody setMass:myCircleMass];
//                    //                mySpaceObject14.position = CGPointMake(CGRectGetMidX(self.frame) + 150 , CGRectGetMaxY(self.frame) - myYOffset );
//                    [mySpaceObject14 setPosition:CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-30)];
//
//                    [mySpaceObject14 setName:@"space object"];
//                    [self addChild:mySpaceObject14];
//                    [mySpaceObject14 runAction:mySpaceObjectAction];
//
//                    break;
//                }
//
//                case 15:
//                {
//                    SKSpriteNode *mySpaceObject15 = [ SKSpriteNode spriteNodeWithImageNamed:@"flame"];
//                    [mySpaceObject15 setScale: mySpaceObjectScale ];
//                    [mySpaceObject15 setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:mySpaceObjectSize]];
//                    [mySpaceObject15.physicsBody setAffectedByGravity:YES];
//                    [mySpaceObject15.physicsBody setRestitution:mySpaceObjectRestitution];
//                    //        [mySpaceObject15.physicsBody setContactTestBitMask:0x03];
//                    [mySpaceObject15.physicsBody setLinearDamping:mySpaceObjectLinearDampingFactor];
//                    [mySpaceObject15.physicsBody setMass:myCircleMass];
//                    //                mySpaceObject15.position = CGPointMake(CGRectGetMidX(self.frame) + 175 , CGRectGetMaxY(self.frame) - myYOffset );
//                    [mySpaceObject15 setPosition:CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-30)];
//
//                    [mySpaceObject15 setName:@"space object"];
//                    [self addChild:mySpaceObject15];
//                    [mySpaceObject15 runAction:mySpaceObjectAction];
//
//                    mySpaceSpriteImageNumber = 1;
//
//                    break;
//
//                }
//                default:
//                    break;
//            }
//        } // end of loop
//
//    }];
//
//
//    // rz if there are too many little flying things, remove them
//    //
//    if ( self.children.count > 1000) {
//
//        [self myRemoveMovingSprites];
//
//    }
//}
//



