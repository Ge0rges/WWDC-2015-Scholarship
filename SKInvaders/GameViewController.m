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
  ProjectViewController *projectVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProjectVC"];
  projectVC.appKey = @"WhatToPack";
    
  [self.navigationController pushViewController:projectVC animated:NO];
}

- (void)presentPersonalVC {
    PersonalViewController *personalVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PersonalVC"];
    [self.navigationController pushViewController:personalVC animated:NO];
}

@end