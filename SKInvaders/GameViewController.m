//
//  GameViewController.m
//  GeorgesKanaan
//

//  Copyright (c) 2013 RepublicOfApps, LLC. All rights reserved.
//

#import "GameViewController.h"
#import "ProjectViewController.h"
#import "GameScene.h"

@implementation GameViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Pause the view (and thus the game) when the app is interrupted or backgrounded
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleApplicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleApplicationDidBecomeActive:)  name:UIApplicationDidBecomeActiveNotification  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentProjectViewController)  name:@"presentProduct"  object:nil];

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = NO;
    skView.showsNodeCount = NO;

    // Create and configure the scene.
    SKScene * scene = [GameScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;

    // Present the scene.
    [skView presentScene:scene];
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (void)handleApplicationWillResignActive:(NSNotification *)note {
    ((SKView *)self.view).paused = YES;
}

- (void)handleApplicationDidBecomeActive:(NSNotification *)note {
    ((SKView *)self.view).paused = NO;
}

- (void)presentProjectViewController {
  [self performSelector:@selector(presentProjectVC) withObject:nil afterDelay:0];
}

- (void)presentProjectVC {
  ProjectViewController *projectViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ProjectVC"];
  projectViewController.appKey = @"WhatToPack";
    
  [self presentViewController:projectViewController animated:NO completion:NULL];
}

- (void)presentPersonalVC {
    ProjectViewController *projectViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PersonalVC"];
    projectViewController.appKey = @"WhatToPack";
    
    [self presentViewController:projectViewController animated:NO completion:NULL];
}

@end