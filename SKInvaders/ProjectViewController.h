//
//  ProjectViewController.h
//  GeorgesKanaan
//
//  Created by Georges Kanaan on 4/18/15.
//  Copyright (c) 2015 RepublicOfApps, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

@interface ProjectViewController : UIViewController <SKStoreProductViewControllerDelegate>

@property (strong, nonatomic) NSString *appKey;

@end
