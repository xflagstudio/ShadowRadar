# ShadowRadar

[![CI Status](https://img.shields.io/travis/lm2343635/ShadowRadar.svg?style=flat)](https://travis-ci.org/lm2343635/ShadowRadar)
[![Version](https://img.shields.io/cocoapods/v/ShadowRadar.svg?style=flat)](https://cocoapods.org/pods/ShadowRadar)
[![License](https://img.shields.io/cocoapods/l/ShadowRadar.svg?style=flat)](https://cocoapods.org/pods/ShadowRadar)
[![Platform](https://img.shields.io/cocoapods/p/ShadowRadar.svg?style=flat)](https://cocoapods.org/pods/ShadowRadar)

ShadowRadar is a radar chart view with shadow.

![Demo](https://raw.githubusercontent.com/xflagstudio/ShadowRadar/master/screenshoots/demo.png)

In this demo, we use `ShadowRadar` to create a radar chart without titles and another one with titles.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

ShadowRadar is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

- Using without titles.

```ruby
pod 'ShadowRadar'
```

- Using with titles.

```ruby
pod 'ShadowRadar/Title'
```

The following codes shows a demo to create a radar chart with titles.

```Swift
let radar = ShadowTitleRadar()
radar.maxLevel = 4
radar.addRadar(levels: [3, 2, 3, 4, 3, 1], color: UIColor(white: 1, alpha: 0.75))
radar.addRadar(levels: [3, 4, 3, 3, 3, 2], color: UIColor(white: 0.5, alpha: 0.75))
radar.titles = ["Title1", "Title2", "Title3", "Title4", "Title5", "Title6"]
radar.titleFont = UIFont.systemFont(ofSize: 20, weight: .bold)
radar.titleColor = .white
radar.titleMargin = 5
```

## License

ShadowRadar is available under the MIT license. See the LICENSE file for more info.
