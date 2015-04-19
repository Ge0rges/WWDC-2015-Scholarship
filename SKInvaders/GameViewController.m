//
//  GameViewController.m
//  GeorgesKanaan
//

//  Copyright (c) 2013 RepublicOfApps, LLC. All rights reserved.
//

#import "GameViewController.h"

@implementation GameViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Pause the view (and thus the game) when the app is interrupted or backgrounded
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleApplicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleApplicationDidBecomeActive:)  name:UIApplicationDidBecomeActiveNotification  object:nil];

    // Configure the view.
    SKView *skView = (SKView *)self.view;

    // Create and configure the scene.
    GameScene *gameScene = [GameScene sceneWithSize:skView.bounds.size];
    gameScene.scaleMode = SKSceneScaleModeAspectFill;
    gameScene.gvc = self;

    // Present the scene.
    [skView presentScene:gameScene];
}

- (void)handleApplicationWillResignActive:(NSNotification *)note {
    ((SKView *)self.view).paused = YES;
}

- (void)handleApplicationDidBecomeActive:(NSNotification *)note {
    ((SKView *)self.view).paused = NO;
}


- (void)presentProjectVCForAppKey:(NSString*)appKey {
  ProjectViewController *projectVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProjectVC"];
  projectVC.appKey = appKey;
    
  [self.navigationController pushViewController:projectVC animated:NO];
}

- (void)presentPersonalVC {
    PersonalViewController *personalVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PersonalVC"];
    [self.navigationController pushViewController:personalVC animated:NO];
}

@end