//
//  GameScene.m
//  Sprites and Forces
//
//  Created by Robert Zimmelman on 12/23/14.
//  Copyright (c) 2014 Robert Zimmelman. All rights reserved.
//

#import "GameScene.h"

int myCircleSpriteImageNumber = 0;
int myCircleSpriteSize = 20.0;
float myCircleSpriteScale = 0.2;
float myCircleSpriteRestitution = 0.9;
float myCircleMass = 1.0;
int myCircleSpriteLoops = 1;


long myForceIndex = 0;
long mySpringStrength = -1.1;
long mySpringStartStrength = -1;

long myGravityStartStrength = 1.0;
float myGravityStrength = 1.0;
long myGravityFalloff = 2.0 ;

long myVortexStrength = 10.0;
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
float myColorSpriteSize = 4.0;
int myColorSpriteCount = 13;
BOOL myTrailsIndicator = NO;


float myElapsedTime = 0;




//long myVortexSpringStrength = 1;
float myTempMass = 0.0;
float myMassIncrement = 10.0;
//id myTopControl;
//id myBottomControl;



float myYOffset = 30;

SKSpriteNode *myColorSprite;
@implementation GameScene
@synthesize myQueue;
@synthesize myBG;
@synthesize myPositionSprite;
@synthesize myCursorSprite;
@synthesize mySecondaryHelperLabel;
@synthesize myTopControl;
@synthesize myTopControlValues;

@synthesize myBottomControl;
@synthesize myBottomControlValues;


float myLastTime = 0;

-(void)update:(NSTimeInterval)currentTime{
    //
    //
    //    NSLog(@"Sprite Count = %ld",self.children.count);
    //
    //  rz check to see if any sprites are outside of the frame
    
    
    //    [self enumerateChildNodesWithName:@"color" usingBlock:^(SKNode *node, BOOL *stop) {
    //        if (![node intersectsNode:myBG] ) {
    //            NSLog(@"node outside of frame X = %f, Y = %f", node.position.x, node.position.y);
    //            [node removeFromParent];
    //        }
    //    }];
    //    [self enumerateChildNodesWithName:@"texture" usingBlock:^(SKNode *node, BOOL *stop) {
    //        if (![node intersectsNode:myBG] ) {
    //            NSLog(@"node outside of frame X = %f, Y = %f", node.position.x, node.position.y);
    //            [node removeFromParent];
    //        }
    //    }];
    //    [self enumerateChildNodesWithName:@"space object" usingBlock:^(SKNode *node, BOOL *stop) {
    //        if (![node intersectsNode:myBG] ) {
    //            NSLog(@"node outside of frame X = %f, Y = %f", node.position.x, node.position.y);
    //            [node removeFromParent];
    //        }
    //    }];
    //
    
    
    
    
    //        if ( (node.position.x <0 ) || (node.position.y < 0)  || ( (node.position.y > self.frame.size.height ) || (node.position.x > self.frame.size.width)   ) ) {
    
    
    //
    //  rz check the elapsed time between frames and if it's too big,
    //  then remove the colors, textures, and planets
    //
    //
    myElapsedTime = currentTime - myLastTime;
    if (myElapsedTime > 1.0) {
        
        myQueue = [NSOperationQueue mainQueue];
        
        
        [myQueue addOperationWithBlock: ^{
            
            NSLog(@"Elapsed Time  %f  Is Too Large, REMOVING OBJECTS!!!",myElapsedTime);
            [mySecondaryHelperLabel setHidden:NO];
            [mySecondaryHelperLabel setAlpha:1.0];
            [mySecondaryHelperLabel setText:@"Too Much SPACE JUNK!!! Cleaning Up Your Mess"];
            SKAction *myNodeFade = [SKAction sequence:@[[SKAction fadeOutWithDuration:(NSTimeInterval) 5.00],]];
            [mySecondaryHelperLabel runAction:myNodeFade];
            [self enumerateChildNodesWithName:@"colorsprite" usingBlock:^(SKNode *node, BOOL *stop) {
                [node removeFromParent];
            }];
            [self enumerateChildNodesWithName:@"texture" usingBlock:^(SKNode *node, BOOL *stop) {
                [node removeFromParent];
            }];
            [self enumerateChildNodesWithName:@"space object" usingBlock:^(SKNode *node, BOOL *stop) {
                [node removeFromParent];
            }];
            
        }];
        
    }
    //
    // store the current time.  next frame we'll compare this time to the current time
    //  and dump the sprites if the time is too long meaning the frame took too long to refresh
    //
    myLastTime = currentTime;
    
    //    myFrameCounter++;
    //    if (myFrameCounter >= myFrameInterval) {
    //        // reset the counter
    //        myFrameCounter = 0;
    //        //
    //        //
    //        //  think about doing this on a background queue, since it's only done every N seconds, e.g.
    //        //   it doesn't need to complete IMMEDIATELY
    //        //
    //
    //        myQueue = [NSOperationQueue mainQueue];
    //        [myQueue addOperationWithBlock: ^{
    //
    //            [self enumerateChildNodesWithName:@"color" usingBlock:^(SKNode *node, BOOL *stop) {
    //                [ (SKSpriteNode *) node setColor:[UIColor colorWithRed:myRandomR green:myRandomG blue:myRandomB alpha:1.0]];
    //            }];
    //
    //        }];
    //
    //
    //    }
    
}




-(float)myRandom{
    float myRandomValue = 0;
    myRandomValue = arc4random()%1000;
    myRandomValue = myRandomValue / 1000;
    //    NSLog(@"%f",myRandomValue);
    return myRandomValue;
}




-(void)willMoveFromView:(SKView *)view {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                 name:@"retimesidebuttons" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"showtrails" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"hidetrails" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"showforces" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"hideforces" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"increaseGravity" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"decreaseGravity" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"resetGravity" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"increaseVortex" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"decreaseVortex" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"resetVortex" object:nil];
    
    
}

-(void)myShowTrails{
    NSLog(@"showtrails");
    [self enumerateChildNodesWithName:@"trailsprite" usingBlock:^(SKNode *node, BOOL *stop) {
        [node setHidden:NO];
    }];
    
}

-(void)myHideTrails{
    NSLog(@"hidetrails");
    [self enumerateChildNodesWithName:@"trailsprite" usingBlock:^(SKNode *node, BOOL *stop) {
        [node setHidden:YES];
    }];
}


-(void)myShowForces{
    [self.view setShowsFields:YES];
    //    [[self.view viewWithTag:101] setAlpha:0.5];
    //    [[self.view viewWithTag:202] setAlpha:0.5];
    //    [[self.view viewWithTag:303] setAlpha:0.5];
    //    [myTopControl setAlpha:0.5];
}

-(void)myHideForces{
    [self.view setShowsFields:NO];
    //    [[self.view viewWithTag:101] setAlpha:0.25];
    //    [[self.view viewWithTag:202] setAlpha:0.25];
    //    [[self.view viewWithTag:303] setAlpha:0.25];
    //    [myTopControl setAlpha:0.25];
}




-(void)didMoveToView:(SKView *)view {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(myRetimeSideControlAnimation)
                                                 name:@"retimesidebuttons" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(myShowTrails)
                                                 name:@"showtrails" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(myHideTrails)
                                                 name:@"hidetrails" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(myShowForces)
                                                 name:@"showforces" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(myHideForces)
                                                 name:@"hideforces" object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(myIncreaseGravity)
                                                 name:@"increaseGravity" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(myDecreaseGravity)
                                                 name:@"decreaseGravity" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(myResetGravity)
                                                 name:@"resetGravity" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(myIncreaseVortex)
                                                 name:@"increaseVortex" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(myDecreaseVortex)
                                                 name:@"decreaseVortex" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(myResetVortex)
                                                 name:@"resetVortex" object:nil];
    
    
    
    //    [self.view setFrame:CGRectMake(0, 100, self.scene.size.width, self.scene.size.height)];
    
    
    
    
    
    [self setBackgroundColor:[UIColor blackColor]];
    [self setScaleMode:SKSceneScaleModeAspectFill];
    //    self.scaleMode = SKSceneScaleModeAspectFit;
    //    self.scaleMode = SKSceneScaleModeAspectFill;
    //    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    [self.physicsWorld setGravity:CGVectorMake(0.0, -0.4)];
    
    
    [self.scene setSize:self.view.bounds.size];
    self.scene.scaleMode = SKSceneScaleModeAspectFit;
    
    
    [self setPhysicsBody:[SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame] ];
    
    
    
    NSLog(@"height = %f, width = %f",[self frame].size.height,[self frame].size.width );
    
    
    switch ( (int) [[UIScreen mainScreen] bounds].size.height ) {
        case 736:
            // it's a 6 plus
            
            [myTopControl setContentScaleFactor:1.0];
            
            
            //            [myTopControl setFont:[UIFont fontWithName:@"Helvetica" size:24]];
            break;
        case 667:
            // it's a 6
            //            [tView setFont:[UIFont fontWithName:@"Helvetica" size:20]];
            break;
        case 568:
            // it's a 5
            //            [tView setFont:[UIFont fontWithName:@"Helvetica" size:18]];
            break;
        case 480:
            // it's a 4s
            
            
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
    
    
    //    NSArray *myBottomControlValues  = @[@"V-",@"V+",@"VR",@"Vortex",@"Anti-Grav",@"Grav",@"G+",@"G-",@"GR"] ;
    myBottomControlValues  = @[@"Vortex",@"Gravity",@"Anti-Gravity"] ;
    myBottomControl = [[ UISegmentedControl alloc] initWithItems:myBottomControlValues ];
    
    
    [myBottomControl setFrame:CGRectMake(0, self.view.bounds.size.height - myControlHeight , self.view.bounds.size.width  , myControlHeight  )];
    [myBottomControl setApportionsSegmentWidthsByContent:YES];
    [myBottomControl addTarget:self action:@selector(myBottomSwitchChanged:) forControlEvents:UIControlEventValueChanged ];
    myForceIndex = 0;
    [myBottomControl setSelectedSegmentIndex:myForceIndex];
    [self.view addSubview:myBottomControl];
    
    
    
    myTopControlValues  = @[@"Textures",@"Colors",@"Space", @"Trails",@"Quit"] ;
    myTopControl = [[ UISegmentedControl alloc] initWithItems:myTopControlValues ];
    
    //
    //
    //  add a target so we stop the animation to remove the menu if the user interacts with the
    //   control
    [myTopControl addTarget:self action:@selector(myRetimeTopControlAnimation) forControlEvents:UIControlEventAllEvents];
    [myTopControl addTarget:self action:@selector(myTopSwitchChanged:) forControlEvents:UIControlEventValueChanged ];
    //
    [myTopControl setFrame:CGRectMake(0, 0, self.view.bounds.size.width, myControlHeight)];
    [myTopControl setApportionsSegmentWidthsByContent:YES];
    [self.view addSubview:myTopControl];
    
    [myTopControl setHidden:YES];
    [myBottomControl setHidden:YES];
    
    [[self.view viewWithTag:101] setHidden:YES];
    
    //    [myTopControl setCenter:CGPointMake(myTopControl.frame.origin.x, myTopControl.frame.origin.y - 1000)];
    //    [myBottomControl setCenter:CGPointMake(myBottomControl.frame.origin.x, myBottomControl.frame.origin.y - 1000)];
    [[self.view viewWithTag:101] setCenter:CGPointMake([self.view viewWithTag:101].frame.origin.x, [self.view viewWithTag:101].frame.origin.y - 1000)];
    [[self.view viewWithTag:202] setCenter:CGPointMake([self.view viewWithTag:202].frame.origin.x, [self.view viewWithTag:202].frame.origin.y - 1000)];
    [[self.view viewWithTag:303] setCenter:CGPointMake([self.view viewWithTag:303].frame.origin.x, [self.view viewWithTag:303].frame.origin.y - 1000)];
    [[self.view viewWithTag:101] setHidden:YES];
    
    
    /* Setup your scene here */
    
    // set up the primary instruction label
    [ (SKLabelNode *) [self childNodeWithName:@"myPrimaryInstructionLabel"] setText:[NSString stringWithFormat:@"Tap to Drop %@", myBottomControlValues[myForceIndex]]];
    
    [self makeMyInstructionLabels];
    //    [myTopControl setSelectedSegmentIndex:4];
    
    [(SKLabelNode *) [self childNodeWithName:@"myVortexValueSprite"] setText: [NSString stringWithFormat:   @"Vortex = %0.2f",myVortexStrength/10.0f]];
    [(SKLabelNode *) [self childNodeWithName:@"myGravityValueSprite"] setText: [NSString stringWithFormat:   @"Gravity = %0.2f",myGravityStrength/1.0f]];

    
    [(SKLabelNode *) [self childNodeWithName:@"myVortexValueSprite"] setHidden:YES];
    [(SKLabelNode *) [self childNodeWithName:@"myGravityValueSprite"] setHidden:YES];

    
    
    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    myLabel.text = @"Sprites and Forces!  Tap Screen to Place Force Fields";
    myLabel.fontSize = 12;
    myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                   CGRectGetMidY(self.frame)+200);
    [self addChild:myLabel];
    [myLabel runAction:[SKAction sequence:@[ [SKAction waitForDuration:10.0],
                                             [SKAction removeFromParent],
                                             ]]];
    
    
    
    
}

-(void)myDecreaseGravity{
    myGravityStrength -= 0.2f;
    [(SKLabelNode *) [self childNodeWithName:@"myGravityValueSprite"] setText: [NSString stringWithFormat:   @"Gravity = %0.2f",myGravityStrength/1.0]];
    [self enumerateChildNodesWithName:@"gravityposition" usingBlock:^(SKNode *node, BOOL *stop) {
        //
        //
        // the position sprite is the child , the gravity node is the child of hte position sprite
        //
        //
        [node enumerateChildNodesWithName:@"gravity" usingBlock:^(SKNode *node, BOOL *stop) {
            //            NSLog(@"found a gravity node");
            NSLog(@"strength before decrease gravity = %f",    [ (SKFieldNode *)   node strength ]) ;
            [ (SKFieldNode *)   node setStrength: myGravityStrength];
            
            //
            //
            //  rz if we're below 0, then change the emitter to an anti-gravity emitter
            //
            //
            
            //            if (myGravityStrength < 0.0) {
            //                [[node parent ] removeAllChildren];
            //                NSString *mySpringEmitterNodePath = [[NSBundle mainBundle] pathForResource:@"myParticle" ofType:@"sks"];
            //                SKEmitterNode *mySpringNodeEmitter =  [NSKeyedUnarchiver unarchiveObjectWithFile:mySpringEmitterNodePath];
            //
            //                [[node parent] addChild:mySpringNodeEmitter];
            //            }
            
            
            NSLog(@"strength after decrease gravity = %f",    [ (SKFieldNode *)   node strength ]) ;
        }];
    }];
}


-(void)myIncreaseGravity{
    myGravityStrength += 0.2f;
    [(SKLabelNode *) [self childNodeWithName:@"myGravityValueSprite"] setText: [NSString stringWithFormat:   @"Gravity = %0.2f",myGravityStrength/1.0]];
    
    [self enumerateChildNodesWithName:@"gravityposition" usingBlock:^(SKNode *node, BOOL *stop) {
        //
        //
        // the position sprite is the child , the gravity node is the child of hte position sprite
        //
        //
        [node enumerateChildNodesWithName:@"gravity" usingBlock:^(SKNode *node, BOOL *stop) {
            //            NSLog(@"found a gravity node");
            //            NSLog(@"radial gravity increment = %ld", myRadialGravityIncrement);
            NSLog(@"strength before increase gravity = %f",    [ (SKFieldNode *)   node strength ]) ;
            [ (SKFieldNode *)   node setStrength: myGravityStrength];
            NSLog(@"strength after increase gravity = %f",    [ (SKFieldNode *)   node strength ]) ;
        }];
    }];
    
}


-(void)myResetGravity{
    myGravityStrength = myGravityStartStrength;
    [(SKLabelNode *) [self childNodeWithName:@"myGravityValueSprite"] setText: [NSString stringWithFormat:   @"Gravity = %0.2f",myGravityStrength]];
    NSLog(@"in my reset gravity");
    [self enumerateChildNodesWithName:@"gravityposition" usingBlock:^(SKNode *node, BOOL *stop) {
        [node enumerateChildNodesWithName:@"gravity" usingBlock:^(SKNode *node, BOOL *stop) {
            //            NSLog(@"found a gravity node");
            //            NSLog(@"strength before reset gravity = %f",    [ (SKFieldNode *)   node strength ]) ;
            [ (SKFieldNode *)   node setStrength: myGravityStartStrength];
            //            NSLog(@"strength after reset gravity = %f",    [ (SKFieldNode *)   node strength ]) ;
        }];
    }];
}



//-(void)myDecreaseGravity{
//    [self enumerateChildNodesWithName:@"gravityposition" usingBlock:^(SKNode *node, BOOL *stop) {
//        //
//        //
//        // the position sprite is the child , the gravity node is the child of hte position sprite
//        //
//        //
//        [node enumerateChildNodesWithName:@"gravity" usingBlock:^(SKNode *node, BOOL *stop) {
//            //            NSLog(@"found a gravity node");
//            NSLog(@"strength before decrease gravity = %f",    [ (SKFieldNode *)   node strength ]) ;
//            [ (SKFieldNode *)   node setStrength: [(SKFieldNode *) node strength] -  2.0];
//            NSLog(@"strength after decrease gravity = %f",    [ (SKFieldNode *)   node strength ]) ;
//        }];
//    }];
//}
//
//
//-(void)myIncreaseGravity{
//    [self enumerateChildNodesWithName:@"gravityposition" usingBlock:^(SKNode *node, BOOL *stop) {
//        //
//        //
//        // the position sprite is the child , the gravity node is the child of hte position sprite
//        //
//        //
//        [node enumerateChildNodesWithName:@"gravity" usingBlock:^(SKNode *node, BOOL *stop) {
//            //            NSLog(@"found a gravity node");
//            //            NSLog(@"radial gravity increment = %ld", myRadialGravityIncrement);
//            NSLog(@"strength before increase gravity = %f",    [ (SKFieldNode *)   node strength ]) ;
//            [ (SKFieldNode *)   node setStrength: [   (SKFieldNode *) node strength] +  2.0 ];
//            NSLog(@"strength after increase gravity = %f",    [ (SKFieldNode *)   node strength ]) ;
//        }];
//    }];
//    
//}
//
//
//
//
//-(void)myResetGravity{
//    NSLog(@"in my reset gravity");
//    [self enumerateChildNodesWithName:@"gravityposition" usingBlock:^(SKNode *node, BOOL *stop) {
//        [node enumerateChildNodesWithName:@"gravity" usingBlock:^(SKNode *node, BOOL *stop) {
//            //            NSLog(@"found a gravity node");
//            //            NSLog(@"strength before reset gravity = %f",    [ (SKFieldNode *)   node strength ]) ;
//            [ (SKFieldNode *)   node setStrength: myRadialGravityStrength];
//            //            NSLog(@"strength after reset gravity = %f",    [ (SKFieldNode *)   node strength ]) ;
//        }];
//    }];
//}






//-(void)myDecreaseVortex{
//    //
//    [self enumerateChildNodesWithName:@"vortexposition" usingBlock:^(SKNode *node, BOOL *stop) {
//        //
//        //
//        //
//        // the position sprite is the child , the Vortex node is the child of hte position sprite
//        //
//        //
//        [node enumerateChildNodesWithName:@"vortex" usingBlock:^(SKNode *node, BOOL *stop) {
//            NSLog(@"myVortexStrength before decrease vortex = %ld", myVortexStrength) ;
//            [ (SKFieldNode *)   node setStrength: [   (SKFieldNode *) node strength] -  2.0 ];
//            myVortexStrength = [ (SKFieldNode *) node strength];
//            
//            SKAction *mySlowSpin = [SKAction repeatActionForever:[SKAction sequence:@[
//                                                                                      [SKAction rotateByAngle:myVortexStrength*50 duration:myVortexDuration],]]];
//            [ (SKSpriteNode *) node.parent removeAllActions];
//            [ (SKSpriteNode *) node.parent runAction:mySlowSpin];
//            NSLog(@"myVortexStrength after decrease vortex = %ld", myVortexStrength) ;
//        }];
//        
//        
//    }];
//}
//
//
//-(void)myIncreaseVortex{
//    [self enumerateChildNodesWithName:@"vortexposition" usingBlock:^(SKNode *node, BOOL *stop) {
//        //
//        //
//        // the position sprite is the child , the Vortex node is the child of hte position sprite
//        //
//        [node enumerateChildNodesWithName:@"vortex" usingBlock:^(SKNode *node, BOOL *stop) {
//            //            NSLog(@"found a vortex node");
//            //            NSLog(@"radial gravity increment = %ld", myRadialGravityIncrement);
//            //            NSLog(@"strength before increase vortex = %f",    [ (SKFieldNode *)   node strength ]) ;
//            [ (SKFieldNode *)   node setStrength: [   (SKFieldNode *) node strength] +  2.0 ];
//            myVortexStrength = [ (SKFieldNode *) node strength];
//            SKAction *mySlowSpin = [SKAction repeatActionForever:[SKAction sequence:@[
//                                                                                      [SKAction rotateByAngle:myVortexStrength*50 duration:myVortexDuration],]]];
//            [ (SKSpriteNode *) node.parent removeAllActions];
//            [ (SKSpriteNode *) node.parent runAction:mySlowSpin];
//            NSLog(@"myVortexStrength after increase vortex = %ld", myVortexStrength) ;
//        }];
//    }];
//    
//}
//
//
//
//
//-(void)myResetVortex{
//    [self enumerateChildNodesWithName:@"vortexposition" usingBlock:^(SKNode *node, BOOL *stop) {
//        
//        //        myVortexStrength = 10.0;
//        //
//        //        [node removeAllActions];
//        //        SKAction *mySlowSpin = [SKAction rotateByAngle:myVortexStrength*50 duration:myColorSpriteDuration];
//        //        [node runAction:mySlowSpin];
//        //
//        
//        [node enumerateChildNodesWithName:@"vortex" usingBlock:^(SKNode *node, BOOL *stop) {
//            //            NSLog(@"found a Vortex node");
//            //            NSLog(@"strength before reset Vortex = %f",    [ (SKFieldNode *)   node strength ]) ;
//            [ (SKFieldNode *)   node setStrength: myVortexStartStrength];
//            SKAction *mySlowSpin = [SKAction sequence:@[
//                                                        [SKAction rotateByAngle:myVortexStartStrength*50 duration:myVortexDuration],
//                                                        ]];
//            [ (SKSpriteNode *) node.parent removeAllActions];
//            [ (SKSpriteNode *) node.parent runAction:mySlowSpin];
//            
//            //            NSLog(@"strength after reset Vortex = %f",    [ (SKFieldNode *)   node strength ]) ;
//        }];
//    }];
//}



-(void)myDecreaseVortex{
    //
    myVortexStrength -= 2.0;
    
    [(SKLabelNode *) [self childNodeWithName:@"myVortexValueSprite"] setText: [NSString stringWithFormat:   @"Vortex = %0.2f",myVortexStrength/10.0f]];
    
    [self enumerateChildNodesWithName:@"vortexposition" usingBlock:^(SKNode *node, BOOL *stop) {
        //
        //
        //
        // the position sprite is the child , the Vortex node is the child of hte position sprite
        //
        //
        [node enumerateChildNodesWithName:@"vortex" usingBlock:^(SKNode *node, BOOL *stop) {
            NSLog(@"myVortexStrength before decrease vortex = %ld", myVortexStrength) ;
            [ (SKFieldNode *)   node setStrength: myVortexStrength];
            
            SKAction *mySlowSpin = [SKAction repeatActionForever:[SKAction sequence:@[
                                                                                      [SKAction rotateByAngle:myVortexStrength*50 duration:myVortexDuration],]]];
            [ (SKSpriteNode *) node.parent removeAllActions];
            [ (SKSpriteNode *) node.parent runAction:mySlowSpin];
            NSLog(@"myVortexStrength after decrease vortex = %ld", myVortexStrength) ;
        }];
        
        
    }];
}


-(void)myIncreaseVortex{
    myVortexStrength += 2.0;
    
    [(SKLabelNode *) [self childNodeWithName:@"myVortexValueSprite"] setText: [NSString stringWithFormat:   @"Vortex = %0.2f",myVortexStrength/10.0f]];
    [self enumerateChildNodesWithName:@"vortexposition" usingBlock:^(SKNode *node, BOOL *stop) {
        //
        //
        // the position sprite is the child , the Vortex node is the child of hte position sprite
        //
        [node enumerateChildNodesWithName:@"vortex" usingBlock:^(SKNode *node, BOOL *stop) {
            //            NSLog(@"found a vortex node");
            //            NSLog(@"radial gravity increment = %ld", myRadialGravityIncrement);
            //            NSLog(@"strength before increase vortex = %f",    [ (SKFieldNode *)   node strength ]) ;
            [ (SKFieldNode *)   node setStrength: myVortexStrength];
            SKAction *mySlowSpin = [SKAction repeatActionForever:[SKAction sequence:@[
                                                                                      [SKAction rotateByAngle:myVortexStrength*50 duration:myVortexDuration],]]];
            [ (SKSpriteNode *) node.parent removeAllActions];
            [ (SKSpriteNode *) node.parent runAction:mySlowSpin];
            NSLog(@"myVortexStrength after increase vortex = %ld", myVortexStrength) ;
        }];
    }];
    
}




-(void)myResetVortex{
    myVortexStrength = myVortexStartStrength;
    [(SKLabelNode *) [self childNodeWithName:@"myVortexValueSprite"] setText: [NSString stringWithFormat:   @"Vortex = %0.2f",myVortexStrength/10.0f]];
    
    [self enumerateChildNodesWithName:@"vortexposition" usingBlock:^(SKNode *node, BOOL *stop) {
        
        [node enumerateChildNodesWithName:@"vortex" usingBlock:^(SKNode *node, BOOL *stop) {
            //            NSLog(@"found a Vortex node");
            //            NSLog(@"strength before reset Vortex = %f",    [ (SKFieldNode *)   node strength ]) ;
            [ (SKFieldNode *)   node setStrength: myVortexStartStrength];
            SKAction *mySlowSpin = [SKAction sequence:@[
                                                        [SKAction rotateByAngle:myVortexStartStrength*50 duration:myVortexDuration],
                                                        ]];
            [ (SKSpriteNode *) node.parent removeAllActions];
            [ (SKSpriteNode *) node.parent runAction:mySlowSpin];
            
            //            NSLog(@"strength after reset Vortex = %f",    [ (SKFieldNode *)   node strength ]) ;
        }];
    }];
}








- (void)myOldMakeColors{
    NSInteger myNumberOfLoops = 5;
    NSInteger myColorSpriteSize = 10;
    //        SKSpriteNode *myColorSprite = [ SKSpriteNode spriteNodeWithColor:[UIColor darkGrayColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
    for ( int i = 1 ; i < myNumberOfLoops ; i++){
        for (int mySpriteCounter = 1; mySpriteCounter <= 13; mySpriteCounter++) {
            switch (mySpriteCounter) {
                case 1:
                    myColorSprite =  [SKSpriteNode spriteNodeWithColor:[UIColor blackColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
                    break;
                case 2:
                    myColorSprite = [ SKSpriteNode spriteNodeWithColor:[UIColor darkGrayColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
                    break;
                case 3:
                    myColorSprite = [ SKSpriteNode spriteNodeWithColor:[UIColor lightGrayColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
                    break;
                case 4:
                    myColorSprite = [ SKSpriteNode spriteNodeWithColor:[UIColor whiteColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
                    break;
                case 5:
                    myColorSprite = [ SKSpriteNode spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
                    break;
                case 6:
                    myColorSprite = [ SKSpriteNode spriteNodeWithColor:[UIColor greenColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
                    break;
                case 7:
                    myColorSprite = [ SKSpriteNode spriteNodeWithColor:[UIColor blueColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
                    break;
                case 8:
                    myColorSprite = [ SKSpriteNode spriteNodeWithColor:[UIColor cyanColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
                    break;
                case 9:
                    myColorSprite = [ SKSpriteNode spriteNodeWithColor:[UIColor yellowColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
                    break;
                case 10:
                    myColorSprite = [ SKSpriteNode spriteNodeWithColor:[UIColor magentaColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
                    break;
                case 11:
                    myColorSprite = [ SKSpriteNode spriteNodeWithColor:[UIColor orangeColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
                    break;
                case 12:
                    myColorSprite = [ SKSpriteNode spriteNodeWithColor:[UIColor purpleColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
                    break;
                case 13:
                    myColorSprite = [ SKSpriteNode spriteNodeWithColor:[UIColor brownColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
                    break;
                default:
                    break;
            }  // end of switch
            myColorSprite.position = CGPointMake(CGRectGetMidX(self.frame),
                                                 CGRectGetMaxY(self.frame)-30);
            myColorSprite.physicsBody = [ SKPhysicsBody bodyWithRectangleOfSize:myColorSprite.size];
            myColorSprite.physicsBody.mass = 1;
            myColorSprite.physicsBody.restitution = .9;
            myColorSprite.physicsBody.affectedByGravity = YES;
            myColorSprite.physicsBody.linearDamping = 3.0;
            myColorSprite.blendMode = SKBlendModeReplace ;
            myColorSprite.physicsBody.contactTestBitMask = 0x03;
            [myColorSprite setName:@"colorsprite"];
            [self addChild:myColorSprite];
            SKAction *mycolorSpriteAction =    [SKAction sequence:@[
                                                                    [SKAction waitForDuration:myColorSpriteDuration withRange:1.5],
                                                                    [SKAction removeFromParent],
                                                                    ]];
            [myColorSprite runAction:mycolorSpriteAction];
        }  // end of mySpriteCounter Loop
    }  // end of myNUmberOfLoops Loop
    
}


- (IBAction)myTopSwitchChanged:(UISegmentedControl *)sender{
    
    //
    //
    // if the user touched the top switch, stop the 'remove' animation
    //
    [UIView cancelPreviousPerformRequestsWithTarget:self];

    
    myForceIndex = sender.selectedSegmentIndex;

    
    
    
    if (myForceIndex == 0) {
        [self myMakeTextures];
        //
        // set top switch to 0 to drop simplest item
        [sender setSelectedSegmentIndex:-1];

        
    } // end of if myValue == 0
    
    else if (myForceIndex == 1) {

        myTrailsIndicator = NO;
        [self myMakeColorsWithTrails: myTrailsIndicator];
        //
        // set top switch to 0 to drop simplest item
        [sender setSelectedSegmentIndex:-1];

    }
    else if (myForceIndex == 2) {
        
        [self myMakeCircles];
        //
        // set top switch to 0 to drop simplest item
        
        [sender setSelectedSegmentIndex:-1];

    }
    else if (myForceIndex == 3) {

        myTrailsIndicator = YES;
        [self myMakeColorsWithTrails: myTrailsIndicator];
        //
        // set top switch to 0 to drop simplest item
        [sender setSelectedSegmentIndex:-1];

    }
    else if (myForceIndex == 4){
        exit(0);
    }
    
}



-(void)myMakeVortex{
    // rz vortex
    //
    //
    //    NSString *mySpringEmitterNodePath = [[NSBundle mainBundle] pathForResource:@"MyParticle" ofType:@"sks"];
    //    SKEmitterNode *myEmitterNode =  [NSKeyedUnarchiver unarchiveObjectWithFile:mySpringEmitterNodePath];
    NSString *myVortexEmitterPath = [[NSBundle mainBundle] pathForResource:@"myVortexParticle" ofType:@"sks"] ;
    //                SKPhysicsBody *myVortexEmitterPhysicsBody = [SKPhysicsBody bodyWithCircleOfRadius:1];
    SKEmitterNode *myVortexEmitterNode = [NSKeyedUnarchiver unarchiveObjectWithFile:myVortexEmitterPath];
    SKFieldNode *myVortexFieldNode = [SKFieldNode vortexField];
    SKAction *mySlowSpin = [SKAction rotateByAngle:M_PI*50 duration:myColorSpriteDuration];
    [myVortexFieldNode setStrength:myVortexStartStrength];
    [myVortexFieldNode setFalloff: myVortexFalloff ];
    [myVortexFieldNode setName:@"vortex"];
    //    [myPositionSprite addChild:myEmitterNode];
    [myPositionSprite setName:@"vortexposition"];
    [myPositionSprite addChild:myVortexFieldNode];
    [myPositionSprite addChild:myVortexEmitterNode];
    [self addChild:myPositionSprite];
    [myPositionSprite runAction:mySlowSpin];
    
}



-(void)myMakeGravity{
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
}





-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    for (UITouch *touch in touches) {
        //        SKAction *myEffectSpriteAction = [SKAction sequence:@[
        //                                                              [SKAction waitForDuration:10.0 withRange:5.5],
        //                                                              [SKAction removeFromParent],
        //                                                              ]];
        CGPoint location = [touch locationInNode:self];
        myPositionSprite = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(1, 1)];
        [myPositionSprite setPosition:location];
        NSString *mySpringEmitterNodePath = [[NSBundle mainBundle] pathForResource:@"MyParticle" ofType:@"sks"];
        SKEmitterNode *mySpringNodeEmitter =  [NSKeyedUnarchiver unarchiveObjectWithFile:mySpringEmitterNodePath];
        SKFieldNode *mySpringFieldNode = [SKFieldNode springField];
        [mySpringFieldNode setStrength:myGravityStrength];
        //        SKSpriteNode *myForceImage = [SKSpriteNode spriteNodeWithImageNamed:@"rzForces Image.png"];
        //        NSLog(@"NOW myforce = %ld",myForce);
        
        switch (myForceIndex) {
            case 0:
            {
                //
                //
                //
                //
                [self myMakeVortex];
                break;
            }
            case 1:
            {
                //
                //
                //
                // rz gravity
                //
                [self myMakeGravity];
                break;
            }

            case 2:
            {
                //
                //
                //
                // rz spring
                //
                //
                SKAction *mySpringNodeFade = [SKAction sequence:@[
                                                                  [SKAction fadeInWithDuration:(NSTimeInterval) 0.25],
                                                                  [SKAction fadeOutWithDuration:(NSTimeInterval) 0.25],
                                                                  ]];
                [mySpringNodeEmitter setScale:1.5];
                [mySpringNodeEmitter runAction:[SKAction repeatActionForever:mySpringNodeFade]];
                
                //
                SKFieldNode *mySpringFieldNode = [SKFieldNode springField];
                [mySpringFieldNode setStrength: mySpringStrength ];
                [mySpringFieldNode setFalloff:mySpringFieldFalloff];
                [mySpringFieldNode setName:@"spring"];
                [myPositionSprite setPosition:location];
                //                [myPositionSprite runAction:myEffectSpriteAction];
                [myPositionSprite setName:@"springposition"];
                [myPositionSprite addChild:mySpringNodeEmitter];
                [myPositionSprite addChild:mySpringFieldNode];
                [self addChild:myPositionSprite];
                break;
            }
            default:
                break;
        }
        
    }
}


- (IBAction)myBottomSwitchChanged:(UISegmentedControl *)sender{
    //
    //
    //
    //  if the user touched the bottom switch, cancel the 'remove' animation
    //
    [UIView cancelPreviousPerformRequestsWithTarget:self];

    long myValue = sender.selectedSegmentIndex;
    myForceIndex = myValue;
    [sender setSelectedSegmentIndex:myForceIndex];
    //
    //
    // set the primary instruction label with the proper text
    //
    [ (SKLabelNode *) [self childNodeWithName:@"myPrimaryInstructionLabel"] setText:[NSString stringWithFormat:@"Tap to Drop %@", myBottomControlValues[myForceIndex]]];
}


-(void)myIncreaseColorSpriteMass{
    [self enumerateChildNodesWithName:@"colorsprite" usingBlock:^(SKNode *node, BOOL *stop) {
        myTempMass = node.physicsBody.mass + myMassIncrement;
        NSLog(@"Mass=%f",myTempMass);
        [node.physicsBody setMass:myTempMass];
    }];
    //    [myTopControl setAlpha:1];
    //    [myBottomControl setAlpha:1];
}

-(void)myDecreaseColorSpriteMass{
    [self enumerateChildNodesWithName:@"colorsprite" usingBlock:^(SKNode *node, BOOL *stop) {
        myTempMass = node.physicsBody.mass - myMassIncrement;
        NSLog(@"Mass=%f",myTempMass);
        [node.physicsBody setMass:myTempMass];
    }];
    //    [myTopControl setAlpha:0];
    //    [myBottomControl setAlpha:0];
}


-(void)myResetColorSpriteMass{
    [self enumerateChildNodesWithName:@"colorsprite" usingBlock:^(SKNode *node, BOOL *stop) {
        [node.physicsBody setMass:1];
    }];
}


-(void)myRetimeTopControlAnimation{
    NSLog(@"Want to stop removal of top  control");
    [UIView cancelPreviousPerformRequestsWithTarget:self];
    [self performSelector:@selector(myRemoveTopControl) withObject:self afterDelay:5.0];
}

-(void)myRetimeSideControlAnimation{
    NSLog(@"Want to stop removal of bottom control");
    [UIView cancelPreviousPerformRequestsWithTarget:self];
    [self performSelector:@selector(myRemoveSideControls) withObject:self afterDelay:5.0];
}



-(void)myUpSwipeAction{
    //
    //
    // if the middle menus are hidden, then show the middle menus
    if ([[self.view viewWithTag:202] isHidden]) {
        //
        // show the record buttons, the forces buttons and show/hide buttons
        //
        [[self.view viewWithTag:101] setHidden:NO];
        [[self.view viewWithTag:202] setHidden:NO];
        [[self.view viewWithTag:303] setHidden:NO];
        //
        //  show the vortex and gravity value sklabel nodes
        [(SKLabelNode *) [self childNodeWithName:@"myVortexValueSprite"] setHidden:NO];
        [(SKLabelNode *) [self childNodeWithName:@"myGravityValueSprite"] setHidden:NO];

        //
        //  trigger the disappearance of the middle menus if the user doesn't raise the top/bottom menus
        //
        [self performSelector:@selector(myRemoveSideControls) withObject:self afterDelay:5.0];
    }
    //
    //
    //  if the middle menus are showing, then raise the top and bottom menus
    //
    else {
        //
        //
        //    before raising the top and bottom controls, remove the animation that is removing the side menus
        [UIView cancelPreviousPerformRequestsWithTarget:self];
        //
        //
        //        [myTopControl setCenter:CGPointMake(myTopControl.frame.origin.x, myTopControl.frame.origin.y + 1000)];
        //        [myBottomControl setCenter:CGPointMake(myBottomControl.frame.origin.x, myBottomControl.frame.origin.y + 1000)];
//        [myTopControl setSelected:NO];
        [myTopControl setHidden:NO];
        [myBottomControl setHidden:NO];
        [self performSelector:@selector(myRemoveTopControl) withObject:self afterDelay:5.0];
      }
}



-(void)myRemoveTopControl{
    //
    //
    //
    //  if we just removed the top control, dont automatically remove the bottom control
    [self myRetimeSideControlAnimation];
    //
    //
    [UIView animateWithDuration:2.0 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [myTopControl setTintColor:[UIColor redColor]];
        [myBottomControl setTintColor:[UIColor redColor]];
        [[self.view viewWithTag:101] setTintColor:[UIColor redColor]];
    } completion:^(BOOL finished) {
        // when we're finished fully hide the top control
        //
        [myTopControl setTintColor:nil];
        [myBottomControl setTintColor:nil];
        [[self.view viewWithTag:101] setTintColor:nil];
        //
        //
        [myTopControl setHidden:YES];
        [myBottomControl setHidden:YES];

        //
        //  does this remove the side control?
        //
//        [self myDownSwipeAction];
//        [self performSelector:@selector(myRemoveSideControls) withObject:self afterDelay:5.0];
        //
        // only remove the top menu after the delay
        //        [self myDownSwipeAction];
    }];
    
}

-(void)myRemoveSideControls{
    [UIView animateWithDuration:2.0 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [[self.view viewWithTag:202] setTintColor:[UIColor redColor]];
        [[self.view viewWithTag:303] setTintColor:[UIColor redColor]];
    } completion:^(BOOL finished) {
        [[self.view viewWithTag:202] setTintColor:nil];
        [[self.view viewWithTag:303] setTintColor:nil];
        //
        //
        // explicitly hide the side controls here
        //
        [[self.view viewWithTag:101] setHidden:YES];
        [[self.view viewWithTag:202] setHidden:YES];
        [[self.view viewWithTag:303] setHidden:YES];
        [(SKLabelNode *) [self childNodeWithName:@"myVortexValueSprite"] setHidden:YES];
        [(SKLabelNode *) [self childNodeWithName:@"myGravityValueSprite"] setHidden:YES];
    }];
}



-(void)myDownSwipeAction{
    if ([myTopControl isHidden]) {
        [[self.view viewWithTag:101] setHidden:YES];
        [[self.view viewWithTag:202] setHidden:YES];
        [[self.view viewWithTag:303] setHidden:YES];
        [(SKLabelNode *) [self childNodeWithName:@"myVortexValueSprite"] setHidden:YES];
        [(SKLabelNode *) [self childNodeWithName:@"myGravityValueSprite"] setHidden:YES];
    } else {
        [myTopControl setHidden:YES];
        [myBottomControl setHidden:YES];
    }
    
    
}


-(void)myRightSwipeAction{
    [myTopControl setHidden:YES];
    [myBottomControl setHidden:YES];
}


-(void)myLeftSwipeAction{
    [myTopControl setHidden:NO];
    [myBottomControl setHidden:NO];
}


-(void)myLongPressAction{
    [self removeAllChildren];
    //    [self addChild:myBG];
    [self makeMyInstructionLabels];
}



-(void)myMakeCircles{
    myCircleSpriteImageNumber ++;
    SKAction *myCircleSpriteAction =    [SKAction sequence:@[
                                                             [SKAction waitForDuration:300.0 withRange:1.5],
                                                             [SKAction removeFromParent],
                                                             ]];
    
    for ( int i = 1 ; i <= myCircleSpriteLoops ; i++){
        switch (myCircleSpriteImageNumber) {
            case 1:
            {
                SKSpriteNode *myCircleSprite1 = [ SKSpriteNode spriteNodeWithImageNamed:@"alpha-5052129615_e3ea876e19_o"];
                [myCircleSprite1 setScale: (myCircleSpriteScale * 2) ];
                [myCircleSprite1 setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:(myCircleSpriteScale * 4) ]];
                [myCircleSprite1.physicsBody setAffectedByGravity:YES];
                [myCircleSprite1.physicsBody setAllowsRotation:NO];
                [myCircleSprite1.physicsBody setRestitution:myCircleSpriteRestitution];
                //        [myCircleSprite1.physicsBody setContactTestBitMask:0x03];
                [myCircleSprite1.physicsBody setLinearDamping:13.0];
                [myCircleSprite1.physicsBody setMass:myCircleMass];
                myCircleSprite1.position = CGPointMake(CGRectGetMidX(self.frame) - 175 , CGRectGetMaxY(self.frame) - myYOffset );
                //                [myCircleSprite1 setPosition:CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame))];
                [myCircleSprite1 setName:@"space object"];
                [self addChild:myCircleSprite1];
                [myCircleSprite1 runAction:myCircleSpriteAction];
                break;
            }
                
            case 2:
            {
                SKSpriteNode *myCircleSprite2 = [ SKSpriteNode spriteNodeWithImageNamed:@"5052743686_77244d3b97_o"];
                [myCircleSprite2 setScale: myCircleSpriteScale ];
                [myCircleSprite2 setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:myCircleSpriteSize]];
                [myCircleSprite2.physicsBody setAffectedByGravity:YES];
                [myCircleSprite2.physicsBody setRestitution:myCircleSpriteRestitution];
                //        [myCircleSprite2.physicsBody setContactTestBitMask:0x03];
                [myCircleSprite2.physicsBody setLinearDamping:13.0];
                [myCircleSprite2.physicsBody setMass:myCircleMass];
                //                myCircleSprite2.position = CGPointMake(CGRectGetMidX(self.frame) - 150 , CGRectGetMaxY(self.frame) - myYOffset );
                [myCircleSprite2 setPosition:CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-30)];
                
                [myCircleSprite2 setName:@"space object"];
                [self addChild:myCircleSprite2];
                [myCircleSprite2 runAction:myCircleSpriteAction];
                
                break;
            }
                
            case 3:
            {
                SKSpriteNode *myCircleSprite3 = [ SKSpriteNode spriteNodeWithImageNamed:@"5052744574_cc6c7338be_o"];
                [myCircleSprite3 setScale: myCircleSpriteScale ];
                [myCircleSprite3 setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:myCircleSpriteSize]];
                [myCircleSprite3.physicsBody setAffectedByGravity:YES];
                [myCircleSprite3.physicsBody setRestitution:myCircleSpriteRestitution];
                //        [myCircleSprite3.physicsBody setContactTestBitMask:0x03];
                [myCircleSprite3.physicsBody setLinearDamping:13.0];
                [myCircleSprite3.physicsBody setMass:myCircleMass];
                //                myCircleSprite3.position = CGPointMake(CGRectGetMidX(self.frame) - 125 , CGRectGetMaxY(self.frame) - myYOffset );
                [myCircleSprite3 setPosition:CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-30)];
                
                [myCircleSprite3 setName:@"space object"];
                [self addChild:myCircleSprite3];
                [myCircleSprite3 runAction:myCircleSpriteAction];
                break;
            }
                
            case 4:
            {
                SKSpriteNode *myCircleSprite4 = [ SKSpriteNode spriteNodeWithImageNamed:@"alpha-5277460575_a1b324700d_o"];
                [myCircleSprite4 setScale: (myCircleSpriteScale * 2) ];
                [myCircleSprite4 setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:(myCircleSpriteScale * 2)]];
                [myCircleSprite4.physicsBody setAffectedByGravity:YES];
                [myCircleSprite4.physicsBody setAllowsRotation:NO];
                
                [myCircleSprite4.physicsBody setRestitution:myCircleSpriteRestitution];
                //        [myCircleSprite4.physicsBody setContactTestBitMask:0x03];
                [myCircleSprite4.physicsBody setLinearDamping:13.0];
                [myCircleSprite4.physicsBody setMass:myCircleMass];
                //                myCircleSprite4.position = CGPointMake(CGRectGetMidX(self.frame) - 100 , CGRectGetMaxY(self.frame) - myYOffset );
                [myCircleSprite4 setPosition:CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-30)];
                
                [myCircleSprite4 setName:@"space object"];
                [self addChild:myCircleSprite4];
                [myCircleSprite4 runAction:myCircleSpriteAction];
                break;
            }
                
            case 5:
            {
                SKSpriteNode *myCircleSprite5 = [ SKSpriteNode spriteNodeWithImageNamed:@"5278071900_c040282c2d_o"];
                [myCircleSprite5 setScale: myCircleSpriteScale ];
                [myCircleSprite5 setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:myCircleSpriteSize]];
                [myCircleSprite5.physicsBody setAffectedByGravity:YES];
                [myCircleSprite5.physicsBody setRestitution:myCircleSpriteRestitution];
                //        [myCircleSprite5.physicsBody setContactTestBitMask:0x03];
                [myCircleSprite5.physicsBody setLinearDamping:13.0];
                [myCircleSprite5.physicsBody setMass:myCircleMass];
                //                myCircleSprite5.position = CGPointMake(CGRectGetMidX(self.frame) - 75 , CGRectGetMaxY(self.frame) - myYOffset );
                [myCircleSprite5 setPosition:CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-30)];
                
                [myCircleSprite5 setName:@"space object"];
                [self addChild:myCircleSprite5];
                [myCircleSprite5 runAction:myCircleSpriteAction];
                break;
            }
                
            case 6:
            {
                SKSpriteNode *myCircleSprite6 = [ SKSpriteNode spriteNodeWithImageNamed:@"9460973502_7e62edc019_o"];
                [myCircleSprite6 setScale: myCircleSpriteScale ];
                [myCircleSprite6 setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:myCircleSpriteSize]];
                [myCircleSprite6.physicsBody setAffectedByGravity:YES];
                [myCircleSprite6.physicsBody setRestitution:myCircleSpriteRestitution];
                //        [myCircleSprite6.physicsBody setContactTestBitMask:0x03];
                [myCircleSprite6.physicsBody setLinearDamping:13.0];
                [myCircleSprite6.physicsBody setMass:myCircleMass];
                //                myCircleSprite6.position = CGPointMake(CGRectGetMidX(self.frame) - 50 , CGRectGetMaxY(self.frame) - myYOffset );
                [myCircleSprite6 setPosition:CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-30)];
                
                [myCircleSprite6 setName:@"space object"];
                [self addChild:myCircleSprite6];
                [myCircleSprite6 runAction:myCircleSpriteAction];
                break;
            }
                
            case 7:
            {
                SKSpriteNode *myCircleSprite7 = [ SKSpriteNode spriteNodeWithImageNamed:@"9464655973_9d00c231a0_o"];
                [myCircleSprite7 setScale: myCircleSpriteScale ];
                [myCircleSprite7 setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:myCircleSpriteSize]];
                [myCircleSprite7.physicsBody setAffectedByGravity:YES];
                [myCircleSprite7.physicsBody setRestitution:myCircleSpriteRestitution];
                //        [myCircleSprite7.physicsBody setContactTestBitMask:0x03];
                [myCircleSprite7.physicsBody setLinearDamping:13.0];
                [myCircleSprite7.physicsBody setMass:myCircleMass];
                [myCircleSprite7 setName:@"space object"];
                //                myCircleSprite7.position = CGPointMake(CGRectGetMidX(self.frame) - 25 , CGRectGetMaxY(self.frame) - myYOffset );
                [myCircleSprite7 setPosition:CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-30)];
                
                [self addChild:myCircleSprite7];
                [myCircleSprite7 runAction:myCircleSpriteAction];
                break;
            }
                
            case 8:
            {
                SKSpriteNode *myCircleSprite8 = [ SKSpriteNode spriteNodeWithImageNamed:@"9464658509_0d53eda5e3_o"];
                [myCircleSprite8 setScale: myCircleSpriteScale ];
                [myCircleSprite8 setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:myCircleSpriteSize]];
                [myCircleSprite8.physicsBody setAffectedByGravity:YES];
                [myCircleSprite8.physicsBody setRestitution:myCircleSpriteRestitution];
                //        [myCircleSprite8.physicsBody setContactTestBitMask:0x03];
                [myCircleSprite8.physicsBody setLinearDamping:13.0];
                [myCircleSprite8.physicsBody setMass:myCircleMass];
                //                myCircleSprite8.position = CGPointMake(CGRectGetMidX(self.frame)  , CGRectGetMaxY(self.frame) - myYOffset );
                [myCircleSprite8 setPosition:CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-30)];
                
                [myCircleSprite8 setName:@"space object"];
                [self addChild:myCircleSprite8];
                [myCircleSprite8 runAction:myCircleSpriteAction];
                break;
            }
                
            case 9:
            {
                SKSpriteNode *myCircleSprite9 = [ SKSpriteNode spriteNodeWithImageNamed:@"9464665031_08eb5304d1_o"];
                [myCircleSprite9 setScale: myCircleSpriteScale ];
                [myCircleSprite9 setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:myCircleSpriteSize]];
                [myCircleSprite9.physicsBody setAffectedByGravity:YES];
                [myCircleSprite9.physicsBody setRestitution:myCircleSpriteRestitution];
                //        [myCircleSprite9.physicsBody setContactTestBitMask:0x03];
                [myCircleSprite9.physicsBody setLinearDamping:13.0];
                [myCircleSprite9.physicsBody setMass:myCircleMass];
                //                myCircleSprite9.position = CGPointMake(CGRectGetMidX(self.frame) + 25 , CGRectGetMaxY(self.frame) - myYOffset );
                [myCircleSprite9 setPosition:CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-30)];
                
                [myCircleSprite9 setName:@"space object"];
                [self addChild:myCircleSprite9];
                [myCircleSprite9 runAction:myCircleSpriteAction];
                break;
            }
                
            case 10:
            {
                SKSpriteNode *myCircleSprite10 = [ SKSpriteNode spriteNodeWithImageNamed:@"9467442336_db3d40cb53_o"];
                [myCircleSprite10 setScale: myCircleSpriteScale ];
                [myCircleSprite10 setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:myCircleSpriteSize]];
                [myCircleSprite10.physicsBody setAffectedByGravity:YES];
                [myCircleSprite10.physicsBody setRestitution:myCircleSpriteRestitution];
                //        [myCircleSprite10.physicsBody setContactTestBitMask:0x03];
                [myCircleSprite10.physicsBody setLinearDamping:13.0];
                [myCircleSprite10.physicsBody setMass:myCircleMass];
                //                myCircleSprite10.position = CGPointMake(CGRectGetMidX(self.frame) + 50 , CGRectGetMaxY(self.frame) - myYOffset );
                [myCircleSprite10 setPosition:CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-30)];
                
                [myCircleSprite10 setName:@"space object"];
                [self addChild:myCircleSprite10];
                [myCircleSprite10 runAction:myCircleSpriteAction];
                break;
            }
                
            case 11:
            {
                SKSpriteNode *myCircleSprite11 = [ SKSpriteNode spriteNodeWithImageNamed:@"9467448026_7d146fb585_o"];
                [myCircleSprite11 setScale: myCircleSpriteScale ];
                [myCircleSprite11 setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:myCircleSpriteSize]];
                [myCircleSprite11.physicsBody setAffectedByGravity:YES];
                [myCircleSprite11.physicsBody setRestitution:myCircleSpriteRestitution];
                //        [myCircleSprite11.physicsBody setContactTestBitMask:0x03];
                [myCircleSprite11.physicsBody setLinearDamping:13.0];
                [myCircleSprite11.physicsBody setMass:myCircleMass];
                //                myCircleSprite11.position = CGPointMake(CGRectGetMidX(self.frame) + 75 , CGRectGetMaxY(self.frame) - myYOffset );
                [myCircleSprite11 setPosition:CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-30)];
                
                [myCircleSprite11 setName:@"space object"];
                [self addChild:myCircleSprite11];
                [myCircleSprite11 runAction:myCircleSpriteAction];
                break;
            }
                
            case 12:
            {
                SKSpriteNode *myCircleSprite12 = [ SKSpriteNode spriteNodeWithImageNamed:@"17125224860_dfdc354bd4_o"];
                [myCircleSprite12 setScale: myCircleSpriteScale ];
                [myCircleSprite12 setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:myCircleSpriteSize]];
                [myCircleSprite12.physicsBody setAffectedByGravity:YES];
                [myCircleSprite12.physicsBody setRestitution:myCircleSpriteRestitution];
                //        [myCircleSprite12.physicsBody setContactTestBitMask:0x03];
                [myCircleSprite12.physicsBody setLinearDamping:13.0];
                [myCircleSprite12.physicsBody setMass:myCircleMass];
                //                myCircleSprite12.position = CGPointMake(CGRectGetMidX(self.frame) + 100 , CGRectGetMaxY(self.frame) - myYOffset );
                [myCircleSprite12 setPosition:CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-30)];
                
                [myCircleSprite12 setName:@"space object"];
                [self addChild:myCircleSprite12];
                [myCircleSprite12 runAction:myCircleSpriteAction];
                break;
            }
                
            case 13:
            {
                SKSpriteNode *myCircleSprite13 = [ SKSpriteNode spriteNodeWithImageNamed:@"etacarinae_hubble_900"];
                [myCircleSprite13 setScale: myCircleSpriteScale ];
                [myCircleSprite13 setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:myCircleSpriteSize]];
                [myCircleSprite13.physicsBody setAffectedByGravity:YES];
                [myCircleSprite13.physicsBody setRestitution:myCircleSpriteRestitution];
                //        [myCircleSprite13.physicsBody setContactTestBitMask:0x03];
                [myCircleSprite13.physicsBody setLinearDamping:13.0];
                [myCircleSprite13.physicsBody setMass:myCircleMass];
                //                myCircleSprite13.position = CGPointMake(CGRectGetMidX(self.frame) + 125 , CGRectGetMaxY(self.frame) - myYOffset );
                [myCircleSprite13 setPosition:CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-30)];
                
                [myCircleSprite13 setName:@"space object"];
                [self addChild:myCircleSprite13];
                [myCircleSprite13 runAction:myCircleSpriteAction];
                
                break;
            }
                
            case 14:
            {
                SKSpriteNode *myCircleSprite14 = [ SKSpriteNode spriteNodeWithImageNamed:@"hubble_friday_08212015"];
                [myCircleSprite14 setScale: myCircleSpriteScale ];
                [myCircleSprite14 setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:myCircleSpriteSize]];
                [myCircleSprite14.physicsBody setAffectedByGravity:YES];
                [myCircleSprite14.physicsBody setRestitution:myCircleSpriteRestitution];
                //        [myCircleSprite14.physicsBody setContactTestBitMask:0x03];
                [myCircleSprite14.physicsBody setLinearDamping:13.0];
                [myCircleSprite14.physicsBody setMass:myCircleMass];
                //                myCircleSprite14.position = CGPointMake(CGRectGetMidX(self.frame) + 150 , CGRectGetMaxY(self.frame) - myYOffset );
                [myCircleSprite14 setPosition:CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-30)];
                
                [myCircleSprite14 setName:@"space object"];
                [self addChild:myCircleSprite14];
                [myCircleSprite14 runAction:myCircleSpriteAction];
                
                break;
            }
                
            case 15:
            {
                SKSpriteNode *myCircleSprite15 = [ SKSpriteNode spriteNodeWithImageNamed:@"flame"];
                [myCircleSprite15 setScale: myCircleSpriteScale ];
                [myCircleSprite15 setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:myCircleSpriteSize]];
                [myCircleSprite15.physicsBody setAffectedByGravity:YES];
                [myCircleSprite15.physicsBody setRestitution:myCircleSpriteRestitution];
                //        [myCircleSprite15.physicsBody setContactTestBitMask:0x03];
                [myCircleSprite15.physicsBody setLinearDamping:13.0];
                [myCircleSprite15.physicsBody setMass:myCircleMass];
                //                myCircleSprite15.position = CGPointMake(CGRectGetMidX(self.frame) + 175 , CGRectGetMaxY(self.frame) - myYOffset );
                [myCircleSprite15 setPosition:CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-30)];
                
                [myCircleSprite15 setName:@"space object"];
                [self addChild:myCircleSprite15];
                [myCircleSprite15 runAction:myCircleSpriteAction];
                
                myCircleSpriteImageNumber = 0;
                
                break;
                
            }
            default:
                break;
        }
        
        
    } // end of loop
    
    
    // rz if there are too many little flying things, remove them
    //
    if ( self.children.count > 1000) {
        
        NSLog(@"Elapsed Time  %f  Is Too Large, REMOVING OBJECTS!!!",myElapsedTime);
        [mySecondaryHelperLabel setHidden:NO];
        [mySecondaryHelperLabel setAlpha:1.0];
        [mySecondaryHelperLabel setText:@"Too Much SPACE JUNK!!! Cleaning Up Your Mess"];
        SKAction *myNodeFade = [SKAction sequence:@[[SKAction fadeOutWithDuration:(NSTimeInterval) 5.00],]];
        [mySecondaryHelperLabel runAction:myNodeFade];
        
        
        [self enumerateChildNodesWithName:@"colorsprite" usingBlock:^(SKNode *node, BOOL *stop) {
            [node removeFromParent];
        }];
        [self enumerateChildNodesWithName:@"texture" usingBlock:^(SKNode *node, BOOL *stop) {
            [node removeFromParent];
        }];
        [self enumerateChildNodesWithName:@"space object" usingBlock:^(SKNode *node, BOOL *stop) {
            [node removeFromParent];
        }];
    }
    
    
    
    
}


- (void)myMakeTextures{
    NSInteger myNumberOfLoops = 1;
    for ( int i = 1 ; i <= myNumberOfLoops ; i++){
        for (int mySpriteCounter = 1; mySpriteCounter <= 13; mySpriteCounter++) {
            //            NSLog(@"*");
            switch (mySpriteCounter) {
                case 1:
                    myColorSprite =  [SKSpriteNode spriteNodeWithImageNamed:@"flame.png"];
                    break;
                case 2:
                    myColorSprite =  [SKSpriteNode spriteNodeWithImageNamed:@"Stars.png"];
                    break;
                case 3:
                    myColorSprite =  [SKSpriteNode spriteNodeWithImageNamed:@"Swirly.png"];
                    break;
                case 4:
                    myColorSprite =  [SKSpriteNode spriteNodeWithImageNamed:@"Wood.png"];
                    break;
                case 5:
                    myColorSprite =  [SKSpriteNode spriteNodeWithImageNamed:@"Yellow.png"];
                    break;
                case 6:
                    myColorSprite =  [SKSpriteNode spriteNodeWithImageNamed:@"Basket.png"];
                    break;
                case 7:
                    myColorSprite =  [SKSpriteNode spriteNodeWithImageNamed:@"Blue.png"];
                    break;
                case 8:
                    myColorSprite =  [SKSpriteNode spriteNodeWithImageNamed:@"Bricks.png"];
                    break;
                case 9:
                    myColorSprite =  [SKSpriteNode spriteNodeWithImageNamed:@"Checker.png"];
                    break;
                case 10:
                    myColorSprite =  [SKSpriteNode spriteNodeWithImageNamed:@"Green.png"];
                    break;
                case 11:
                    myColorSprite =  [SKSpriteNode spriteNodeWithImageNamed:@"Grey.png"];
                    break;
                case 12:
                    myColorSprite =  [SKSpriteNode spriteNodeWithImageNamed:@"Leopard.png"];
                    break;
                case 13:
                    myColorSprite =  [SKSpriteNode spriteNodeWithImageNamed:@"Marble.png"];
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
            
            [myColorSprite setSize:CGSizeMake(20.0, 20.0)];
            
            //            [myColorSprite setPosition:myColorLocation];
            [myColorSprite setPosition:CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-30)];
            
            myColorSprite.physicsBody = [ SKPhysicsBody bodyWithRectangleOfSize:myColorSprite.size];
            myColorSprite.physicsBody.mass = 1;
            myColorSprite.physicsBody.restitution = .9;
            myColorSprite.physicsBody.affectedByGravity = YES;
            myColorSprite.physicsBody.linearDamping = 13.0;
            //            myColorSprite.blendMode = SKBlendModeReplace ;
            //            myColorSprite.physicsBody.contactTestBitMask = 0x03;
            [myColorSprite setName:@"texture"];
            [self addChild:myColorSprite];
            SKAction *mycolorSpriteAction =    [SKAction sequence:@[
                                                                    [SKAction waitForDuration:myColorSpriteDuration withRange:1.5],
                                                                    [SKAction removeFromParent],
                                                                    ]];
            [myColorSprite runAction:mycolorSpriteAction];
        }  // end of mySpriteCounter Loop
    }  // end of myNUmberOfLoops Loop
    // rz if there are too many little flying things, remove them
    //
    if ( self.children.count > 1000) {
        NSLog(@"Elapsed Time  %f  Is Too Large, REMOVING OBJECTS!!!",myElapsedTime);
        [mySecondaryHelperLabel setHidden:NO];
        [mySecondaryHelperLabel setAlpha:1.0];
        [mySecondaryHelperLabel setText:@"Too Much SPACE JUNK!!! Cleaning Up Your Mess"];
        SKAction *myNodeFade = [SKAction sequence:@[[SKAction fadeOutWithDuration:(NSTimeInterval) 5.00],]];
        [mySecondaryHelperLabel runAction:myNodeFade];
        
        [self enumerateChildNodesWithName:@"colorsprite" usingBlock:^(SKNode *node, BOOL *stop) {
            [node removeFromParent];
        }];
        [self enumerateChildNodesWithName:@"texture" usingBlock:^(SKNode *node, BOOL *stop) {
            [node removeFromParent];
        }];
        [self enumerateChildNodesWithName:@"space object" usingBlock:^(SKNode *node, BOOL *stop) {
            [node removeFromParent];
        }];
    }
    
}









-(void)makeMyInstructionLabels{
    
    UIColor *myLabelColor = [UIColor greenColor];
    
    mySecondaryHelperLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    [mySecondaryHelperLabel setText:@"Choose an Item Above and Press Play/Pause to Use"];
    mySecondaryHelperLabel.fontSize = 12;
    mySecondaryHelperLabel.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame) - 150);
    [mySecondaryHelperLabel setHidden:YES];
    [self addChild:mySecondaryHelperLabel];
    
    
    
    SKAction *myLabelAction = [SKAction sequence:@[[SKAction waitForDuration:15.0],
                                                   [SKAction fadeInWithDuration:1.0],
                                                   [SKAction waitForDuration:5.0],
                                                   [SKAction fadeOutWithDuration:1.0],
                                                   [SKAction waitForDuration:60.0],]];
    
    
    
    
    SKLabelNode *myLabel1 = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    [myLabel1 setText:@"Top Buttons Drop"];
    //    , tap with two fingers to create snow, tap with three fingers to create smoke, swipe right to clear the screen!"];
    [myLabel1 setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))];
    [myLabel1 setFontSize:myLabelFontSize];
    [myLabel1 setFontColor:myLabelColor];
    [myLabel1 setAlpha:0.0];
    [self addChild:myLabel1];
    [myLabel1 runAction:[SKAction repeatActionForever:myLabelAction]];
    
    
    SKLabelNode *myLabel2 = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    //    , tap with two fingers to create snow, tap with three fingers to create smoke, swipe right to clear the screen!"];
    [myLabel2 setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-20)];
    [myLabel2 setFontSize:myLabelFontSize];
    [myLabel2 setFontColor:myLabelColor];
    [myLabel2 setText:@"Colors, Textures, Pictures"];
    [myLabel2 setAlpha:0.0];
    [self addChild:myLabel2];
    [myLabel2 runAction:[SKAction repeatActionForever:myLabelAction]];
    
    SKLabelNode *myLabel3 = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    //    , tap with two fingers to create snow, tap with three fingers to create smoke, swipe right to clear the screen!"];
    [myLabel3 setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-40)];
    [myLabel3 setFontSize:myLabelFontSize];
    [myLabel3 setFontColor:myLabelColor];
    [myLabel3 setText:@"Bottom Buttons for "];
    [myLabel3 setAlpha:0.0];
    [self addChild:myLabel3];
    [myLabel3 runAction:[SKAction repeatActionForever:myLabelAction]];
    
    
    SKLabelNode *myLabel4 = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    //    , tap with two fingers to create snow, tap with three fingers to create smoke, swipe right to clear the screen!"];
    [myLabel4 setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-60)];
    [myLabel4 setFontSize:myLabelFontSize];
    [myLabel4 setFontColor:myLabelColor];
    [myLabel4 setText:@"Vortex Gravity Force"];
    [myLabel4 setAlpha:0.0];
    [self addChild:myLabel4];
    [myLabel4 runAction:[SKAction repeatActionForever:myLabelAction]];
    
    
    
    SKLabelNode *myLabel5 = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    //    , tap with two fingers to create snow, tap with three fingers to create smoke, swipe right to clear the screen!"];
    [myLabel5 setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-100)];
    [myLabel5 setFontSize:myLabelFontSize];
    [myLabel5 setFontColor:myLabelColor];
    [myLabel5 setText:@"Swipe Up for Menus"];
    [myLabel5 setAlpha:0.0];
    [self addChild:myLabel5];
    [myLabel5 runAction:[SKAction repeatActionForever:myLabelAction]];
    
    
    SKLabelNode *myLabel6 = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    //    , tap with two fingers to create snow, tap with three fingers to create smoke, swipe right to clear the screen!"];
    [myLabel6 setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-140)];
    [myLabel6 setFontSize:myLabelFontSize];
    [myLabel6 setFontColor:myLabelColor];
    [myLabel6 setText:@"Swipe Down to Exit Menus"];
    [myLabel6 setAlpha:0.0];
    [self addChild:myLabel6];
    [myLabel6 runAction:[SKAction repeatActionForever:myLabelAction]];
    
    
    SKLabelNode *myLabel7 = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    //    , tap with two fingers to create snow, tap with three fingers to create smoke, swipe right to clear the screen!"];
    [myLabel7 setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-160)];
    [myLabel7 setFontSize:myLabelFontSize];
    [myLabel7 setFontColor:myLabelColor];
    [myLabel7 setText:@"Long Press to"];
    [myLabel7 setAlpha:0.0];
    [self addChild:myLabel7];
    [myLabel7 runAction:[SKAction repeatActionForever:myLabelAction]];
    
    SKLabelNode *myLabel8 = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    //    , tap with two fingers to create snow, tap with three fingers to create smoke, swipe right to clear the screen!"];
    [myLabel8 setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-180)];
    [myLabel8 setFontSize:myLabelFontSize];
    [myLabel8 setFontColor:myLabelColor];
    [myLabel8 setText:@"Remove all Objects"];
    [myLabel8 setAlpha:0.0];
    [self addChild:myLabel8];
    [myLabel8 runAction:[SKAction repeatActionForever:myLabelAction]];
    
    
    //@"Swipe Left to Reset Color Mass to Default Values"
    
}


-(void)LSSFmyMakeCircles{
    myCircleSpriteImageNumber ++;
    SKAction *myCircleSpriteAction =    [SKAction sequence:@[
                                                             [SKAction waitForDuration:120.0 withRange:1.5],
                                                             [SKAction removeFromParent],
                                                             ]];
    
    for ( int i = 1 ; i <= myCircleSpriteLoops ; i++){
        switch (myCircleSpriteImageNumber) {
            case 1:
            {
                SKSpriteNode *myCircleSprite1 = [ SKSpriteNode spriteNodeWithImageNamed:@"alpha-5052129615_e3ea876e19_o"];
                [myCircleSprite1 setScale: (myCircleSpriteScale * 2) ];
                [myCircleSprite1 setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:(myCircleSpriteScale * 4) ]];
                [myCircleSprite1.physicsBody setAffectedByGravity:YES];
                [myCircleSprite1.physicsBody setAllowsRotation:NO];
                [myCircleSprite1.physicsBody setRestitution:myCircleSpriteRestitution];
                //        [myCircleSprite1.physicsBody setContactTestBitMask:0x03];
                [myCircleSprite1.physicsBody setLinearDamping:13.0];
                [myCircleSprite1.physicsBody setMass:myCircleMass];
                //                myCircleSprite1.position = CGPointMake(CGRectGetMidX(self.frame) - 175 , CGRectGetMaxY(self.frame) - myYOffset );
                [myCircleSprite1 setPosition:myCursorSprite.position];
                [myCircleSprite1 setName:@"space object"];
                [self addChild:myCircleSprite1];
                [myCircleSprite1 runAction:myCircleSpriteAction];
                break;
            }
                
            case 2:
            {
                SKSpriteNode *myCircleSprite2 = [ SKSpriteNode spriteNodeWithImageNamed:@"5052743686_77244d3b97_o"];
                [myCircleSprite2 setScale: myCircleSpriteScale ];
                [myCircleSprite2 setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:myCircleSpriteSize]];
                [myCircleSprite2.physicsBody setAffectedByGravity:YES];
                [myCircleSprite2.physicsBody setRestitution:myCircleSpriteRestitution];
                //        [myCircleSprite2.physicsBody setContactTestBitMask:0x03];
                [myCircleSprite2.physicsBody setLinearDamping:13.0];
                [myCircleSprite2.physicsBody setMass:myCircleMass];
                //                myCircleSprite2.position = CGPointMake(CGRectGetMidX(self.frame) - 150 , CGRectGetMaxY(self.frame) - myYOffset );
                [myCircleSprite2 setPosition:myCursorSprite.position];
                
                [myCircleSprite2 setName:@"space object"];
                [self addChild:myCircleSprite2];
                [myCircleSprite2 runAction:myCircleSpriteAction];
                
                break;
            }
                
            case 3:
            {
                SKSpriteNode *myCircleSprite3 = [ SKSpriteNode spriteNodeWithImageNamed:@"5052744574_cc6c7338be_o"];
                [myCircleSprite3 setScale: myCircleSpriteScale ];
                [myCircleSprite3 setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:myCircleSpriteSize]];
                [myCircleSprite3.physicsBody setAffectedByGravity:YES];
                [myCircleSprite3.physicsBody setRestitution:myCircleSpriteRestitution];
                //        [myCircleSprite3.physicsBody setContactTestBitMask:0x03];
                [myCircleSprite3.physicsBody setLinearDamping:13.0];
                [myCircleSprite3.physicsBody setMass:myCircleMass];
                //                myCircleSprite3.position = CGPointMake(CGRectGetMidX(self.frame) - 125 , CGRectGetMaxY(self.frame) - myYOffset );
                [myCircleSprite3 setPosition:myCursorSprite.position];
                
                [myCircleSprite3 setName:@"space object"];
                [self addChild:myCircleSprite3];
                [myCircleSprite3 runAction:myCircleSpriteAction];
                break;
            }
                
            case 4:
            {
                SKSpriteNode *myCircleSprite4 = [ SKSpriteNode spriteNodeWithImageNamed:@"alpha-5277460575_a1b324700d_o"];
                [myCircleSprite4 setScale: (myCircleSpriteScale * 2) ];
                [myCircleSprite4 setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:(myCircleSpriteScale * 4)]];
                [myCircleSprite4.physicsBody setAffectedByGravity:YES];
                [myCircleSprite4.physicsBody setAllowsRotation:NO];
                
                [myCircleSprite4.physicsBody setRestitution:myCircleSpriteRestitution];
                //        [myCircleSprite4.physicsBody setContactTestBitMask:0x03];
                [myCircleSprite4.physicsBody setLinearDamping:13.0];
                [myCircleSprite4.physicsBody setMass:myCircleMass];
                //                myCircleSprite4.position = CGPointMake(CGRectGetMidX(self.frame) - 100 , CGRectGetMaxY(self.frame) - myYOffset );
                [myCircleSprite4 setPosition:myCursorSprite.position];
                
                [myCircleSprite4 setName:@"space object"];
                [self addChild:myCircleSprite4];
                [myCircleSprite4 runAction:myCircleSpriteAction];
                break;
            }
                
            case 5:
            {
                SKSpriteNode *myCircleSprite5 = [ SKSpriteNode spriteNodeWithImageNamed:@"5278071900_c040282c2d_o"];
                [myCircleSprite5 setScale: myCircleSpriteScale ];
                [myCircleSprite5 setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:myCircleSpriteSize]];
                [myCircleSprite5.physicsBody setAffectedByGravity:YES];
                [myCircleSprite5.physicsBody setRestitution:myCircleSpriteRestitution];
                //        [myCircleSprite5.physicsBody setContactTestBitMask:0x03];
                [myCircleSprite5.physicsBody setLinearDamping:13.0];
                [myCircleSprite5.physicsBody setMass:myCircleMass];
                //                myCircleSprite5.position = CGPointMake(CGRectGetMidX(self.frame) - 75 , CGRectGetMaxY(self.frame) - myYOffset );
                [myCircleSprite5 setPosition:myCursorSprite.position];
                
                [myCircleSprite5 setName:@"space object"];
                [self addChild:myCircleSprite5];
                [myCircleSprite5 runAction:myCircleSpriteAction];
                break;
            }
                
            case 6:
            {
                SKSpriteNode *myCircleSprite6 = [ SKSpriteNode spriteNodeWithImageNamed:@"9460973502_7e62edc019_o"];
                [myCircleSprite6 setScale: myCircleSpriteScale ];
                [myCircleSprite6 setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:myCircleSpriteSize]];
                [myCircleSprite6.physicsBody setAffectedByGravity:YES];
                [myCircleSprite6.physicsBody setRestitution:myCircleSpriteRestitution];
                //        [myCircleSprite6.physicsBody setContactTestBitMask:0x03];
                [myCircleSprite6.physicsBody setLinearDamping:13.0];
                [myCircleSprite6.physicsBody setMass:myCircleMass];
                //                myCircleSprite6.position = CGPointMake(CGRectGetMidX(self.frame) - 50 , CGRectGetMaxY(self.frame) - myYOffset );
                [myCircleSprite6 setPosition:myCursorSprite.position];
                
                [myCircleSprite6 setName:@"space object"];
                [self addChild:myCircleSprite6];
                [myCircleSprite6 runAction:myCircleSpriteAction];
                break;
            }
                
            case 7:
            {
                SKSpriteNode *myCircleSprite7 = [ SKSpriteNode spriteNodeWithImageNamed:@"9464655973_9d00c231a0_o"];
                [myCircleSprite7 setScale: myCircleSpriteScale ];
                [myCircleSprite7 setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:myCircleSpriteSize]];
                [myCircleSprite7.physicsBody setAffectedByGravity:YES];
                [myCircleSprite7.physicsBody setRestitution:myCircleSpriteRestitution];
                //        [myCircleSprite7.physicsBody setContactTestBitMask:0x03];
                [myCircleSprite7.physicsBody setLinearDamping:13.0];
                [myCircleSprite7.physicsBody setMass:myCircleMass];
                [myCircleSprite7 setName:@"space object"];
                //                myCircleSprite7.position = CGPointMake(CGRectGetMidX(self.frame) - 25 , CGRectGetMaxY(self.frame) - myYOffset );
                [myCircleSprite7 setPosition:myCursorSprite.position];
                
                [self addChild:myCircleSprite7];
                [myCircleSprite7 runAction:myCircleSpriteAction];
                break;
            }
                
            case 8:
            {
                SKSpriteNode *myCircleSprite8 = [ SKSpriteNode spriteNodeWithImageNamed:@"9464658509_0d53eda5e3_o"];
                [myCircleSprite8 setScale: myCircleSpriteScale ];
                [myCircleSprite8 setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:myCircleSpriteSize]];
                [myCircleSprite8.physicsBody setAffectedByGravity:YES];
                [myCircleSprite8.physicsBody setRestitution:myCircleSpriteRestitution];
                //        [myCircleSprite8.physicsBody setContactTestBitMask:0x03];
                [myCircleSprite8.physicsBody setLinearDamping:13.0];
                [myCircleSprite8.physicsBody setMass:myCircleMass];
                //                myCircleSprite8.position = CGPointMake(CGRectGetMidX(self.frame)  , CGRectGetMaxY(self.frame) - myYOffset );
                [myCircleSprite8 setPosition:myCursorSprite.position];
                
                [myCircleSprite8 setName:@"space object"];
                [self addChild:myCircleSprite8];
                [myCircleSprite8 runAction:myCircleSpriteAction];
                break;
            }
                
            case 9:
            {
                SKSpriteNode *myCircleSprite9 = [ SKSpriteNode spriteNodeWithImageNamed:@"9464665031_08eb5304d1_o"];
                [myCircleSprite9 setScale: myCircleSpriteScale ];
                [myCircleSprite9 setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:myCircleSpriteSize]];
                [myCircleSprite9.physicsBody setAffectedByGravity:YES];
                [myCircleSprite9.physicsBody setRestitution:myCircleSpriteRestitution];
                //        [myCircleSprite9.physicsBody setContactTestBitMask:0x03];
                [myCircleSprite9.physicsBody setLinearDamping:13.0];
                [myCircleSprite9.physicsBody setMass:myCircleMass];
                //                myCircleSprite9.position = CGPointMake(CGRectGetMidX(self.frame) + 25 , CGRectGetMaxY(self.frame) - myYOffset );
                [myCircleSprite9 setPosition:myCursorSprite.position];
                
                [myCircleSprite9 setName:@"space object"];
                [self addChild:myCircleSprite9];
                [myCircleSprite9 runAction:myCircleSpriteAction];
                break;
            }
                
            case 10:
            {
                SKSpriteNode *myCircleSprite10 = [ SKSpriteNode spriteNodeWithImageNamed:@"9467442336_db3d40cb53_o"];
                [myCircleSprite10 setScale: myCircleSpriteScale ];
                [myCircleSprite10 setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:myCircleSpriteSize]];
                [myCircleSprite10.physicsBody setAffectedByGravity:YES];
                [myCircleSprite10.physicsBody setRestitution:myCircleSpriteRestitution];
                //        [myCircleSprite10.physicsBody setContactTestBitMask:0x03];
                [myCircleSprite10.physicsBody setLinearDamping:13.0];
                [myCircleSprite10.physicsBody setMass:myCircleMass];
                //                myCircleSprite10.position = CGPointMake(CGRectGetMidX(self.frame) + 50 , CGRectGetMaxY(self.frame) - myYOffset );
                [myCircleSprite10 setPosition:myCursorSprite.position];
                
                [myCircleSprite10 setName:@"space object"];
                [self addChild:myCircleSprite10];
                [myCircleSprite10 runAction:myCircleSpriteAction];
                break;
            }
                
            case 11:
            {
                SKSpriteNode *myCircleSprite11 = [ SKSpriteNode spriteNodeWithImageNamed:@"9467448026_7d146fb585_o"];
                [myCircleSprite11 setScale: myCircleSpriteScale ];
                [myCircleSprite11 setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:myCircleSpriteSize]];
                [myCircleSprite11.physicsBody setAffectedByGravity:YES];
                [myCircleSprite11.physicsBody setRestitution:myCircleSpriteRestitution];
                //        [myCircleSprite11.physicsBody setContactTestBitMask:0x03];
                [myCircleSprite11.physicsBody setLinearDamping:13.0];
                [myCircleSprite11.physicsBody setMass:myCircleMass];
                //                myCircleSprite11.position = CGPointMake(CGRectGetMidX(self.frame) + 75 , CGRectGetMaxY(self.frame) - myYOffset );
                [myCircleSprite11 setPosition:myCursorSprite.position];
                
                [myCircleSprite11 setName:@"space object"];
                [self addChild:myCircleSprite11];
                [myCircleSprite11 runAction:myCircleSpriteAction];
                break;
            }
                
            case 12:
            {
                SKSpriteNode *myCircleSprite12 = [ SKSpriteNode spriteNodeWithImageNamed:@"17125224860_dfdc354bd4_o"];
                [myCircleSprite12 setScale: myCircleSpriteScale ];
                [myCircleSprite12 setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:myCircleSpriteSize]];
                [myCircleSprite12.physicsBody setAffectedByGravity:YES];
                [myCircleSprite12.physicsBody setRestitution:myCircleSpriteRestitution];
                //        [myCircleSprite12.physicsBody setContactTestBitMask:0x03];
                [myCircleSprite12.physicsBody setLinearDamping:13.0];
                [myCircleSprite12.physicsBody setMass:myCircleMass];
                //                myCircleSprite12.position = CGPointMake(CGRectGetMidX(self.frame) + 100 , CGRectGetMaxY(self.frame) - myYOffset );
                [myCircleSprite12 setPosition:myCursorSprite.position];
                
                [myCircleSprite12 setName:@"space object"];
                [self addChild:myCircleSprite12];
                [myCircleSprite12 runAction:myCircleSpriteAction];
                break;
            }
                
            case 13:
            {
                SKSpriteNode *myCircleSprite13 = [ SKSpriteNode spriteNodeWithImageNamed:@"etacarinae_hubble_900"];
                [myCircleSprite13 setScale: myCircleSpriteScale ];
                [myCircleSprite13 setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:myCircleSpriteSize]];
                [myCircleSprite13.physicsBody setAffectedByGravity:YES];
                [myCircleSprite13.physicsBody setRestitution:myCircleSpriteRestitution];
                //        [myCircleSprite13.physicsBody setContactTestBitMask:0x03];
                [myCircleSprite13.physicsBody setLinearDamping:13.0];
                [myCircleSprite13.physicsBody setMass:myCircleMass];
                //                myCircleSprite13.position = CGPointMake(CGRectGetMidX(self.frame) + 125 , CGRectGetMaxY(self.frame) - myYOffset );
                [myCircleSprite13 setPosition:myCursorSprite.position];
                
                [myCircleSprite13 setName:@"space object"];
                [self addChild:myCircleSprite13];
                [myCircleSprite13 runAction:myCircleSpriteAction];
                
                break;
            }
                
            case 14:
            {
                SKSpriteNode *myCircleSprite14 = [ SKSpriteNode spriteNodeWithImageNamed:@"hubble_friday_08212015"];
                [myCircleSprite14 setScale: myCircleSpriteScale ];
                [myCircleSprite14 setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:myCircleSpriteSize]];
                [myCircleSprite14.physicsBody setAffectedByGravity:YES];
                [myCircleSprite14.physicsBody setRestitution:myCircleSpriteRestitution];
                //        [myCircleSprite14.physicsBody setContactTestBitMask:0x03];
                [myCircleSprite14.physicsBody setLinearDamping:13.0];
                [myCircleSprite14.physicsBody setMass:myCircleMass];
                //                myCircleSprite14.position = CGPointMake(CGRectGetMidX(self.frame) + 150 , CGRectGetMaxY(self.frame) - myYOffset );
                [myCircleSprite14 setPosition:myCursorSprite.position];
                
                [myCircleSprite14 setName:@"space object"];
                [self addChild:myCircleSprite14];
                [myCircleSprite14 runAction:myCircleSpriteAction];
                
                break;
            }
                
            case 15:
            {
                SKSpriteNode *myCircleSprite15 = [ SKSpriteNode spriteNodeWithImageNamed:@"flame"];
                [myCircleSprite15 setScale: myCircleSpriteScale ];
                [myCircleSprite15 setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:myCircleSpriteSize]];
                [myCircleSprite15.physicsBody setAffectedByGravity:YES];
                [myCircleSprite15.physicsBody setRestitution:myCircleSpriteRestitution];
                //        [myCircleSprite15.physicsBody setContactTestBitMask:0x03];
                [myCircleSprite15.physicsBody setLinearDamping:13.0];
                [myCircleSprite15.physicsBody setMass:myCircleMass];
                //                myCircleSprite15.position = CGPointMake(CGRectGetMidX(self.frame) + 175 , CGRectGetMaxY(self.frame) - myYOffset );
                [myCircleSprite15 setPosition:myCursorSprite.position];
                
                [myCircleSprite15 setName:@"space object"];
                [self addChild:myCircleSprite15];
                [myCircleSprite15 runAction:myCircleSpriteAction];
                
                myCircleSpriteImageNumber = 0;
                
                break;
                
            }
            default:
                break;
        }
        
        
    } // end of loop
    
    
}

-(CGPoint)myGetSpritePosition: (SKSpriteNode *) theSprite {
    return(theSprite.position);
}


- (void)myMakeColorsWithTrails:  (BOOL) theTrailsIndicator {
    //    SKAction *myWaitBetweekTrailBlocks = [SKAction waitForDuration:0.5];
    
    
    SKAction *mySpriteScaleUpDownAction = [SKAction sequence:
                                           @[[SKAction scaleBy: 2.0 duration:0.05],
                                             [SKAction scaleBy: 0.5 duration:0.1]]];
    
    // rz only scale up and down if we're not making trails
    SKAction *myColorSpriteChangeColor = [SKAction sequence: @[[SKAction colorizeWithColor:[UIColor whiteColor] colorBlendFactor:1.0 duration:0.5],                                                                     [SKAction colorizeWithColor:[UIColor colorWithRed:[self myRandom] green:[self myRandom] blue:[self myRandom] alpha:1.0] colorBlendFactor:1.0 duration:0.2],]];
    
    
    
    SKAction *mycolorSpriteAction =    [SKAction repeatActionForever:               [SKAction group:@[mySpriteScaleUpDownAction,myColorSpriteChangeColor]]];
    
    //    SKAction *myTrailSpriteAction = [SKAction sequence:@[ [SKAction waitForDuration:3.0], [SKAction removeFromParent],      ]];
    
    
    
    
    
    NSInteger myNumberOfLoops = 1;
    SKSpriteNode *myColorSprite =  [SKSpriteNode spriteNodeWithColor:[UIColor clearColor]  size:CGSizeMake (myColorSpriteSize, myColorSpriteSize)];
    
    
    
    for ( int i = 1 ; i <= myNumberOfLoops ; i++){
        for (int mySpriteCounter = 1; mySpriteCounter <= myColorSpriteCount; mySpriteCounter++) {
            //            NSLog(@"*");
            switch (mySpriteCounter) {
                case 1:
                {
                    myColorSprite =  [SKSpriteNode spriteNodeWithColor:[UIColor blackColor]  size:CGSizeMake (myColorSpriteSize, myColorSpriteSize)];
                }
                    
                    break;
                case 2:{
                    myColorSprite = [ SKSpriteNode spriteNodeWithColor:[UIColor darkGrayColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
                }
                    break;
                case 3:{
                    myColorSprite = [ SKSpriteNode spriteNodeWithColor:[UIColor lightGrayColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
                }
                    break;
                case 4:{
                    myColorSprite = [ SKSpriteNode spriteNodeWithColor:[UIColor whiteColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
                }
                    break;
                case 5:{
                    myColorSprite = [ SKSpriteNode spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
                }
                    break;
                case 6:{
                    myColorSprite = [ SKSpriteNode spriteNodeWithColor:[UIColor greenColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
                }
                    break;
                case 7:{
                    myColorSprite = [ SKSpriteNode spriteNodeWithColor:[UIColor blueColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
                }
                    break;
                case 8:{
                    myColorSprite = [ SKSpriteNode spriteNodeWithColor:[UIColor cyanColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
                }
                    break;
                case 9:{
                    myColorSprite = [ SKSpriteNode spriteNodeWithColor:[UIColor yellowColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
                }
                    break;
                case 10:{
                    myColorSprite = [ SKSpriteNode spriteNodeWithColor:[UIColor magentaColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
                }
                    break;
                case 11:{
                    myColorSprite = [ SKSpriteNode spriteNodeWithColor:[UIColor orangeColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
                }
                    break;
                case 12:{
                    myColorSprite = [ SKSpriteNode spriteNodeWithColor:[UIColor purpleColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
                }
                    break;
                case 13:{
                    myColorSprite = [ SKSpriteNode spriteNodeWithColor:[UIColor brownColor] size:CGSizeMake(myColorSpriteSize, myColorSpriteSize)];
                }
                    break;
                default:
                    break;
            }  // end of switch
            //
            // rz spread the color sprites around just a little bit
            [myColorSprite setPosition:CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-30)];
            
            myColorSprite.physicsBody = [ SKPhysicsBody bodyWithRectangleOfSize:myColorSprite.size];
            myColorSprite.physicsBody.mass = 1;
            myColorSprite.physicsBody.restitution = .9;
            myColorSprite.physicsBody.affectedByGravity = YES;
            myColorSprite.physicsBody.linearDamping = 30.0;
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
                                                                    SKSpriteNode *myTrailSprite = [SKSpriteNode spriteNodeWithColor:myColorSprite.color size:CGSizeMake(6.0, 6.0)];
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
    
}




@end


