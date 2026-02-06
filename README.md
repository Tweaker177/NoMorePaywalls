# NoMorePaywalls
A tweak that removes financial barriers and allows all Apple News+ for free.
It works on all jailbroken iOS versions that Apple News works on, from iOS 10-18+ 

Only tested up through iOS 17, due to the lack of jailbreaks.  :/

To Build For Rootless:

1.) change "rootful" to "rootless" in Makefile
Export THEOS_PACKAGE_SCHEME=rootless 
2.) add "-arm64" to the control file where it says "iphoneos"
so it should say "iphoneos-arm64"
3.) You can now run "make package" and it should build if Theos is configured correctly.
