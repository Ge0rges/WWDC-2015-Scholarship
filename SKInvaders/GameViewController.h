//
//  GameViewController.h
//  GeorgesKanaan
//

//  Copyright (c) 2013 RepublicOfApps, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "ProjectViewController.h"
#import "PersonalViewController.h"
#import "GameScene.h"

@interface GameViewController : UIViewController

- (void)presentPersonalVC;
- (void)presentProjectVCForAppKey:(NSString*)appKey;

@end