# NSLayoutManagerBug
There is a bug in the way how NSLayoutManager layout and render texts in a view context.


### Quick Start

Open the project `BlockTest.xcodeproj` from Xcode and run the app. Verify that some fonts are layouted with the bottom cutoff, especially the `HelveticaNeue`.

See the following screenshot for the cutoff:
![cutoff-1](https://github.com/lorixx/NSLayoutManagerBug/blob/master/common/images/iOS%20Simulator%20Screen%20Shot%20Sep%206,%202015,%2012.09.45%20AM.png?raw=true)

![cutoff-2](https://github.com/lorixx/NSLayoutManagerBug/blob/master/common/images/iOS%20Simulator%20Screen%20Shot%20Sep%206,%202015,%2012.09.47%20AM.png?raw=true)
