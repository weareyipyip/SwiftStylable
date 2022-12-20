# SwiftStylable

[![CI Status](http://img.shields.io/travis/Marcel Bloemendaal/SwiftStylable.svg?style=flat)](https://travis-ci.org/Marcel Bloemendaal/SwiftStylable)
[![Version](https://img.shields.io/cocoapods/v/SwiftStylable.svg?style=flat)](http://cocoapods.org/pods/SwiftStylable)
[![License](https://img.shields.io/cocoapods/l/SwiftStylable.svg?style=flat)](http://cocoapods.org/pods/SwiftStylable)
[![Platform](https://img.shields.io/cocoapods/p/SwiftStylable.svg?style=flat)](http://cocoapods.org/pods/SwiftStylable)

## Purpose

SwiftStylable is a framework for defining styles in XCode projects using a property list. It contains a set of UIKit component subclasses that have a 'styleName' property. Setting the propery to the name of a style will make the component adapt the style at runtime, as well as in Interface Builder.

## Features
- Define styles in property list
- Named colors in property list
- Extensive list of supported visual properties
- Style inheritance
- Substyle property allows for variations on a main style
- Styles are visible in Interface Builder!
- Change styles at runtime by simply loading a different styles descriptor
- Easily adaptable to support PaintCode images (see below)

## Installation

SwiftStylable is available through [CocoaPods](http://cocoapods.org). To install
it, make sure you have in your Podfile, and simply add the following to your Podfile:

```ruby
use_frameworks!
pod "SwiftStylable"
```
## Requirements
- iOS 9 or higher

## Author

Marcel Bloemendaal, m.bloemendaal@yipyip.nl

## License

SwiftStylable is available under the MIT license. See the LICENSE file for more info.

## How to use

### Styles descriptor

To define your styles you need to create a 'styles.plist' file in your project. This file MUST sit next to your XCode project file for SwiftStylable to work. The file should have the following structure:

- Root
	- colors (Dictionary)
	- dimensions (Dictionary)
	- styles (Dictionary)

### Colors

Colors can be defined as strings in the colors dictionary of your styles descriptor file. You can choose names freely, and set hex strings as values, in the format '#XXXXXX' (fully opaque) or '#XXXXXXXX' (with alpha digits). For example, you can have a color named 'defaultForegroundColor' with a value of '#ffa8bb'.

### Dimensions

Dimensions can be defined as numbers in the dimensions dictionary of your styles descriptor file. You can choose names freely, and set values as whole numbers or decimals. Under the hood they will be parsed as CGFloat. For example, you can have a dimension named 'defaultTextSize' with a value of '15' or you can have a dimension named 'defaultTextLineHeightMultiple' with the value '0,5'.

### Styles

Styles are defined as dictionaries in the styles dictionary of your styles descriptor file. You can choose the names of your styles freely. Child properties of your styles determine the visual properties of your styled components. All properties are optional, and will only be set when actually defined. If a property is not defined, the default of the component will be used. Supported properties are:

- parent (string, name of another style)
- foregroundColor (string)
- highlightedForegroundColor (string)
- selectedForegroundColor (string)
- disabledForegroundColor (string)
- backgroundColor (string)
- highlightedBackgroundColor (string)
- selectedBackgroundColor (string)
- disabledBackgroundColor (string)
- borderColor (string)
- highlightedBorderColor (string)
- selectedBorderColorName (string)
- disabledBorderColor (string)
- borderWidth (number)
- borderStyle (string: "none", "line", "bezel" or "roundedRect")
- cornerRadius (number)
- clipsToBounds (boolean)
- tintImageWithForegroundColor (boolean)
- tableViewSeparatorStyle (string: "none", "singleLine", "singleLineEtched")
- tableViewSeparatorColor (string)
- spacing (number or string, name of a dimensions)
- font (dictionary)
	- name (string, PostScript name of the font
	- size (number or string, name of a dimensions)
	- textStyle (string: "largeTitle", "title1", "title2", "title3", "headline", "subheadline", "body", "callout", "footnote", "caption1", "caption2", "none")
	- textStyleMaximumSize (number or string, name of a dimensions)
    - accessibilityBoldName (string)
- fullUppercaseText (boolean)
- styledTextAttributes (dictionary --> see 'Styled text' below)
	- foregroundColor (string)
	- font (dictionary)
		- name (string)
		- size (number or string, name of a dimensions)
		- textStyle (string: "largeTitle", "title1", "title2", "title3", "headline", "subheadline", "body", "callout", "footnote", "caption1", "caption2", "none")
		- textStyleMaximumSize (number or string, name of a dimensions)
        - accessibilityBoldName (string)      
	- lineSpacing (number or string, name of a dimensions)
	- lineHeightMultiple (number or string, name of a dimensions)
	- kern (number or string, name of a dimensions)
	- underlineStyle (string: "byWord", "patternDash", "patternDashDot", "patternDashDotDot", "patternDot", "double", "single", "thick" or "none")
	- underlineColor (string)
    - strikethroughStyle (string: "single", "thick", "double" or "none")
    - strikethroughColor (string)   
	- alignment (string: "left", "right", "center", "justified" or "natural")
        - lineBreakMode (string: "byTruncatingTail", "byTruncatingMiddle", "byTruncatingHead", "byClipping", "byCharWrapping", "byWordWrapping")
- styledPlaceholderAttributes (dictionary, same as 'styledTextAttributes')
- imagePadding (number or string, name of a dimensions) (available since iOS15)

#### Colors
All color properties should reference a named color from the colors section of the styles descriptor. For most colors there are 3 varieties besided the normal one: highlighted, selected and disabled. Most components do not use these varieties. They are mainly meant to define button states.

#### The tintImageWithForegroundColor property
This property is meant for images and buttons. When this property is set to true, the image will be tinted with the foregroundColor. When used in buttons, the image will also adopt the various colors set for highlighted, selected or disabled states.

#### Buttons
When styling buttons, keep in mind that you have to set the type of your button to 'custom' when your button is created in Interface Builder. You also have to disable the 'Highlighted Ajusts Image' and 'Disabled Adjusts Image', unless this is the behaviour you desire.
Since iOS15, the `UIButton.Configuration` is available. As of iOS15, SwiftStylable also uses this configuration. So if you want to overwrite certain functionalities, use the configuration in the button.

#### Fonts
Fonts contain a name, a size, an optional text style and an optiona maximum size for the given text style. The name is the PostScript name of the desired font. To support custom fonts, the fonts will still have to be added to the project as normal, and set properly in the info.plist of your project under 'Fonts provided by application'.
Instead of specifying a postScriptName, you can also use the system font by using predefined strings. The available strings for system fonts are:

- "systemFont"
- "boldSystemFont"
- "italicSystemFont"
- "thinSystemFont"
- "blackSystemFont"
- "heavySystemFont"
- "lightSystemFont"
- "mediumSystemFont"
- "semiboldSystemFont"
- "ultraLightSystemFont"

##### Accessibility
If you want to use the accessibility settings, the text scaling and the bold text options are currently supported. The text scaling can be turned on by giving your font a `textStyle`. If this property is set, the text will be automatically scalled. Use the `textStyleMaximumSize` property to set a maximum font size. If the text style "none" is set or the `textStyle` will be left empty the text scaling will be turned off.
To support the bold text accessibility setting, the `accessibilityBoldName` property should be set. This is the postScriptName of the (bold) font to be used. 

#### Styled text
The STLabel and the STTextView both support 'styled text'. This is basically attributedText, set with the attributes specified for this in a style. A normal Label / TextView has a 'text' property and an 'attributedText' property. The corresponding STComponents have an additional 'styledText' property (also available in the Interface Builder inspector). If you use this property for setting the component's text, the 'styledTextAttributes' from the selected style will automatically be applied. Setting the styledText will create the attributedText for you, this then becomes available through the attributedText property. The styledText property itself will contain the string you set it to, until you set any of the other text properties (text / attributedText), then it will be nilled. See the 'styledTextAttributes' property in the 'Styles' section of this document for a list of supported text attributes.


#### Style inheritance

If you want to define a style that is much like a previously defined style, you can use this previous style as a parent. This way you only have to set the properties that are different from the parent style, in the new style you are creating. The other properties will simply be inherited from the parent style. To set a parent syle, just add a 'parent' property to your style definition, with the name of the desired parent style as the value.

#### Substyles

Every style component has a styleName property and a substyleName property. Substyles can be used to apply a set of overrides to a style. Suppose you have a large number of styles, but in certain sections of your app you want to apply a theme that overrides the foreground color of some styles. (and may be some other properties) You could make new styles that have your normal styles as parents and override their foreground colors, but you would have to override all your styles, for all your possible themes. You can also define styles for all of your themes in which you only override the foreground color (and any other properties that have to change for your theme). You than apply a theme style as substyle for any component that should have this theme and there you go: your theme look is applied.

## Using styles in your project

To use your defined styles in a component in Interface Builder, change the class of the component to the SwiftStylable version of the component. (For example: to style a UIButton, you change its class to 'STButton') Make sure the Module field (underneith the Class field) is then set to 'SwiftStylable'. This usually happens automatically. The component should now have a 'styleName' and a 'substyleName' property. To apply the desired style to your component, you now simply set the 'styleName' property of the component to the name of the style. You may have to refresh the views in your Storyboard for styles to take effect. (With Interface Builder in focus, select Editor->Refresh all views.)

### Stylable components

The following components are currently available:

- STView
- STLabel
- STTextField
- STTextView
- STButton
- STImageView
- STActivityIndicator
- STSwitch
- STTableView
- STTableViewCell
- STHorizontalHairline
- STStackView

### Dimension components

The following components are currently available:

- STLayoutConstraint

## PaintCode support

If you like to use PaintCode images in your projects, you can easily add support for them. To add support for PaintCode images in Buttons and Images, add the 'PaintCodeHelper.swift', 'PCImage.swift' and 'PCImage.swift' files from the Example Project to your own project. Then change the imageNamed(_ name:String)->UIImage function in the PaintCodeHelper class to return the images in your own StyleKit for their appropriate names. This should be pretty straight forward.

When you want to use images from your StyleKit in your project, be sure to use PCImage or PCButton as custom class for your image / button component, instead of the normal STImage or STButton. In these components you can set imageName.


## Example

An example project is available at: https://github.com/weareyipyip/SwiftStylableExample

## Trouble shooting

When a component doesn't look the way you expected, check if the following things are in order:

- Does the component have the appropriate 'ST...' custom class set in Interface Builder?
- Has the Module for the custom class of the component been set to SwiftStylable? (Be careful: when using PCImage or Button from your own project, or a ST[Component] subclass from your own project, the module should be set to your own app's module.)
- Is the styles.plist file at the appropriate location? It should sit next to the XCode project file for SwiftStylable to be able to find it. (You may make a reference to it from a group in XCode, as long as the actual file is at this location.)
- Did you check the spelling and casing of your style name and any properties of your style? Has it also been spelled correctly in the 'styleName' property of your component?
- Are the value types of all properties in your style set to the correct types? A common mistake is to have (for example) the size property of a font set as a string, while it should be a number. It won't work when it is a string.



