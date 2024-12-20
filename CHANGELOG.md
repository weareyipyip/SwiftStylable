# Changelog

Significant changes to the project will be documented here.

## [2.2.0](https://github.com/weareyipyip/SwiftStylable/releases/tag/2.2.0)

- Update deployment target to iOS 12
- Fix deprecation warnings

## [2.1.4](https://github.com/weareyipyip/SwiftStylable/releases/tag/2.1.4)

- Fix the background color of the STButton on iOS 15+

## [2.1.3](https://github.com/weareyipyip/SwiftStylable/releases/tag/2.1.3)

- Fix the image foreground color of the STButton on iOS 15+

## [2.1.2](https://github.com/weareyipyip/SwiftStylable/releases/tag/2.1.2)

- Fix the spacing property of the STStackView

## [2.1.1](https://github.com/weareyipyip/SwiftStylable/releases/tag/2.1.1)

- Added dynamicFont property to TextStyle.
- Made dynamic font properties accessible outside of SwiftStylable

## [2.1.0](https://github.com/weareyipyip/SwiftStylable/releases/tag/2.1.0)

- Added support for the "Bold text" accessibility setting.

## [2.0.0](https://github.com/weareyipyip/SwiftStylable/releases/tag/2.0.0)

- Added support for dynamic font types
- Added support for UIButton.Configuration on iOS 15+

## [1.8.0](https://github.com/weareyipyip/SwiftStylable/releases/tag/1.8.0)

- Added support for strikethrough (Style and Color) in the styledTextAttributes

## [1.7.2](https://github.com/weareyipyip/SwiftStylable/releases/tag/1.7.2)

- Resolved deprecation warnings

## [1.7.0](https://github.com/weareyipyip/SwiftStylable/releases/tag/1.7.0)

- Fix access level of STHorizontalHairline

## [1.7.0](https://github.com/weareyipyip/SwiftStylable/releases/tag/1.7.0)

- Added lineBreakMode as propery for the styledTextAttributes dictionary

## [1.6.5](https://github.com/weareyipyip/SwiftStylable/releases/tag/1.6.5)

- Fix a class a bug for setting the font of the STTextView 

## [1.6.4](https://github.com/weareyipyip/SwiftStylable/releases/tag/1.6.4)

- Fix a class collision with UISwitch.Style on iOS 14

## [1.6.1](https://github.com/weareyipyip/SwiftStylable/releases/tag/1.6.1)

- Removed warning if the parent style element well be overwritten and it already exists.

## [1.6.1](https://github.com/weareyipyip/SwiftStylable/releases/tag/1.6.1)

- Resolved deprecation warning

## [1.6.0](https://github.com/weareyipyip/SwiftStylable/releases/tag/1.6.0)

- Added STStackView
- Fixed a bug in overriding dimensions and colors

## [1.5.2](https://github.com/weareyipyip/SwiftStylable/releases/tag/1.5.2)

- Added SwiftPackage support

## [1.5.1](https://github.com/weareyipyip/SwiftStylable/releases/tag/1.5.1)

- Fixed a typo. Changed IBDesignable name from dimenstion to dimension for the STLayoutConstraint

## [1.5.0](https://github.com/weareyipyip/SwiftStylable/releases/tag/1.5.0)

- You can now use variable dimension in your styles. You can add a dimensions dictionary to your styles.plist and use it for all the current "number" values. We also added the STLayoutContraint to set the constant from your xib or storyboard.

## [1.4.5](https://github.com/weareyipyip/SwiftStylable/releases/tag/1.4.5)

- Fixed incorrect selectedForegroundColor in ForegroundStylable

## [1.4.4](https://github.com/weareyipyip/SwiftStylable/releases/tag/1.4.4)

- More fixes in color inheritance of foreground and background colors
- Fixed STTableViewCell not doing color mangement right at all

## [1.4.3](https://github.com/weareyipyip/SwiftStylable/releases/tag/1.4.3)

- Corrected font inheritance, fonts would previously not be inherited form ancestors more than 1 generation away

## [1.4.2](https://github.com/weareyipyip/SwiftStylable/releases/tag/1.4.2)

- Corrected the behaviour of styledTextAttributes so the attribute dictionaries always merge with ther parents

## [1.4.1](https://github.com/weareyipyip/SwiftStylable/releases/tag/1.4.1)

- Fixed an issue causing fonts to sometimes be parsed incorrectly
- Fixed STImage initializer

## [1.4.0](https://github.com/weareyipyip/SwiftStylable/releases/tag/1.4.0)

- Refactor of Style class into subcomponents
- Changes some scopes from open to public (result of Swift 4.2 not allowing open anymore in some cases)
- Added styledPlaceholder and fullUppercasePlaceholder to STTextField
- Added styledPlaceholderAttributes to style attributes
- Added alignment to styledTextAttributes
- Fixed issues in STTextField
- Removed fullUppercaseText from STTextField en STTextView as it needed a technically undesirable implementation

## [1.3.2](https://github.com/weareyipyip/SwiftStylable/releases/tag/1.3.2)

- Fixed .swift-version file for cocoapods

## [1.3.1](https://github.com/weareyipyip/SwiftStylable/releases/tag/1.3.1)

- Migrated to Swift 4.2

## [1.3.0](https://github.com/weareyipyip/SwiftStylable/releases/tag/1.3.0)

- Improved error warnings in logs
- Fixed some missing style properties in STTextField
- STTextField now has a styledPlaceholder property that works similar to STLabels styledText property
- styles descriptor now has an additional styledPlaceholderAttributes field to support STTextField's styledPlaceholder

## [1.2.0](https://github.com/weareyipyip/SwiftStylable/releases/tag/1.2.0)

- You can now define a color with a color name instead of a hex value, as long as you define a color for this name elsewhere in the colors dictionary

## [1.1.4](https://github.com/weareyipyip/SwiftStylable/releases/tag/1.1.4)

- Fixed another issue causing the borderColor not to work correctly on some components
- Fixed an issue causing text properties to fail on STButtons

## [1.1.3](https://github.com/weareyipyip/SwiftStylable/releases/tag/1.1.3)

- Fixed an issue causing the borderColor not to work correctly on some components

## [1.1.2](https://github.com/weareyipyip/SwiftStylable/releases/tag/1.1.2)

- Added support for lineHeightMultiple to styledTextAttributes
- Fixed access modifiers for styledText properties of STLabel and STTextView

## [1.1.1](https://github.com/weareyipyip/SwiftStylable/releases/tag/1.1.1)

- Added a (this) changelog
- Renamed the styledText property of a style to styledTextAttributes
- Added styledText support to STTextView

## [1.1.0](https://github.com/weareyipyip/SwiftStylable/releases/tag/1.1.0)

- Refactored STComponents to a more component bases architecture, to avoid duplicate code
- Moved the example project to the actual example project of the pod
- Style descriptions now support hex colors as well as color names
- Added support for styledText to STLabel

## [1.0.5](https://github.com/weareyipyip/SwiftStylable/releases/tag/1.0.5)

- Fixed access modifiers of customItemPlacement attributes in ExtendedButton

## [1.0.4](https://github.com/weareyipyip/SwiftStylable/releases/tag/1.0.4)

- Implemented custom item placement in ExtendedButton

## [1.0.3](https://github.com/weareyipyip/SwiftStylable/releases/tag/1.0.3)

- Replaced some deprecated methods and principles
- Added processStyleDataWithFileAtPath method to Styles class

## [1.0.2](https://github.com/weareyipyip/SwiftStylable/releases/tag/1.0.2)

- Fixed an issue causing the loading of a different styles file than 'styles.plist' to always fail
- Added a Swift version file for cocoapods

## [1.0.1](https://github.com/weareyipyip/SwiftStylable/releases/tag/1.0.1)

- Converted to Swift 4

## [1.0.0](https://github.com/weareyipyip/SwiftStylable/releases/tag/1.0.0)

- Initial release
