NBThemeConfig
=============

Configure all the colors for your app in a single plist

Demo
====

The demo/ folder contains a demo project showing NBThemeConfig in use.
Open and run it.

Usage
=====

First, set up the colors, gradients, and patterns you want to use in
a file named theme.plist:

![colors](https://github.com/needbee/nbthemeconfig/blob/master/colors.png)

Then, set up named components referring to different elements in your
app, and designate which color, gradient, or pattern it should get:

![components](https://github.com/needbee/nbthemeconfig/blob/master/components.png)

Then, instead of hard-coding colors in the .storyboard or in your code,
use NBThemeConfig's methods to get the colors within your code,
referring to them by component name:

	self.label.textColor
		= [NBThemeConfig colorForComponent:@"mainContentText"];
	self.contentView.backgroundColor
		= [NBThemeConfig colorForComponent:@"mainContentBackground"];

Gradients are a bit more complex: set up a CAGradientLayer, then pass it
into:

	[NBThemeConfig setGradient:myGradientLayer
        byComponentName:@"mainBackground"];


Compatibility
=============

This class has been tested back to iOS 6.0.

Implementation
==============

This class is implemented by loading color and pattern values from the
config file, caching them in class variables, and generating UIColors
from them using:

	[UIColor colorWithRed:… green:… blue:… alpha:…];
	[UIColor colorWithPatternImage:…];

License
=======

This code is released under the MIT License. See the LICENSE file for
details.