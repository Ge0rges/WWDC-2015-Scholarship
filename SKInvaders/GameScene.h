//
//  GameScene.h
//  GeorgesKanaan
//

//  Copyright (c) 2013 RepublicOfApps, LLC. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "GameViewController.h"

@class GameViewController;

@interface GameScene : SKScene <SKPhysicsContactDelegate>

@property (strong, nonatomic) GameViewController *gvc;

@end