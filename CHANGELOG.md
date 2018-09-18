# Changelog

Significant changes to the project will be documented here.

## [1.3.2](https://github.com/weareyipyip/SwiftStylable/releases/tag/1.2.0)

- Fixed .swift-version file for cocoapods

## [1.3.1](https://github.com/weareyipyip/SwiftStylable/releases/tag/1.2.0)

- Migrated to Swift 4.2

## [1.3.0](https://github.com/weareyipyip/SwiftStylable/releases/tag/1.2.0)

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
