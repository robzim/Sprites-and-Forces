//
//  GameScene.h
//  Sprites and Forces
//

//  Copyright (c) 2014 Robert Zimmelman. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <Replaykit/ReplayKit.h>

@interface GameScene : SKScene

//@interface GameScene : SKScene<RPPreviewViewControllerDelegate, RPScreenRecorderDelegate>
@property NSOperationQueue *myQueue;
@property SKSpriteNode *myBG;
@property SKSpriteNode *myPositionSprite;
@property SKSpriteNode *myCursorSprite;
//@property SKSpriteNode *myColorSprite;

@property SKLabelNode *mySecondaryHelperLabel;
@property UIStackView *myDropItemsControl;
@property UIStackView *myShowHideForcesStackView;
@property UIStackView *myAdjustForcesStackView;
@property UIStackView *myScreenRecorderStackView;
@property NSArray *myTopControlValues;
@property UISegmentedControl *myPlaceForcesControl;
@property NSArray *myBottomControlValues;
@property SKAction *myLabelAction;
//@property SKAction *mySpriteTrail;


//@property (strong,nonatomic) UISegmentedControl *myTopControl;
//@property (strong,nonatomic) UISegmentedControl *myBottomControl;

@end
