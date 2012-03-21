//
//  AdViewController.m
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

#import "AdViewController.h"
#import "AdBannerController.h"

@interface AdViewController ()

@property (nonatomic, strong) ADBannerView *bannerView;

- (void)layoutAnimated:(BOOL)animated;

@end

@implementation AdViewController

@synthesize bannerView;
@synthesize contentView;

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
    [AdBannerController sharedInstance].delegate = self;
	self.bannerView = [AdBannerController sharedInstance].bannerView;
	[self.view addSubview:self.bannerView];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	self.bannerView = nil;
    [AdBannerController sharedInstance].delegate = nil;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
	self.contentView = nil;
	self.bannerView = nil;
    [AdBannerController sharedInstance].delegate = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    [self layoutAnimated:NO];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self layoutAnimated:duration > 0.0];
}

- (void)layoutAnimated:(BOOL)animated
{
    if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) {
        self.bannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
    } else {
        self.bannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierLandscape;
    }
    
    CGRect contentFrame = self.view.bounds;
    CGRect bannerFrame = self.bannerView.frame;
    if (bannerView.bannerLoaded) {
        contentFrame.size.height -= bannerView.frame.size.height;
        bannerFrame.origin.y = contentFrame.size.height;
    } else {
        bannerFrame.origin.y = contentFrame.size.height;
    }
    
    [UIView animateWithDuration:animated ? 0.25 : 0.0 animations:^{
        contentView.frame = contentFrame;
        [contentView layoutIfNeeded];
        bannerView.frame = bannerFrame;
    }];
}

#pragma -
#pragma AdBannerControllerDelegate methods

- (void)showBannerView:(ADBannerView *)_bannerView animated:(BOOL)animated
{
    [self layoutAnimated:animated];
}

- (void)hideBannerView:(ADBannerView *)bannerView animated:(BOOL)animated
{
    [self layoutAnimated:animated];
}


@end
