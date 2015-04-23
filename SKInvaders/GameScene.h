//
//  GameScene.h
//  GeorgesKanaan
//

//  Copyright (c) 2013 Georges Kanaan, LLC. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "GameViewController.h"
#import "SKSpriteNodeExtensions.h"

@class GameViewController;

@interface GameScene : SKScene <SKPhysicsContactDelegate>

@property (strong, nonatomic) GameViewController *gvc;

@end