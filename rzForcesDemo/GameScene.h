//
//  GameScene.h
//  Sprites and Forces
//

//  Copyright (c) 2014 Robert Zimmelman. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
@interface GameScene : SKScene
@property NSOperationQueue *myQueue;
@property SKSpriteNode *myBG;
@property SKSpriteNode *myPositionSprite;
@property SKSpriteNode *myCursorSprite;
@property SKLabelNode *mySecondaryHelperLabel;
@property UISegmentedControl *myTopControl;
@property NSArray *myTopControlValues;
//@property (strong,nonatomic) UISegmentedControl *myTopControl;
//@property (strong,nonatomic) UISegmentedControl *myBottomControl;

@end
