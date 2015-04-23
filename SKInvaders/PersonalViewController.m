//
//  PersonalViewController.m
//  GeorgesKanaan
//
//  Created by Georges Kanaan on 4/18/15.
//  Copyright (c) 2015 Georges Kanaan, LLC. All rights reserved.
//

#import "PersonalViewController.h"
#import "GeorgesKanaan-Swift.h"
@interface PersonalViewController ()

@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions
- (IBAction)openWebsite:(UIButton *)sender {
  WebViewController *webViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WebVC"];
  webViewController.url = @"http://ge0rges.me";
  [self presentViewController:webViewController animated:YES completion:NULL];
}

- (IBAction)openTwitter:(UIButton *)sender {
    NSURL *twitterURL = [NSURL URLWithString:@"twitter://user?screen_name=Ge0rges13"];
    if ([[UIApplication sharedApplication] canOpenURL:twitterURL]) {
        [[UIApplication sharedApplication] openURL:twitterURL];
    
    } else {
      WebViewController *webViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WebVC"];
      webViewController.url = @"https://twitter.com/Ge0rges13";
      [self presentViewController:webViewController animated:YES completion:NULL];
    }
}

- (IBAction)openGithub:(UIButton *)sender {
  WebViewController *webViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WebVC"];
  webViewController.url = @"https://github.com/Ge0rges";
  [self presentViewController:webViewController animated:YES completion:NULL];
}

@end