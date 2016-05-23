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


long myGravityStrength = 1.1;
long myGravityFalloff = 2.0 ;

long myVortexStrength = 10.0;
long myVortexStartStrength = 10.0 ;

long myRadialGravityStrength = 10.0;


long myRadialGravityFalloff = 0.5;
long mySpringFieldFalloff = 2.0;




long myVortexFalloff = 2.0;






int myForceVisibilityIndex = 4;
int myControlHeight = 40;
int myColorSpriteDuration = 120;
float myColorSpriteSize = 8.0;

float myElapsedTime = 0;




//long myVortexSpringStrength = 1;
float myTempMass = 0.0;
float myMassIncrement = 10.0;
//id myTopControl;
//id myBottomControl;


SKSpriteNode *myColorSprite;
@implementation GameScene
@synthesize myQueue;
@synthesize myBG;
@synthesize myPositionSprite;
@synthesize myCursorSprite;
@synthesize mySecondaryHelperLabel;
@synthesize myTopControl;
@synthesize myTopControlValues;



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
            [self enumerateChildNodesWithName:@"color" usingBlock:^(SKNode *node, BOOL *stop) {
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


-(void)didMoveToView:(SKView *)view {
    
    
    
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

    
    
    
    myBG = [SKSpriteNode spriteNodeWithImageNamed:@"myBlackBG"];
    [myBG setZPosition:-10.0];
    [self addChild:myBG];
    
    [self.physicsWorld setGravity:CGVectorMake(0.0, -0.4)];
    [self setPhysicsBody:[SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame] ];

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
    
    
    NSArray *myBottomControlValues  = @[@"V-",@"V+",@"Vortex",@"Anti-Gravity",@"Gravity",@"S+",@"S-"] ;
    UISegmentedControl *myBottomControl = [[ UISegmentedControl alloc] initWithItems:myBottomControlValues ];
    
    
    [myBottomControl setFrame:CGRectMake(0, self.view.bounds.size.height - myControlHeight , self.view.bounds.size.width  , myControlHeight  )];
    [myBottomControl setApportionsSegmentWidthsByContent:YES];
    [myBottomControl addTarget:self action:@selector(myBottomSwitchChanged:) forControlEvents:UIControlEventValueChanged ];
    myForceIndex = 4;
    [myBottomControl setSelectedSegmentIndex:myForceIndex];
    [self.view addSubview:myBottomControl];
    
//    NSAttributedString *myLabel1 = [NSAttributedString alloc] initWithString:@"Textures" attributes:<#(nullable NSDictionary<NSString *,id> *)#>
    
    
    
    myTopControlValues  = @[@"Textures",@"Colors",@"Space", @"Forces" , @"No Forcess", @"Quit"] ;
    myTopControl = [[ UISegmentedControl alloc] initWithItems:myTopControlValues ];
    [myTopControl addTarget:self action:@selector(myTopSwitchChanged:) forControlEvents:UIControlEventValueChanged ];
    //[myTopControl setWidth:myTopControlSeqmentWidth forSegmentAtIndex:4];
    [myTopControl setSelectedSegmentIndex:myForceVisibilityIndex];
    //    [myTopControl setFrame:CGRectMake(0, 0, self.view.bounds.size.width, myControlHeight)];
    [myTopControl setFrame:CGRectMake(0, 0, self.view.bounds.size.width, myControlHeight)];
    [myTopControl setApportionsSegmentWidthsByContent:YES];
    [self.view addSubview:myTopControl];
    /* Setup your scene here */
    
    
    [self makeMyInstructionLabels];
    [myTopControl setSelectedSegmentIndex:4];
    
    
    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    myLabel.text = @"Sprites and Forces!  Tap Screen to Place Force Fields";
    myLabel.fontSize = 18;
    myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                   CGRectGetMidY(self.frame)+200);
    [self addChild:myLabel];
    [myLabel runAction:[SKAction sequence:@[ [SKAction waitForDuration:10.0],
                                             [SKAction removeFromParent],
                                             ]]];
    
    
    
    
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
    long myValue = sender.selectedSegmentIndex;
    if (myValue == 0) {
        [self myMakeTextures];
        [sender setSelectedSegmentIndex:myForceVisibilityIndex];
        
    } // end of if myValue == 0
    
    else if (myValue == 1) {
        [self myMakeColors];
        [sender setSelectedSegmentIndex:myForceVisibilityIndex];
    }
    
    
    else if (myValue == 2) {
        
        [self myMakeCircles];
        
        [sender setSelectedSegmentIndex:myForceVisibilityIndex];
    }
    else if (myValue == 3) {
        //
        // show forces
        myForceVisibilityIndex = 3;
        [self.view setShowsFields:YES];
        [sender setSelectedSegmentIndex:myForceVisibilityIndex];
    }
    
    else if (myValue == 4) {
        myForceVisibilityIndex = 4;
        [self.view setShowsFields:NO];
        [sender setSelectedSegmentIndex:myForceVisibilityIndex];
    }
    else if (myValue == 5){
        exit(0);
    }
    
}



-(void)myMakeVortex{
    // rz vortex
    //
    //
//    NSString *mySpringEmitterNodePath = [[NSBundle mainBundle] pathForResource:@"MyParticle" ofType:@"sks"];
//    SKEmitterNode *myEmitterNode =  [NSKeyedUnarchiver unarchiveObjectWithFile:mySpringEmitterNodePath];
    NSString *myVortexEmitterPath = [[NSBundle mainBundle] pathForResource:@"VortexParticle" ofType:@"sks"] ;
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
        SKSpriteNode *myForceImage = [SKSpriteNode spriteNodeWithImageNamed:@"rzForces Image.png"];
        //        NSLog(@"NOW myforce = %ld",myForce);
        
        switch (myForceIndex) {
            case 2:
            {
                //
                //
                //
                //
                [self myMakeVortex];
                break;
            }
            case 3:
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
            case 4:
            {
                //
                //
                //
                // rz gravity
                //
                //                [self myMakeGravity];
                //
                
                
                
                //                NSString *mySpringEmitterNodePath = [[NSBundle mainBundle] pathForResource:@"myGravityParticle" ofType:@"sks"];
                //                SKEmitterNode *mySpringNodeEmitter =  [NSKeyedUnarchiver unarchiveObjectWithFile:mySpringEmitterNodePath];
                //
                //                SKFieldNode *myRadialGravityNode = [SKFieldNode radialGravityField ];
                //                [myRadialGravityNode setStrength:myRadialGravityStrength];
                //                [myRadialGravityNode setName:@"gravity"];
                //                [myPositionSprite setName:@"gravityposition"];
                //                [myRadialGravityNode setFalloff:myRadialGravityFalloff];
                //                [myPositionSprite addChild:mySpringNodeEmitter];
                //                [myPositionSprite addChild:myRadialGravityNode];
                //                [myPositionSprite setZPosition:10.0];
                
                [ myForceImage setAlpha:0.0];
                
                //
                //                SKAction myNewGravityAction = [SKAction runAction: onChildWithName:<#(NSString *)#>]
                
                SKAction *myG = [SKAction group:@[
                                                  [SKAction fadeAlphaTo:0.00 duration:0.0],
                                                  [SKAction scaleTo: 0.5 duration:0.0],
                                                  ]];
                
                SKAction *myG2 = [SKAction group:@[
                                                   [SKAction scaleTo:0.01 duration:2.00],
                                                   [SKAction fadeAlphaTo:0.8 duration:0.75],
                                                   ]];
                
                
                SKFieldNode *myRadialGravityNode = [SKFieldNode radialGravityField ];
                [myRadialGravityNode setStrength:myRadialGravityStrength];
                [myPositionSprite setName:@"gravityposition"];
                [myRadialGravityNode setName:@"gravity"];
                [myRadialGravityNode setFalloff:myRadialGravityFalloff];
                [myPositionSprite addChild:myForceImage];
                [myPositionSprite addChild:myRadialGravityNode];
                [self addChild:myPositionSprite];
                [myForceImage runAction:[SKAction repeatActionForever: [ SKAction sequence:@[
                                                                                             myG,myG2,
                                                                                             ]]]];
                
                break;
            }
                
            default:
                break;
        }
        
    }
}

- (IBAction)myBottomSwitchChanged:(UISegmentedControl *)sender{
    long myValue = sender.selectedSegmentIndex;
    //NSlog(@"Value = %ld",myValue);
    switch (myValue) {
        case 0:
            myVortexStrength-= 10;
            [self enumerateChildNodesWithName:@"vortexposition" usingBlock:^(SKNode *node, BOOL *stop) {
                //NSlog(@"Found Vortex Position");
                [node enumerateChildNodesWithName:@"vortex" usingBlock:^(SKNode *node, BOOL *stop) {
                    //NSlog(@"Found Vortex");
                    //NSlog(@"Node Vortex Strength= %ld", myVortexStrength);
                    [  (SKFieldNode *) node  setStrength:myVortexStrength ];
                }];
            }];
            [sender setSelectedSegmentIndex:myForceIndex];
            break;
        case 1:
            myVortexStrength+= 10;
            [self enumerateChildNodesWithName:@"vortexposition" usingBlock:^(SKNode *node, BOOL *stop) {
                //NSlog(@"Found Vortex Position");
                [node enumerateChildNodesWithName:@"vortex" usingBlock:^(SKNode *node, BOOL *stop) {
                    //NSlog(@"Found Vortex");
                    //NSlog(@"Node Vortex Strength= %ld", myVortexStrength);
                    [  (SKFieldNode *) node  setStrength:myVortexStrength ];
                }];
            }];
            [sender setSelectedSegmentIndex:myForceIndex];
            break;
        case 2:
            myForceIndex = myValue;
            [sender setSelectedSegmentIndex:myForceIndex];
            break;
        case 3:
            myForceIndex = myValue;
            [sender setSelectedSegmentIndex:myForceIndex];
            break;
        case 4:
            myForceIndex = myValue;
            [sender setSelectedSegmentIndex:myForceIndex];
            break;
        case 5:
            mySpringStrength+=20;
            [self enumerateChildNodesWithName:@"springposition" usingBlock:^(SKNode *node, BOOL *stop) {
                //NSlog(@"Found Spring Position");
                [node enumerateChildNodesWithName:@"spring" usingBlock:^(SKNode *node, BOOL *stop) {
                    //NSlog(@"Found Spring");
                    //NSlog(@"Node Spring Strength= %ld", mySpringStrength);
                    [  (SKFieldNode *) node  setStrength:mySpringStrength ];
                }];
            }];
            [sender setSelectedSegmentIndex:myForceIndex];
            break;
            break;
        case 6:
            mySpringStrength-=20;
            [self enumerateChildNodesWithName:@"springposition" usingBlock:^(SKNode *node, BOOL *stop) {
                //NSlog(@"Found Spring Position");
                [node enumerateChildNodesWithName:@"spring" usingBlock:^(SKNode *node, BOOL *stop) {
                    //NSlog(@"Found Spring");
                    //NSlog(@"Node Spring Strength= %ld", mySpringStrength);
                    [  (SKFieldNode *) node  setStrength:mySpringStrength ];
                }];
            }];
            [sender setSelectedSegmentIndex:myForceIndex];
            break;
        default:
            break;
            
    }
    //NSLog(@"Spring = %ld / Vortex = %ld",mySpringStrength,myVortexStrength);
}


-(void)myUpSwipeAction{
    
    NSLog(@"Hide");
    
    [self enumerateChildNodesWithName:@"colorsprite" usingBlock:^(SKNode *node, BOOL *stop) {
        myTempMass = node.physicsBody.mass + myMassIncrement;
        //        NSLog(@"Mass=%f",myTempMass);
        [node.physicsBody setMass:myTempMass];
    }];
    //    [myTopControl setAlpha:1];
    //    [myBottomControl setAlpha:1];
}

-(void)myDownSwipeAction{
    [self enumerateChildNodesWithName:@"colorsprite" usingBlock:^(SKNode *node, BOOL *stop) {
        myTempMass = node.physicsBody.mass - myMassIncrement;
        //        NSLog(@"Mass=%f",myTempMass);
        [node.physicsBody setMass:myTempMass];
    }];
    //    [myTopControl setAlpha:0];
    //    [myBottomControl setAlpha:0];
}


-(void)myRightSwipeAction{
    [self removeAllChildren];
    [self makeMyInstructionLabels];
}


-(void)myLeftSwipeAction{
    [self enumerateChildNodesWithName:@"vortexposition" usingBlock:^(SKNode *node, BOOL *stop) {
        //NSlog(@"Found Vortex Position");
        [node enumerateChildNodesWithName:@"vortex" usingBlock:^(SKNode *node, BOOL *stop) {
            //NSlog(@"Found Vortex");
            //NSlog(@"Node Vortex Start Strength= %ld", myVortexStartStrength);
            [  (SKFieldNode *) node  setStrength:myVortexStartStrength ];
        }];
    }];
    
    [self enumerateChildNodesWithName:@"springposition" usingBlock:^(SKNode *node, BOOL *stop) {
        //NSlog(@"Found Spring Position");
        [node enumerateChildNodesWithName:@"spring" usingBlock:^(SKNode *node, BOOL *stop) {
            //NSlog(@"Found Spring");
            //NSlog(@"Node Spring Start Strength= %ld", mySpringStartStrength);
            [  (SKFieldNode *) node  setStrength:mySpringStartStrength ];
        }];
    }];
    myVortexStrength = myVortexStartStrength;
    mySpringStrength = mySpringStartStrength;
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
                //                myCircleSprite1.position = CGPointMake(CGRectGetMidX(self.frame) - 175 , CGRectGetMaxY(self.frame) - myYOffset );
                [myCircleSprite1 setPosition:CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-30)];
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




- (void)myMakeColors{
    NSInteger myNumberOfLoops = 1;
    for ( int i = 1 ; i <= myNumberOfLoops ; i++){
        for (int mySpriteCounter = 1; mySpriteCounter <= 13; mySpriteCounter++) {
            //            NSLog(@"*");
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
            //
            // rz spread the color sprites around just a little bit
            // randomly
            //
            //            int myXOffset = arc4random()%20;
            //
            //             rz make sure that the color sprites don't end up above the top of the screen and get stuck there
            //            int myYOffset = (arc4random()%20+50);
            //            CGPoint myColorLocation = CGPointMake(myStaticLocation.x - myXOffset, myStaticLocation.y - myYOffset);
            //            [myColorSprite setPosition:myColorLocation];
            [myColorSprite setPosition:CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-30)];
            
            myColorSprite.physicsBody = [ SKPhysicsBody bodyWithRectangleOfSize:myColorSprite.size];
            myColorSprite.physicsBody.mass = 1;
            myColorSprite.physicsBody.restitution = .9;
            myColorSprite.physicsBody.affectedByGravity = YES;
            myColorSprite.physicsBody.linearDamping = 13.0;
            //            myColorSprite.blendMode = SKBlendModeReplace ;
            //            myColorSprite.physicsBody.contactTestBitMask = 0x03;
            [myColorSprite setName:@"colorsprite"];
            [self addChild:myColorSprite];
            
            
            
            
            
            
            
            SKAction *mySpriteScaleUpDownAction = [SKAction sequence:
                                                   @[[SKAction scaleBy: 2.0 duration:0.1],
                                                     [SKAction scaleBy: 0.5 duration:0.1]]];
            
            SKAction *myColorSpriteChangeColor = [SKAction sequence: @[[SKAction colorizeWithColor:[UIColor whiteColor] colorBlendFactor:1.0 duration:0.5],                                                                     [SKAction colorizeWithColor:[UIColor colorWithRed:[self myRandom] green:[self myRandom] blue:[self myRandom] alpha:1.0] colorBlendFactor:1.0 duration:0.5],]];
            
            SKAction *mycolorSpriteAction =    [SKAction repeatActionForever:               [SKAction group:@[mySpriteScaleUpDownAction,myColorSpriteChangeColor]]];
            
            
            
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
    
    SKAction *myLabelAction = [SKAction sequence:@[[SKAction waitForDuration:1.0],
                                                   [SKAction fadeInWithDuration:2.0],
                                                   [SKAction waitForDuration:5.0],
                                                   [SKAction fadeOutWithDuration:1.0],
                                                   [SKAction waitForDuration:10.0],]];
    
    
    
    
    SKLabelNode *myLabel1 = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    [myLabel1 setText:@"Top Left Buttons for Colors, Sprite, Pictures"];
    //    , tap with two fingers to create snow, tap with three fingers to create smoke, swipe right to clear the screen!"];
    [myLabel1 setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))];
    [myLabel1 setFontSize:16];
    [myLabel1 setFontColor:[UIColor redColor]];
    [myLabel1 setAlpha:0.0];
    [self addChild:myLabel1];
    [myLabel1 runAction:[SKAction repeatActionForever:myLabelAction]];
    
    
    SKLabelNode *myLabel2 = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    //    , tap with two fingers to create snow, tap with three fingers to create smoke, swipe right to clear the screen!"];
    [myLabel2 setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-20)];
    [myLabel2 setFontSize:16];
    [myLabel2 setFontColor:[UIColor redColor]];
    [myLabel2 setText:@"Top Right Buttons to Show or Hide Forces"];
    [myLabel2 setAlpha:0.0];
    [self addChild:myLabel2];
    [myLabel2 runAction:[SKAction repeatActionForever:myLabelAction]];
    
    SKLabelNode *myLabel3 = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    //    , tap with two fingers to create snow, tap with three fingers to create smoke, swipe right to clear the screen!"];
    [myLabel3 setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-40)];
    [myLabel3 setFontSize:16];
    [myLabel3 setFontColor:[UIColor redColor]];
    [myLabel3 setText:@"Bottom Middle Buttons for Vortex or Gravity Force"];
    [myLabel3 setAlpha:0.0];
    [self addChild:myLabel3];
    [myLabel3 runAction:[SKAction repeatActionForever:myLabelAction]];
    
    
    SKLabelNode *myLabel4 = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    //    , tap with two fingers to create snow, tap with three fingers to create smoke, swipe right to clear the screen!"];
    [myLabel4 setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-60)];
    [myLabel4 setFontSize:16];
    [myLabel4 setFontColor:[UIColor redColor]];
    [myLabel4 setText:@"+ or - to Increase or Decrease Force"];
    [myLabel4 setAlpha:0.0];
    [self addChild:myLabel4];
    [myLabel4 runAction:[SKAction repeatActionForever:myLabelAction]];
    
    
    
    SKLabelNode *myLabel5 = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    //    , tap with two fingers to create snow, tap with three fingers to create smoke, swipe right to clear the screen!"];
    [myLabel5 setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-100)];
    [myLabel5 setFontSize:16];
    [myLabel5 setFontColor:[UIColor redColor]];
    [myLabel5 setText:@"Swipe Right to Clear the Screen"];
    [myLabel5 setAlpha:0.0];
    [self addChild:myLabel5];
    [myLabel5 runAction:[SKAction repeatActionForever:myLabelAction]];
    
    
    SKLabelNode *myLabel6 = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    //    , tap with two fingers to create snow, tap with three fingers to create smoke, swipe right to clear the screen!"];
    [myLabel6 setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-120)];
    [myLabel6 setFontSize:16];
    [myLabel6 setFontColor:[UIColor redColor]];
    [myLabel6 setText:@"Swipe Left to Reset Forces to Default Values"];
    [myLabel6 setAlpha:0.0];
    [self addChild:myLabel6];
    [myLabel6 runAction:[SKAction repeatActionForever:myLabelAction]];
    
    
    SKLabelNode *myLabel7 = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    //    , tap with two fingers to create snow, tap with three fingers to create smoke, swipe right to clear the screen!"];
    [myLabel7 setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-140)];
    [myLabel7 setFontSize:16];
    [myLabel7 setFontColor:[UIColor redColor]];
    [myLabel7 setText:@"Swipe Up to Make Color Blocks Heavier"];
    [myLabel7 setAlpha:0.0];
    [self addChild:myLabel7];
    [myLabel7 runAction:[SKAction repeatActionForever:myLabelAction]];
    
    SKLabelNode *myLabel8 = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    //    , tap with two fingers to create snow, tap with three fingers to create smoke, swipe right to clear the screen!"];
    [myLabel8 setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-160)];
    [myLabel8 setFontSize:16];
    [myLabel8 setFontColor:[UIColor redColor]];
    [myLabel8 setText:@"Swipe Down to Make Color Blocks Lighter"];
    [myLabel8 setAlpha:0.0];
    [self addChild:myLabel8];
    [myLabel8 runAction:[SKAction repeatActionForever:myLabelAction]];
    
}




@end
