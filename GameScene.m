//
//  GameScene.m
//  Sprites and Forces
//
//  Created by Robert Zimmelman on 12/23/14.
//  Copyright (c) 2014 Robert Zimmelman. All rights reserved.
//

#import "GameScene.h"
long myForce = 0;
long mySpringStrength = -1;
long mySpringStartStrength = -1;
long myGravityStrength = 1;
long myGravityFalloff = 2.0 ;
long myVortexStrength = 10.0;
long myVortexStartStrength = 10.0 ;
long myRadialGravityStrength = 10.0;
long myRadialGravityFalloff = 0.5;
long mySpringFieldFalloff = 3.0;
long myVortexFalloff = 2.5;
int myFieldsIndex = 4;
int myControlHeight = 50;
int myColorSpriteDuration = 120;
//long myVortexSpringStrength = 1;




SKSpriteNode *myColorSprite;
@implementation GameScene


-(void)didMoveToView:(SKView *)view {

//    UISwipeGestureRecognizer *myUpSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(myUpSwipeAction)];
//    [myUpSwipeGestureRecognizer setDirection:UISwipeGestureRecognizerDirectionUp];
//    [self.view addGestureRecognizer:myUpSwipeGestureRecognizer];
//    
//    
//    UISwipeGestureRecognizer *myDownSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(myDownSwipeAction)];
//    [myDownSwipeGestureRecognizer setDirection:UISwipeGestureRecognizerDirectionDown];
//    [self.view addGestureRecognizer:myDownSwipeGestureRecognizer];
//    
//    
//    
//    
    UISwipeGestureRecognizer *myLeftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(myLeftSwipeAction)];
    [myLeftSwipeGestureRecognizer setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:myLeftSwipeGestureRecognizer];
    
    
    UISwipeGestureRecognizer *myRightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(myRightSwipeAction)];
    [myRightSwipeGestureRecognizer setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:myRightSwipeGestureRecognizer];

    
    NSArray *myBottomControlValues  = @[@"V+",@"V-",@"Vortex",@"Spring",@"Gravity",@"S+",@"S-"] ;
    UISegmentedControl *myBottomControl = [[ UISegmentedControl alloc] initWithItems:myBottomControlValues ];
    [myBottomControl setFrame:CGRectMake(0, self.view.bounds.size.height - myControlHeight , self.view.bounds.size.width , myControlHeight  )];
    [myBottomControl setApportionsSegmentWidthsByContent:YES];
    [myBottomControl addTarget:self action:@selector(myBottomSwitchChanged:) forControlEvents:UIControlEventValueChanged ];
    [myBottomControl setSelectedSegmentIndex:3];
    myForce = 3;
    [self.view addSubview:myBottomControl];

    
    
    NSArray *myTopControlValues  = @[@"Colors",@"Zim",@"Family", @"Forces" , @"Hide Forces", @"Quit"] ;
    UISegmentedControl *myTopControl = [[ UISegmentedControl alloc] initWithItems:myTopControlValues ];
    //int myTopControlSeqmentWidth = 85;
    [myTopControl addTarget:self action:@selector(myTopSwitchChanged:) forControlEvents:UIControlEventValueChanged ];
    //[myTopControl setWidth:myTopControlSeqmentWidth forSegmentAtIndex:4];
    [myTopControl setSelectedSegmentIndex:myFieldsIndex];
//    [myTopControl setFrame:CGRectMake(0, 0, self.view.bounds.size.width, myControlHeight)];
    [myTopControl setFrame:CGRectMake(0, 0, self.view.bounds.size.width, myControlHeight)];
    [myTopControl setApportionsSegmentWidthsByContent:YES];
    [self.view addSubview:myTopControl];
    /* Setup your scene here */
//    SKSpriteNode *myHolderNode = [SKSpriteNode spriteNodeWithColor:[UIColor blackColor] size:CGSizeZero];
//    [myHolderNode setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))];
//    [self addChild:myHolderNode];
//    NSString *myFireFliesEmitterNodePath = [[NSBundle mainBundle] pathForResource:@"myFireFlies" ofType:@"sks"];
//    SKEmitterNode *myFireFliesEmitterNode =  [NSKeyedUnarchiver unarchiveObjectWithFile:myFireFliesEmitterNodePath];
//    [myHolderNode addChild:myFireFliesEmitterNode];
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
    
    [self setPhysicsBody:[SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame] ];

    
    
}


-(void)makeMyInstructionLabels{
    SKLabelNode *myLabel1 = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    [myLabel1 setText:@"Top Left Buttons for Colors, Sprite, Pictures"];
    //    , tap with two fingers to create snow, tap with three fingers to create smoke, swipe right to clear the screen!"];
    [myLabel1 setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))];
    [myLabel1 setFontSize:16];
    [myLabel1 setFontColor:[UIColor redColor]];
    [myLabel1 setAlpha:0.0];
    [self addChild:myLabel1];
    [myLabel1 runAction:[SKAction sequence:@[[SKAction waitForDuration:1.0],
                                             [SKAction fadeInWithDuration:2.0],]]];
    
    
    
    SKLabelNode *myLabel2 = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    //    , tap with two fingers to create snow, tap with three fingers to create smoke, swipe right to clear the screen!"];
    [myLabel2 setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-20)];
    [myLabel2 setFontSize:16];
    [myLabel2 setFontColor:[UIColor redColor]];
    [myLabel2 setText:@"Top Right Buttons to Show or Hide Forces"];
    [myLabel2 setAlpha:0.0];
    [self addChild:myLabel2];
    [myLabel2 runAction:[SKAction sequence:@[[SKAction waitForDuration:1.0],
                                             [SKAction fadeInWithDuration:3.0],]]];
    
    SKLabelNode *myLabel3 = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    //    , tap with two fingers to create snow, tap with three fingers to create smoke, swipe right to clear the screen!"];
    [myLabel3 setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-40)];
    [myLabel3 setFontSize:16];
    [myLabel3 setFontColor:[UIColor redColor]];
    [myLabel3 setText:@"Bottom Middle Buttons for Vortex or Gravity Force"];
    [myLabel3 setAlpha:0.0];
    [self addChild:myLabel3];
    [myLabel3 runAction:[SKAction sequence:@[[SKAction waitForDuration:1.0],
                                             [SKAction fadeInWithDuration:4.0],]]];
    
    
    SKLabelNode *myLabel4 = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    //    , tap with two fingers to create snow, tap with three fingers to create smoke, swipe right to clear the screen!"];
    [myLabel4 setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-60)];
    [myLabel4 setFontSize:16];
    [myLabel4 setFontColor:[UIColor redColor]];
    [myLabel4 setText:@"+ or - to Increase or Decrease Force"];
    [myLabel4 setAlpha:0.0];
    [self addChild:myLabel4];
    [myLabel4 runAction:[SKAction sequence:@[[SKAction waitForDuration:1.0],
                                             [SKAction fadeInWithDuration:5.0],]]];
    


    SKLabelNode *myLabel5 = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    //    , tap with two fingers to create snow, tap with three fingers to create smoke, swipe right to clear the screen!"];
    [myLabel5 setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-100)];
    [myLabel5 setFontSize:16];
    [myLabel5 setFontColor:[UIColor redColor]];
    [myLabel5 setText:@"Swipe Right to Clear the Screen"];
    [myLabel5 setAlpha:0.0];
    [self addChild:myLabel5];
    [myLabel5 runAction:[SKAction sequence:@[[SKAction waitForDuration:1.0],
                                             [SKAction fadeInWithDuration:5.0],]]];


    SKLabelNode *myLabel6 = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    //    , tap with two fingers to create snow, tap with three fingers to create smoke, swipe right to clear the screen!"];
    [myLabel6 setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-120)];
    [myLabel6 setFontSize:16];
    [myLabel6 setFontColor:[UIColor redColor]];
    [myLabel6 setText:@"Swipe Left to Reset Forces to Default Values"];
    [myLabel6 setAlpha:0.0];
    [self addChild:myLabel6];
    [myLabel6 runAction:[SKAction sequence:@[[SKAction waitForDuration:1.0],
                                             [SKAction fadeInWithDuration:5.0],]]];

    
}



- (IBAction)myTopSwitchChanged:(UISegmentedControl *)sender{
    long myValue = sender.selectedSegmentIndex;
    if (myValue == 0) {
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
        [sender setSelectedSegmentIndex:myFieldsIndex];
        
    } // end of if myValue == 0
    
    else if (myValue == 1) {
        SKSpriteNode *colorsprite = [SKSpriteNode spriteNodeWithImageNamed:@"Julius Zimmelman.jpg"];
        colorsprite.position = CGPointMake(CGRectGetMidX(self.frame),
                                           CGRectGetMaxY(self.frame)-1);
        [colorsprite setPhysicsBody:[SKPhysicsBody bodyWithRectangleOfSize:colorsprite.size]];
        [colorsprite.physicsBody setAffectedByGravity:YES];
        [colorsprite setScale:.6];
        colorsprite.physicsBody.mass = 1;
        colorsprite.physicsBody.linearDamping = 5;
        colorsprite.zPosition = 1;
        SKAction *mycolorSpriteAction =    [SKAction sequence:@[
                                                                [SKAction waitForDuration:myColorSpriteDuration withRange:0.5],
                                                                [SKAction removeFromParent],
                                                                ]];
        [colorsprite runAction:mycolorSpriteAction];
        
        [self addChild:colorsprite];
        [sender setSelectedSegmentIndex:myFieldsIndex];
    }
    
    
    else if (myValue == 2) {
        
        NSString *mySpriteName = @"";
        NSArray *mySprites  = @[@"Danny",  @"Mike", @"Andy", @"Cindy" , @"Dad"] ;
        //
        //
        // rz set the number of sprites to the size of the mySprites array
        
        NSInteger myNumberofSprites = [mySprites count];
        int myLoops = 1;
        float myScale = 0.1;
        //
        //
        
        CGPoint location = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMaxY(self.frame)-30);
        for (int myLoopCounter = 0 ; myLoopCounter < myLoops ; myLoopCounter++) {
            for (int myCount = 0; myCount < myNumberofSprites ; myCount++) {
                mySpriteName = mySprites[myCount];
                SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:mySpriteName];
                sprite.position = location;
                //
                //  rz physicsbody stuff here
                //
                sprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:sprite.size];
                sprite.physicsBody.linearDamping = 5;
                sprite.physicsBody.mass = 1;
                sprite.zPosition = 1;
                sprite.xScale = sprite.yScale = myScale;
                [sprite runAction:
                 [SKAction sequence:@[
                                      [SKAction waitForDuration:myColorSpriteDuration withRange:1.5],
                                      [SKAction removeFromParent],
                                      ]]  ];
                [self addChild:sprite];
                //[sprite addChild:myExitEmitter];
            }
        } // end of loopcount loop
        
        [sender setSelectedSegmentIndex:myFieldsIndex];
    }
    else if (myValue == 3) {
        //
        // show forces
        myFieldsIndex = 3;
            [self.view setShowsFields:YES];
            [sender setSelectedSegmentIndex:myFieldsIndex];
        }
    
    else if (myValue == 4) {
        myFieldsIndex = 4;
        [self.view setShowsFields:NO];
        [sender setSelectedSegmentIndex:myFieldsIndex];
    }
    else if (myValue == 5){
        exit(0);
    }
    
}






-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    for (UITouch *touch in touches) {
//        SKAction *myEffectSpriteAction = [SKAction sequence:@[
//                                                              [SKAction waitForDuration:10.0 withRange:5.5],
//                                                              [SKAction removeFromParent],
//                                                              ]];
        CGPoint location = [touch locationInNode:self];
        SKSpriteNode *myPositionSprite = [[SKSpriteNode alloc] initWithColor:[UIColor blackColor] size:CGSizeMake(10, 10)];
        [myPositionSprite setPosition:location];
        NSString *mySpringEmitterNodePath = [[NSBundle mainBundle] pathForResource:@"MyParticle" ofType:@"sks"];
        SKEmitterNode *myEmitterNode =  [NSKeyedUnarchiver unarchiveObjectWithFile:mySpringEmitterNodePath];
        SKEmitterNode *mySpringNodeEmitter =  [NSKeyedUnarchiver unarchiveObjectWithFile:mySpringEmitterNodePath];
        SKFieldNode *mySpringFieldNode = [SKFieldNode springField];
        [mySpringFieldNode setStrength:myGravityStrength];
        SKSpriteNode *myForceImage = [SKSpriteNode spriteNodeWithImageNamed:@"rzForces Image.png"];
//        [myForceImage setAlpha:.3];
        [myForceImage setScale:.6];
        
        
//        SKAction *myGravityAction = [SKAction sequence:@[
//                                                              [SKAction waitForDuration:10.0 withRange:5.5],
//                                                              [SKAction removeFromParent],
//                                                              ]];
        SKAction *mySlowSpin = [SKAction rotateByAngle:M_PI*50 duration:myColorSpriteDuration];
        //        NSLog(@"NOW myforce = %ld",myForce);
        
        switch (myForce) {
            case 2:
            {
                //
                //
                //
                //
                // rz vortex
                //
                //
                NSString *myVortexEmitterPath = [[NSBundle mainBundle] pathForResource:@"VortexParticle" ofType:@"sks"] ;
//                SKPhysicsBody *myVortexEmitterPhysicsBody = [SKPhysicsBody bodyWithCircleOfRadius:5];
                SKEmitterNode *myVortexEmitterNode = [NSKeyedUnarchiver unarchiveObjectWithFile:myVortexEmitterPath];
                SKFieldNode *myVortexFieldNode = [SKFieldNode vortexField];
                //[myVortexFieldNode setDirection:1.0];
                if (myVortexStrength == 0) {
                    [myVortexFieldNode setStrength: myVortexStartStrength ];
                }
                else [myVortexFieldNode setStrength: myVortexStrength ];
                [myVortexFieldNode setFalloff: myVortexFalloff ];
                [myVortexFieldNode setName:@"vortex"];
//                [myVortexEmitterNode setPhysicsBody:myVortexEmitterPhysicsBody];
//                [myVortexEmitterNode.physicsBody setLinearDamping:3];
//                [myPositionSprite runAction:myEffectSpriteAction];
//                [myPositionSprite addChild:myForceImage];
                [myPositionSprite addChild:myEmitterNode];
                [myPositionSprite addChild:myVortexFieldNode];
                [myPositionSprite addChild:myVortexEmitterNode];
//                [mySpringFieldNode setStrength: mySpringStrength ];
//                [myPositionSprite addChild:mySpringFieldNode];
                [self addChild:myPositionSprite];
                [myPositionSprite runAction:mySlowSpin];
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
                //
                // rz gravity
                //
                //
                SKAction *myGravityAction = [SKAction sequence:@[
                                                                 [SKAction fadeInWithDuration:(NSTimeInterval) 0.05],
                                                                 [SKAction fadeOutWithDuration:(NSTimeInterval) 1.75],
                                                                 ]];

                SKFieldNode *myRadialGravityNode = [SKFieldNode radialGravityField ];
                [myRadialGravityNode setStrength:myRadialGravityStrength];
                [myRadialGravityNode setName:@"gravity"];
                [myRadialGravityNode setFalloff:myRadialGravityFalloff];
                [myPositionSprite addChild:myForceImage];
                [myPositionSprite addChild:myRadialGravityNode];
                [self addChild:myPositionSprite];
                [myPositionSprite runAction:[SKAction repeatActionForever:myGravityAction]];
                break;
            }

            default:
                break;
        }
        
    }
}

- (IBAction)myBottomSwitchChanged:(UISegmentedControl *)sender{
    long myValue = sender.selectedSegmentIndex;
//    myVortexStrength = myVortexStartStrength;
    //    NSLog(@"Value = %ld",myValue);
    switch (myValue) {
        case 0:
            myVortexStrength-= 10;

            [self enumerateChildNodesWithName:@"vortex" usingBlock:^(SKNode *node, BOOL *stop) {
                [ (SKFieldNode *) node setStrength:myVortexStrength ];
            }];

            [sender setSelectedSegmentIndex:myForce];
            break;
        case 1:
            myVortexStrength+= 10;
            [self enumerateChildNodesWithName:@"vortex" usingBlock:^(SKNode *node, BOOL *stop) {
                [ (SKFieldNode *) node setStrength:myVortexStrength ];
            }];
            [sender setSelectedSegmentIndex:myForce];
            break;
        case 2:
            myForce = myValue;
            [sender setSelectedSegmentIndex:myForce];
            break;
        case 3:
            myForce = myValue;
            [sender setSelectedSegmentIndex:myForce];
            break;
        case 4:
            myForce = myValue;
            [sender setSelectedSegmentIndex:myForce];
            break;
        case 5:
            mySpringStrength+=20;
            [self enumerateChildNodesWithName:@"spring" usingBlock:^(SKNode *node, BOOL *stop) {
                [(SKFieldNode *) node setStrength:mySpringStrength ];
            }];
            
            
            [sender setSelectedSegmentIndex:myForce];
            break;
        case 6:
            mySpringStrength-=20;
            [self enumerateChildNodesWithName:@"spring" usingBlock:^(SKNode *node, BOOL *stop) {
                [(SKFieldNode *) node setStrength:mySpringStrength ];
            }];
            
            [sender setSelectedSegmentIndex:myForce];
            break;
        default:
            break;
            
    }
    NSLog(@"Spring = %ld / Vortex = %ld",mySpringStrength,myVortexStrength);
}

-(void)myRightSwipeAction{
    [self removeAllChildren];
    [self makeMyInstructionLabels];

}


-(void)myLeftSwipeAction{
    myVortexStrength = myVortexStartStrength;
    mySpringStrength = mySpringStartStrength;
}


-(void)update:(CFTimeInterval)currentTime {
    
    //    NSLog(@"children = %i",self.children.count);
    
    if ( self.children.count > 600) {
        [self enumerateChildNodesWithName:@"colorsprite" usingBlock:^(SKNode *node, BOOL *stop) {
            [node removeFromParent];
        }];
    }
    
    /* Called before each frame is rendered */
}

@end
