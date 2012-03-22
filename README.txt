Purpose
--------------

iAdPlus is a simple library that allows you to ad iAds to your applications with the smallest amount of effort.  You simply need to include the library files in your project and make sure that any view controllers that you would like to include iAds inherit from the AdViewController class.  In order for the class to work fully, you should place your content inside the contentView view of the class however.  Doing this will allow the class to dynamically resize the main content view to accommodate the iAd when it is served.  You should therefore make sure that any content that you put in the contentView view is either in a scrollview or some other appropriate container so that content is not hidden under the iAd.

Currently this project uses arc.  I can commit or create a non arc version if required.


Installation
--------------

To install iAdPlus into your app, drag the following files into your project:
 - AdViewController.h and .m
 - AdBannerController.h and .m

Make sure that you include the iAd.framework in your project also.

Then simply inherit a UIViewController from the AdViewContoller class instead of directly from UIViewController.

You will also need to configure iAds in iTunes Connect before you submit your app to Apple.  Please go here for more information: 
https://developer.apple.com/appstore/resources/iad/index.html
https://developer.apple.com/appstore/resources/iad/index.html#prepare

You will need to be logged in to iTunesConnect view these documents.