//
//  ProjectViewController.m
//  GeorgesKanaan
//
//  Created by Georges Kanaan on 4/18/15.
//  Copyright (c) 2015 RepublicOfApps, LLC. All rights reserved.
//

#import "ProjectViewController.h"

#define ProjectPlistPath [[NSBundle mainBundle] pathForResource:@"Projects" ofType:@"plist"]

@interface ProjectViewController () {
  NSDictionary *projects;
  NSDictionary *app;
}

@property (strong, nonatomic) IBOutlet UIImageView *iconView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutlet UITextView *descriptionTextView;

@end

@implementation ProjectViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  
  //fetch the project details from the plist
  projects = [NSDictionary dictionaryWithContentsOfFile:ProjectPlistPath];
  app = [projects objectForKey:_appKey];
  
  //check if we should set up the view
  NSString *appID = app[@"appID"];
  if (appID) {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    imageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:imageView];
    [self showAppSheetForID:appID];
    
  } else {
    [self setUpProjectForApp];
  }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Project Setup
- (void)setUpProjectForApp {
    //fill the view
    [self.iconView setImage:[UIImage imageNamed:app[@"imageName"]]];
    [self.nameLabel setText:app[@"name"]];
    [self.descriptionTextView setText:app[@"description"]];
    [self.statusLabel setText:app[@"status"]];
}

#pragma mark - StoreKit
- (void)showAppSheetForID:(NSString *)appID {
    // Initialize Product View Controller
    SKStoreProductViewController *storeProductViewController = [[SKStoreProductViewController alloc] init];
    
    //create the parameter dict
    NSDictionary *params = @{SKStoreProductParameterITunesItemIdentifier : appID};
    
    // Configure View Controller
    [storeProductViewController setDelegate:self];
    [storeProductViewController loadProductWithParameters:params completionBlock:^(BOOL result, NSError *error) {
      // Present Store Product View Controller
      if (!error && result) {
        [self presentViewController:storeProductViewController animated:NO completion:NULL];
      }
    }];
}

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController {
  [self.navigationController popToRootViewControllerAnimated:YES];
}

@end