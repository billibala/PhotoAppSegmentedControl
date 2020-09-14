# PhotoAppSegmentedControl

Apple's Photos app has a custom segmented control which always appears at the bottom of the screen when user is in "Photos" tab.

This is an attempt to recreate that. (not very successful but good enough in some sense)

Apple's custome bar is in "capsule pill" style. This is different from UISegmentedControl which is a round rect.

This implementation does have its merits. You don't need to incorporate any 3rd-party library. You also get all the new behavior a UISeglementedControl get in iOS 13. (All those interaction details... for example: tapping a segment will get a bounce highlight, swiping on top of the segment to change selection...)

If you are ok with the system look-and-feel, this implementation is not a bad choice IMO.

If you really need the capsule pill style, there's a great article on [Flawless iOS - iOS 13 UISegmentedControl: 3 important changes](https://medium.com/flawless-app-stories/ios-13-uisegmentedcontrol-3-important-changes-d3a94fdd6763) which has sample code customizing layer drawing behavior by subclassing UISeglementedControl. (Look for "SquareSegmentedControl" in the article)

Give it a try. If you find this example helpful, feel free to give a star or leave comment.
