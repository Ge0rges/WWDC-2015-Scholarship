//
//  ProjectsViewController.m
//  Georges Kanaan
//
//  Created by Georges Kanaan on 4/26/15.
//
//

#import "ProjectsViewController.h"
#import "Georges_Kanaan-Swift.h"

#define kProjectsPath [[NSBundle mainBundle] pathForResource:@"Projects" ofType:@"plist"]

@interface ProjectsViewController () {
  NSInteger currentProjectIndex;
}

@property (strong, nonatomic) IBOutlet UILabel *projectNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel *projectNameLabel;

@property (strong, nonatomic) IBOutlet UIButton *storeButton;

@property (strong, nonatomic) IBOutlet UITextView *descriptiontextView;

@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UIButton *nextButton;

@end

@implementation ProjectsViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  
  // Load the first project
  currentProjectIndex = 0;
  [self populateViewForProjectIndex:currentProjectIndex];
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


#pragma mark - IBActions
- (IBAction)nextProject:(UIButton *)sender {
  currentProjectIndex += 1;
  [self populateViewForProjectIndex:currentProjectIndex];
}

- (IBAction)previousProject:(UIButton *)sender {
  if (currentProjectIndex == 0) {// If we are at the first project go back to main menu
    [self dismissViewControllerAnimated:YES completion:NULL];
  
  } else {
    currentProjectIndex -= 1;
    [self populateViewForProjectIndex:currentProjectIndex];
  }
}

- (IBAction)launchURL:(UIButton *)sender {
  // Get the project dict
  NSArray *projects = [NSArray arrayWithContentsOfFile:kProjectsPath];
  NSDictionary *project = projects[currentProjectIndex];
  NSString *url = project[@"url"];
  
  if (!url || [url isEqualToString:@""]) {
    [sender setEnabled:NO];
    return;
  }
  
  if ([url containsString:@"http"]) {// Check if this is a web URL or an App ID
    WebViewController *webViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WebVC"];
    webViewController.url = url;
    [self presentViewController:webViewController animated:YES completion:NULL];

  } else {
    // Disable the navigation buttons
    [self.backButton setEnabled:NO];
    [self.nextButton setEnabled:NO];
    
    // App ID launch with store kit
    SKStoreProductViewController *storeProductViewController = [[SKStoreProductViewController alloc] init];
    
    //create the parameter dict
    NSDictionary *params = @{SKStoreProductParameterITunesItemIdentifier : url};
    
    // Configure View Controller
    [storeProductViewController setDelegate:self];
    [storeProductViewController loadProductWithParameters:params completionBlock:^(BOOL result, NSError *error) {
      // Present Store Product View Controller
      if (!error && result) {
        [self presentViewController:storeProductViewController animated:YES completion:NULL];
      }
    }];
  }
}

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController {
  [viewController dismissViewControllerAnimated:YES completion:NULL];
  
  // Enable the navigation buttons
  [self.backButton setEnabled:YES];
  [self.nextButton setEnabled:YES];
}

#pragma mark - Helper Methods
- (void)populateViewForProjectIndex:(NSInteger)index {
  [self.projectNumberLabel setText:[NSString stringWithFormat:@"%i", (int)index+1]];
  
  // Get the project dict
  NSArray *projects = [NSArray arrayWithContentsOfFile:kProjectsPath];
  NSDictionary *project = projects[index];
  
  // Populate the view
  [self.projectNameLabel setText:project[@"name"]];
  [self.descriptiontextView setText:project[@"description"]];
  
  UIImage *statusImage = [UIImage imageNamed:project[@"status"]];
  [self.storeButton setBackgroundImage:statusImage forState:UIControlStateNormal];
  
  // Check if we should enable the store button
  NSString *url = project[@"url"];
  [self.storeButton setEnabled:!(!url || [url isEqualToString:@""])];
  
  // check if we should round the store button for my logo
  if (index == 0) {
    self.storeButton.layer.cornerRadius = 7;
    self.storeButton.layer.masksToBounds = YES;
  
  } else if (index == 1) { // We are possibly coming from a rounded button
    self.storeButton.layer.cornerRadius = 0.0;
    self.storeButton.layer.masksToBounds = NO;
  }
  
  // Fix the font
  [self.descriptiontextView setFont:[UIFont fontWithName:@"8-Bit-Madness" size:30]];// If we don't do this the font resets? -_-
  [self.descriptiontextView setTextColor:[UIColor whiteColor]];// If we don't do this the color resets? -_- -_-

  // Parse the RGB values and set the background color
  NSArray *array = [[project objectForKey:@"backgroundColor"] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
  float red = [array[0] floatValue];
  float green = [array[1] floatValue];
  float blue = [array[2] floatValue];

  [self.view setBackgroundColor:[UIColor colorWithRed:red/250.0 green:green/250.0 blue:blue/250.0 alpha:1.0]];
  
  // Check if there is a next project
  if (index+1 == projects.count) {
    [self.nextButton setHidden:YES];
  } else {
    [self.nextButton setHidden:NO];
  }
}

#pragma mark - Status Bar
- (BOOL)prefersStatusBarHidden {return YES;}
- (UIStatusBarStyle)preferredStatusBarStyle {return UIStatusBarStyleLightContent;}

@end
