 //
//  SKSpriteNodeExtensions.m
//  GeorgesKanaan
//
//  Created by Georges Kanaan on 4/23/15.
//  Copyright (c) 2015 Georges Kanaan, LLC. All rights reserved.
//

#import "SKSpriteNodeExtensions.h"
#import <objc/runtime.h>

static void * appIDKey = &appIDKey;

@implementation SKSpriteNode (Custom)

- (NSString *)appID {
  return objc_getAssociatedObject(self, @selector(appID));
}

- (void)setAppID:(NSString *)appID {
  objc_setAssociatedObject(self, @selector(appID), appID, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end