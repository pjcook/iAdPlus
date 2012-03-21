//
//  AdBannerController.m
//
//  iAdPlus
//	Version 1.0.0
//
//  Created by PJ Cook on 20/03/2012.
//  Copyright (c) 2012 Software101. All rights reserved.
//
//  Distributed under the permissive zlib License
//  Get the latest version from either of this location:
//
//  https://github.com/oPJo/iAdPlus
//
//  This software is provided 'as-is', without any express or implied
//  warranty.  In no event will the authors be held liable for any damages
//  arising from the use of this software.
//
//  Permission is granted to anyone to use this software for any purpose,
//  including commercial applications, and to alter it and redistribute it
//  freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//  claim that you wrote the original software. If you use this software
//  in a product, an acknowledgment in the product documentation would be
//  appreciated but is not required.
//
//  2. Altered source versions must be plainly marked as such, and must not be
//  misrepresented as being the original software.
//
//  3. This notice may not be removed or altered from any source distribution.
//

#import "AdBannerController.h"

@interface AdBannerController()

@property (nonatomic, strong, readwrite) ADBannerView *bannerView;

@end

@implementation AdBannerController

@synthesize bannerView;
@synthesize delegate;

- (void)dealloc
{
    self.bannerView.delegate = nil;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.bannerView = [[ADBannerView alloc] init];
        self.bannerView.delegate = self;
    }
    return self;
}

static AdBannerController *_sharedInstance;

+ (AdBannerController *)sharedInstance
{
    
    if (_sharedInstance == nil)
    {
        @synchronized(self)
        {
            if (_sharedInstance == nil)
            {
                _sharedInstance = [[AdBannerController alloc] init];
            }
        }
    }
    return _sharedInstance;
}

+ (void)removeSharedInstance
{
    @synchronized(self)
    {
        _sharedInstance.delegate = nil;
        _sharedInstance = nil;
    }
}

#pragma -
#pragma ADBannerViewDelegate methods

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(showBannerView:animated:)])
    {
        [self.delegate showBannerView:banner animated:YES];
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
	NSLog(@"%@", [error localizedDescription]);
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(hideBannerView:animated:)])
    {
        [self.delegate hideBannerView:banner animated:YES];
    }
}


@end
