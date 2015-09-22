//
//  rt_IAPHelper.m
//  rTracker
//
//  Created by Rob Miller on 09/05/2015.
//  Copyright (c) 2015 Robert T. Miller. All rights reserved.
//

#import "rt_IAPHelper.h"
#import "rTracker-constants.h"
#import "rTracker-resource.h"
#import "dbg-defs.h"

@implementation rt_IAPHelper

+(void)productPurchased:(NSNotification *)notification {
    
    NSString * productIdentifier = notification.object;
    if ([RTA_prodid isEqualToString:productIdentifier]) {
        [rTracker_resource setPurchased:YES];
        DBGLog(@"purchased!");
    }
}

+ (rt_IAPHelper *)sharedInstance {
    static dispatch_once_t once;
    static rt_IAPHelper *sharedInstance;
    dispatch_once(&once, ^{
        NSSet *productIdentifiers = [NSSet setWithObjects:
                                     RTA_prodid,
                                      nil];
        sharedInstance = [[self alloc] initWithProductIdentifiers:productIdentifiers];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productPurchased:) name:IAPHelperProductPurchasedNotification object:nil];
    });
    
    
    return sharedInstance;
}

- (BOOL)productPurchased:(NSString *)productIdentifier {
    return [super productPurchased:productIdentifier];
}

- (void)buyProduct:(SKProduct *)product {
    [super buyProduct:product];
}


@end
