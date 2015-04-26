//
//  ViewController.m
//  Georges Kanaan
//
//  Created by Georges Kanaan on 4/26/15.
//
//

#import "ViewController.h"

@interface ViewController () {
  UIImageView *bulletImageView;
  
  BOOL shouldStopAnimations;
}

@property (nonatomic, strong) UIDynamicAnimator *animator;

@property (nonatomic, strong) CMMotionManager *motionManager;

@property (strong, nonatomic) IBOutlet UILabel *dreamsLabel;
@property (strong, nonatomic) IBOutlet UILabel *projectsLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UIButton *personalButton;

@property (strong, nonatomic) IBOutlet UIImageView *dreamsImageView;
@property (strong, nonatomic) IBOutlet UIImageView *projectsImageView;
@property (strong, nonatomic) IBOutlet UIImageView *shipImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  // Update the status bar
  [self setNeedsStatusBarAppearanceUpdate];
  
  // Update the ship's y
  [self.shipImageView setCenter:CGPointMake(self.shipImageView.center.x, self.view.frame.size.height-self.shipImageView.frame.size.height)];
  
  // Initilaize the animator
  self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
  
  // Make sure the ship doesn't go off screen
  UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[self.shipImageView]];
  collision.translatesReferenceBoundsIntoBoundary = YES;
  [self.animator addBehavior:collision];
  
  // Initialize Motion Manager
  self.motionManager = (self.motionManager) ?:[CMMotionManager new];// We don't need to initiliaze if it already exists
  
  if (self.motionManager.accelerometerAvailable) {//We need device motion otherwise warn the user.
    [self.motionManager setAccelerometerUpdateInterval:1/50];// We need fast updates to have a responsive UI
    
  } else {// This is for simulator users
    [[[UIAlertView alloc] initWithTitle:@"No Motion Available." message:@"Hey There! To use my app you need an accelerometer; you must be testing on simulator. Try launching on a real device!" delegate:nil cancelButtonTitle:@"Ok!" otherButtonTitles:nil, nil] show];
  }
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  // Customize UI
  
  // Start animating the cloud and heart
  shouldStopAnimations = NO;
  [self animateCloudAndHeartUp:YES];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  
  // Start device motion updates
  [self.motionManager startAccelerometerUpdates];
  [NSTimer scheduledTimerWithTimeInterval:1/50 target:self selector:@selector(handleUserMotionUpdate) userInfo:nil repeats:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
  
  // Make sure the bulelt is nil
  [bulletImageView removeFromSuperview];
  bulletImageView = nil;
  
  // Stop the animations
  [self stopAnimateCloudAndHeart];
  
  // Stop device motion updates
  [self.motionManager stopAccelerometerUpdates];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions
- (IBAction)presentAboutMe:(UIButton *)sender {
  UIViewController *meVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PersonalVC"];
  [self presentViewController:meVC animated:YES completion:NULL];
}

#pragma mark - Animations
- (void)animateCloudAndHeartUp:(BOOL)up {
  if (!shouldStopAnimations) {
    if (up) {// Check if we should animate up or down
      [UIView animateWithDuration:0.5 animations:^{
        [self.dreamsImageView setCenter:CGPointMake(self.dreamsImageView.center.x, self.dreamsImageView.center.y-20)];
        [self.projectsImageView setCenter:CGPointMake(self.projectsImageView.center.x, self.projectsImageView.center.y-20)];
        
      } completion:^(BOOL finished) {
        [self animateCloudAndHeartUp:NO];//repeat
      }];
      
    } else {// Down
      [UIView animateWithDuration:0.5 animations:^{
        [self.dreamsImageView setCenter:CGPointMake(self.dreamsImageView.center.x, self.dreamsImageView.center.y+20)];
        [self.projectsImageView setCenter:CGPointMake(self.projectsImageView.center.x, self.projectsImageView.center.y+20)];
        
      } completion:^(BOOL finished) {
        [self animateCloudAndHeartUp:YES];//repeat
      }];
    }
    
    shouldStopAnimations = NO;
  }
}

- (void)stopAnimateCloudAndHeart {
  shouldStopAnimations = YES;
}

#pragma mark Ship
- (void)handleUserMotionUpdate {
  if (fabs(self.motionManager.accelerometerData.acceleration.x) > 0.1) {
    // Use UIDynamics to push the ship (apply a vector force)
    UIPushBehavior *push = [[UIPushBehavior alloc] initWithItems:@[self.shipImageView] mode:UIPushBehaviorModeInstantaneous];
    [push setPushDirection:CGVectorMake(0.01 * self.motionManager.accelerometerData.acceleration.x, 0)];
    
    dispatch_async(dispatch_get_main_queue(), ^{[self.animator addBehavior:push];});
  }
}

- (void)shipShoot {
  if (!bulletImageView) {// No more than 1 bullet at a time
    bulletImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ShipBullet"]];
    [self.view addSubview:bulletImageView];
    
    // Set the bullet position to the ship
    [bulletImageView setCenter:self.shipImageView.center];
    
    // Add an NSTimer that checks the bullet frame
    [NSTimer scheduledTimerWithTimeInterval:1/50 target:self selector:@selector(checkBullet:) userInfo:nil repeats:YES];
    
    // Apply a vertical force using UIDynamics
    UIPushBehavior *push = [[UIPushBehavior alloc] initWithItems:@[bulletImageView] mode:UIPushBehaviorModeContinuous];
    [push setPushDirection:CGVectorMake(0.0, -0.1)];
    
    dispatch_async(dispatch_get_main_queue(), ^{[self.animator addBehavior:push];});
  }
}

- (void)checkBullet:(NSTimer*)timer {
  if (CGRectContainsPoint(_dreamsLabel.frame, bulletImageView.center) || CGRectContainsPoint(_dreamsImageView.frame, bulletImageView.center)) {
    // Remove and stop the time
    [timer invalidate];
    timer = nil;

    // Show dreams view
    UIViewController *meVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DreamsVC"];
    [self presentViewController:meVC animated:YES completion:NULL];
    
  } else if (CGRectContainsPoint(_projectsLabel.frame, bulletImageView.center) || CGRectContainsPoint(_projectsImageView.frame, bulletImageView.center)) {
    // Remove and stop the time
    [timer invalidate];
    timer = nil;

    // Show Projects view
    UIViewController *meVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProjectsVC"];
    [self presentViewController:meVC animated:YES completion:NULL];
    
  } else if (CGRectContainsPoint(_personalButton.frame, bulletImageView.center)) {
    // Remove and stop the time
    [timer invalidate];
    timer = nil;

    // Show Personal view
    [self presentAboutMe:nil];
    
  } else if (!CGRectContainsPoint(self.view.frame, bulletImageView.center)) {
    // Remove and stop the time
    [timer invalidate];
    timer = nil;

    // Reset the bullet
    [bulletImageView removeFromSuperview];
    bulletImageView = nil;
  }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  UITouch *touch = [touches anyObject];
  CGPoint touchLocation = [touch locationInView:self.view];
  
  if (!CGRectContainsPoint(self.personalButton.frame, touchLocation)) {// Check if the user wanted to press the button
    // Shoot
    [self shipShoot];
  }
}

#pragma mark - Status Bar
- (BOOL)prefersStatusBarHidden {return YES;}
- (UIStatusBarStyle)preferredStatusBarStyle {return UIStatusBarStyleLightContent;}

@end