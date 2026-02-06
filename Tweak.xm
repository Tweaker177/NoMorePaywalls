#import <UIKit/UIKit.h>
#include <objc/runtime.h>

/* -------------------------
   Interface
------------------------- */

@interface PaywallViewControllerClass : UIViewController
{
    UIView* _view;
}
@property(nonatomic, assign) UIView* view;
- (void)loadView;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewDidAppear:(BOOL)animated;
- (void)viewWillLayoutSubviews;
@end

/* -------------------------
   Paywall Hooks
------------------------- */

// Removes $10/month membership ad overlay
%hook PaywallViewControllerClass

- (void)loadView {
    %orig;
    ((PaywallViewControllerClass *)self).view.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    animated = 0;
    %orig;
    ((PaywallViewControllerClass *)self).view.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    animated = 0;
    %orig;
    ((PaywallViewControllerClass *)self).view.hidden = YES;
}

- (void)viewWillLayoutSubviews {
    %orig;
    NSArray *subviews = [((PaywallViewControllerClass *)self).view subviews];
    for (UIView *subview in subviews) {
        [subview removeFromSuperview];
    }
}

%end

/* -------------------------
   Subscription Hooks
------------------------- */

%hook _TtC16NewsSubscription23SubscriptionAccessMeter

// Allows access to all articles
- (bool)canAccessArticleWithHeadline:(id)arg1 articleAccess:(long long)arg2 {
    return 1;
    return %orig;
}

%end

%hook _TtC12NewsArticles24ANFDebugSettingsProvider

// Possibly optional, ensures testing condition enabled
- (bool)testingConditionEnabled {
    return 1;
}

- (void)setTestingConditionEnabled:(bool)arg1 {
    arg1 = 1;
    return %orig;
}

%end

/* -------------------------
   Article Preview Hooks
------------------------- */

%hook NTPBShareInformationScreenView
- (void)setSubscriptionOnlyArticlePreview:(bool)arg1 {
    arg1 = 0;
    return %orig(arg1);
}

- (bool)subscriptionOnlyArticlePreview {
    return 0;
}

- (void)setHasSubscriptionOnlyArticlePreview:(bool)arg1 {
    arg1 = 0;
    return %orig;
}

- (bool)hasSubscriptionOnlyArticlePreview {
    return 0;
}
%end

%hook NTPBPaidSubscriptionResult
- (void)setSubscriptionOnlyArticlePreview:(bool)arg1 {
    arg1 = 0;
    return %orig;
}

- (void)setHasSubscriptionOnlyArticlePreview:(bool)arg1 {
    arg1 = 0;
    return %orig;
}

- (bool)hasSubscriptionOnlyArticlePreview {
    return 0;
}

- (bool)subscriptionOnlyArticlePreview {
    return 0;
}

- (void)setHasStorekitError:(bool)arg1 {
    arg1 = 0;
    return %orig;
}

- (bool)hasStorekitError {
    return 0;
}
%end

%hook NTPBPaidSubscriptionConversionPointExposure
- (void)setSubscriptionOnlyArticlePreview:(bool)arg1 {
    arg1 = 0;
    return %orig;
}

- (void)setHasSubscriptionOnlyArticlePreview:(bool)arg1 {
    arg1 = 0;
    return %orig;
}

- (bool)hasSubscriptionOnlyArticlePreview {
    return 0;
}

- (bool)subscriptionOnlyArticlePreview {
    return 0;
}
%end

/* -------------------------
   Ad / Impression Hooks
------------------------- */

%hook NTPBIssueTocView
- (void)setHasAdSupportedChannel:(bool)arg1 {
    arg1 = 0;
    return %orig;
}

- (bool)hasAdSupportedChannel {
    return 0;
}
%end

%hook NTPBAdImpression
- (bool)hasIadCampaign { return 0; }
- (bool)hasIadLine { return 0; }
- (bool)hasIadAd { return 0; }

- (void)setHasAdLocation:(bool)arg1 { arg1 = 0; return %orig; }
- (bool)hasAdLocation { return 0; }

- (bool)hasVideoAdType { return 0; }
- (bool)hasVideoAdDuration { return 0; }
- (void)setHasVideoAdDuration:(bool)arg1 { arg1 = 0; return %orig; }
- (void)setHasVideoAdType:(bool)arg1 { arg1 = 0; return %orig; }

- (bool)hasAdImpressionId { return 0; }
- (bool)hasVideoAdPlacementPosition { return 0; }
- (void)setHasVideoAdPlacementPosition:(bool)arg1 { arg1 = 0; return %orig; }

- (bool)hasAdImpressionTimeThreshold { return %orig; }

- (void)setHasAdType:(bool)arg1 { arg1 = 0; return %orig; }
- (bool)hasAdType { return 0; }

- (void)setHasAdCreativeType:(bool)arg1 { return %orig; }
- (bool)hasAdCreativeType { return %orig; }
%end

%hook TSChannelBlockedAlertPresenter
- (bool)enabled { return 0; }
- (void)setEnabled:(bool)arg1 { arg1 = 0; return %orig; }
%end

/* -------------------------
   Swift Class Initialization
------------------------- */

%ctor {
    // Swizzle Swift Classes so hooks work
    %init(PaywallViewControllerClass = objc_getClass("NewsSubscription.PaywallViewController"));
}
