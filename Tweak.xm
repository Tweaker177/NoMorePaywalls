#import <UIKit/UIKit.h>
#include <objc/runtime.h>

@interface PaywallViewControllerClass : UIViewController
{
UIView* _view;
}
@property(nonatomic, assign) UIView* view;
-(void)loadView;
-(void)viewWillAppear:(BOOL)animated;
-(void)viewDidAppear:(BOOL)animated;
- (void)viewWillLayoutSubviews;

@end




//start off removing the ad to buy the $10/month News membership
//this can be skipped and left in and it still lets you read the articles
%hook PaywallViewControllerClass
-(void)loadView {
%orig;
 ((PaywallViewControllerClass *)self).view.hidden = YES;
}


-(void)viewWillAppear:(BOOL)animated {
animated = 0;
    %orig;
   // self.view.hidden = YES;
    ((PaywallViewControllerClass *)self).view.hidden = YES;
}

-(void)viewDidAppear:(BOOL)animated {
animated = 0;
    %orig;
   // self.view.hidden = YES;
    ((PaywallViewControllerClass *)self).view.hidden = YES;
   
}

- (void)viewWillLayoutSubviews {
    %orig;
    NSArray *subviews = [((PaywallViewControllerClass *) self).view subviews];
    for (UIView *subview in subviews) {
        [subview removeFromSuperview];
    }
}
%end

%hook _TtC16NewsSubscription23SubscriptionAccessMeter

	//This is the meat and potatoes line right here

-(bool)canAccessArticleWithHeadline:(id)arg1 articleAccess:(long long)arg2 {
    return 1;
    return %orig;
}
%end


%hook _TtC12NewsArticles24ANFDebugSettingsProvider
-(bool)testingConditionEnabled {
//not sure if this is needed it was a guess as far as functionality
    return 1;
}

-(void)setTestingConditionEnabled:(bool)arg1 {
    arg1 = 1;
    return %orig;
}
%end



%hook NTPBShareInformationScreenView
-(void)setSubscriptionOnlyArticlePreview:(bool)arg1 {
    arg1 = 0;
    return %orig(arg1);
}

-(bool)subscriptionOnlyArticlePreview {
    return 0;
}
%end

%hook NTPBWebAccessScreenView
-(void)setSubscriptionOnlyArticlePreview:(bool)arg1 {
    arg1 = 0;
    return %orig(arg1);
}
%end

%hook NTPBPaidSubscriptionResult
-(void)setSubscriptionOnlyArticlePreview:(bool)arg1 {
    arg1 = 0;
    return %orig;
}
%end


%hook NTPBShareInformationScreenView
-(void)setHasSubscriptionOnlyArticlePreview:(bool)arg1 {
    arg1 = 0;
    return %orig;
}

-(bool)hasSubscriptionOnlyArticlePreview {
    return 0;
}
%end

%hook NTPBPaidSubscriptionResult
-(void)setHasSubscriptionOnlyArticlePreview:(bool)arg1 {
    arg1 = 0;
    return %orig;
}

-(bool)hasSubscriptionOnlyArticlePreview {
    return 0;
}

-(bool)subscriptionOnlyArticlePreview {
    return 0;
}
%end

%hook NTPBPaidSubscriptionConversionPointExposure
-(void)setSubscriptionOnlyArticlePreview:(bool)arg1 {
    arg1 = 0;
    return %orig;
}

-(void)setHasSubscriptionOnlyArticlePreview:(bool)arg1 {
arg1= 0; // was just orig

    return %orig;
}

-(bool)hasSubscriptionOnlyArticlePreview {
    return 0;
}

-(bool)subscriptionOnlyArticlePreview {
    return 0; 
// was %orig
}
%end

// A lot of the hooks from here down might not be needed
// It doesn't hurt leaving them in tho just in case

%hook NTPBIssueTocView
-(void)setHasAdSupportedChannel:(bool)arg1 {
    arg1 = 0;
    return %orig;
}

-(bool)hasAdSupportedChannel {
    return 0;
}
%end

%hook _TtC12NewsArticles24ANFDebugSettingsProvider
-(bool)viewportDebuggingEnabled {
    return %orig;
}

-(void)setViewportDebuggingEnabled:(bool)arg1 {
    arg1 = 1;
    return %orig;
}
%end

%hook NTPBAdImpression
-(bool)hasIadCampaign {
    return 0;
}

-(bool)hasIadLine {
    return 0;
}

-(bool)hasIadAd {
    return 0;
}

-(void)setHasAdLocation:(bool)arg1 {
    arg1 = 0;
    return %orig;
}

-(bool)hasAdLocation {
    return 0;
}

-(bool)hasVideoAdType {
    return 0;
}

-(bool)hasVideoAdDuration {
    return 0;

}

-(void)setHasVideoAdDuration:(bool)arg1 {
    arg1 = 0;
    return %orig;
}

-(bool)hasAdImpressionId {
    return 0;
}

-(bool)hasVideoAdPlacementPosition {
    return 0;
}

-(bool)hasAdImpressionTimeThreshold {
    return %orig;
}

-(void)setHasVideoAdPlacementPosition:(bool)arg1 {
    arg1 = 0;
    return %orig;
}

-(void)setHasVideoAdType:(bool)arg1 {
    arg1 = 0;
    return %orig;
}

-(void)setHasAdCreativeType:(bool)arg1 {
    return %orig;
}

-(bool)hasAdCreativeType {
    return %orig;
}

-(bool)hasAdType {
    return 0;
}

-(void)setHasAdType:(bool)arg1 {
    arg1 = 0;
    return %orig;
}
%end

%hook NTPBPaidSubscriptionSheetIapFail
-(bool)hasFailedIapId {
    return 0;   // Just in case
}
%end

%hook NTPBPaidSubscriptionResult
-(void)setHasStorekitError:(bool)arg1 {
arg1 = 0;  // JUST IN Case lol

    return %orig;
}

-(bool)hasStorekitError {
    return 0;
}
%end

%hook TSChannelBlockedAlertPresenter
-(bool)enabled {
    return 0;
}

-(void)setEnabled:(bool)arg1 {
    arg1 = 0;
    return %orig;
}
%end


%ctor {
//Swizzling Swift Classes so the names are correct and the hooks work
	
 %init(PaywallViewControllerClass = objc_getClass("NewsSubscription.PaywallViewController"));
  
       }

/*  ********************************************************
//Unused methods I grabbed when researching
 //trial and error testing this tweak during development

%hook NTPBArticleHostViewExposure
-  (void)setSubscriptionOnlyArticle:(bool)arg1 {
    return %orig;
}
%end

%hook NTPBArticleHostViewExposure
-  (bool)hasSubscriptionOnlyArticle {
    return %orig;
}
%end

%hook NTPBArticleHostViewExposure
-  (void)setHasSubscriptionOnlyArticle:(bool)arg1 {
    return %orig;
}
%end

%hook NTPBArticleHostViewExposure
-  (bool)subscriptionOnlyArticle {
    return %orig;
}
%end

%hook NTPBArticleHostViewExposure
-  (bool)isSharedSubscriptionOnlyArticle {
    return %orig;
}
%end

%hook NTPBArticleHostViewExposure
-  (void)setIsSharedSubscriptionOnlyArticle:(bool)arg1 {
    return %orig;
}
%end

%hook NTPBArticleHostViewExposure
-  (void)setHasIsSharedSubscriptionOnlyArticle:(bool)arg1 {
    return %orig;
}
%end

%hook NTPBArticleHostViewExposure
-  (bool)hasIsSharedSubscriptionOnlyArticle {
    return %orig;
}
%end

%hook NTPBArticleHostViewExposure
-  (bool)hasFeedSubscriptionOrigin {
    return %orig;
}
%end

%hook NTPBArticleHostViewExposure
-  (void)setHasFeedSubscriptionOrigin:(bool)arg1 {
    return %orig;
}
%end
*/

/*
%hook COMAPPLEFELDSPARPROTOCOLANALYTICSEVENTSArticleHostViewExposure
-  (void)setSubscriptionOnlyArticle:(bool)arg1 {
    return %orig;
}
%end

%hook COMAPPLEFELDSPARPROTOCOLANALYTICSEVENTSArticleHostViewExposure
-  (void)setHasSubscriptionOnlyArticle:(bool)arg1 {
    return %orig;
}
%end

%hook COMAPPLEFELDSPARPROTOCOLANALYTICSEVENTSArticleHostViewExposure
-  (bool)hasSubscriptionOnlyArticle {
    return %orig;
}
%end

%hook COMAPPLEFELDSPARPROTOCOLANALYTICSEVENTSArticleHostViewExposure
-  (void)setIsSharedSubscriptionOnlyArticle:(bool)arg1 {
    return %orig;
}
%end

%hook COMAPPLEFELDSPARPROTOCOLANALYTICSEVENTSArticleHostViewExposure
-  (void)setHasIsSharedSubscriptionOnlyArticle:(bool)arg1 {
    return %orig;
}
%end

%hook COMAPPLEFELDSPARPROTOCOLANALYTICSEVENTSArticleHostViewExposure
-  (bool)hasIsSharedSubscriptionOnlyArticle {
    return %orig;
}
%end

%hook COMAPPLEFELDSPARPROTOCOLANALYTICSEVENTSArticleHostViewExposure
-  (void)setHasFeedSubscriptionOrigin:(bool)arg1 {
    return %orig;
}
%end

%hook COMAPPLEFELDSPARPROTOCOLANALYTICSEVENTSArticleHostViewExposure
-  (bool)hasFeedSubscriptionOrigin {
    return %orig;
}
%end

%hook COMAPPLEFELDSPARPROTOCOLANALYTICSEVENTSArticleHostViewExposure
-  (bool)subscriptionOnlyArticle {
    return %orig;
}
%end

%hook COMAPPLEFELDSPARPROTOCOLANALYTICSEVENTSArticleHostViewExposure
-  (bool)isSharedSubscriptionOnlyArticle {
    return %orig;
}
%end

%hook NTPBPaidSubscriptionSheetView
-  (void)setSubscriptionOnlyArticlePreview:(bool)arg1 {
    return %orig;
}
%end

%hook NTPBPaidSubscriptionSheetView
-  (void)setHasSubscriptionOnlyArticlePreview:(bool)arg1 {
    return %orig;
}
%end

%hook NTPBPaidSubscriptionSheetView
-  (bool)hasSubscriptionOnlyArticlePreview {
    return %orig;
}
%end

%hook NTPBVideoGroupsConfig
-  (void)setHasNowPlayingBarTime:(bool)arg1 {
    return %orig;
}
%end

%hook NTPBVideoGroupsConfig
-  (bool)hasPlaysMutedByDefault {
    return %orig;
}
%end

%hook NTPBVideoGroupsConfig
-  (void)setHasPlaysMutedByDefault:(bool)arg1 {
    return %orig;
}
%end

%hook NTPBVideoGroupsConfig
-  (bool)hasNowPlayingBarTime {
    return %orig;
}
%end

%hook NTPBVideoGroupsConfig
-  (void)setHasUpNextBarTime:(bool)arg1 {
    return %orig;
}
%end

%hook NTPBVideoGroupsConfig
-  (bool)hasUpNextBarTime {
    return %orig;
}
%end
*/

/*
%hook FCNewsVersionAccessChecker
-(bool)hasAccessToItem:(id)arg1 blockedReason:(unsigned long long *)arg2 error:(id *)arg3 {
    return %orig;
}
%end
*/

/*
%hook NTPBWebAccessScreenView
-  (void)setHasSubscriptionOnlyArticlePreview:(bool)arg1 {
    return %orig;
}
%end

%hook NTPBWebAccessScreenView
-  (bool)hasSubscriptionOnlyArticlePreview {
    return %orig;
}
%end

%hook NTPBWebAccessScreenView
-  (bool)subscriptionOnlyArticlePreview {
    return %orig;
}
%end

%hook NTPBAlreadySubscriberSignIn
-  (void)setSubscriptionOnlyArticlePreview:(bool)arg1 {
    return %orig;
}
%end

%hook NTPBAlreadySubscriberSignIn
-  (void)setHasSubscriptionOnlyArticlePreview:(bool)arg1 {
    return %orig;
}
%end

%hook NTPBAlreadySubscriberSignIn
-  (bool)hasSubscriptionOnlyArticlePreview {
    return %orig;
}
%end

%hook NTPBAlreadySubscriberSignIn
-  (bool)subscriptionOnlyArticlePreview {
    return %orig;
}
%end
*/
/*
%hook NTPBAdExposureIneligible
-  (void)setHasExposureIneligibleLocationType:(bool)arg1 {
    return %orig;
}
%end

%hook NTPBAdExposureIneligible
-  (bool)hasExposureIneligibleLocationType {
    return %orig;
}
%end

%hook NTPBAdExposureIneligible
-  (bool)hasExposureIneligibleLocationTypeId {
    return %orig;
}
%end

%hook NTPBAdExposureIneligible
-  (bool)hasExposureIneligibleReason {
    return %orig;
}
%end

%hook NTPBAdExposureIneligible
-  (void)setHasExposureIneligibleReason:(bool)arg1 {
    return %orig;
}
%end

%hook NTPBFeedSubscribeUnsubscribe
-  (bool)hasFeedSubscriptionOrigin {
    return %orig;
}
%end
*/
