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

```ruby
pod 'ShadowRadar'
```

The submodule `Rx` is prepared for using this library with the RxSwift extension.

```ruby
pod 'ShadowRadar/Rx'
```

The following codes shows a demo to create a radar chart with titles.

```Swift
import ShapeView
import ShadowRadar

let chart = ShadowTitleRadarChart()
chart.maxLevel = 4
chart.innerShadow = ShapeShadow(raduis: 5, color: .white, opacity: 0.5)
chart.outerShadow = ShapeShadow(raduis: 5, color: .white, opacity: 0.5)
chart.radarColor = .clear
chart.addRadar(Radar(levels: [3, 2, 3, 4, 3, 1], color: UIColor(white: 1, alpha: 0.75)))
chart.addRadar(Radar(levels: [3, 4, 3, 3, 3, 2], color: UIColor(white: 0.5, alpha: 0.75)))
chart.titles = ["Alice", "Bob", "Carol", "Dave", "Eve", "Frank"].shuffled()
chart.titleFont = UIFont.systemFont(ofSize: 20, weight: .bold)
chart.titleColor = .white
chart.titleMargin = 10
chart.titleAlignment = .leftRight
```

#### RxSwift

`maxLevel`, `innerShadow`, `outerShadow`, `radarColor`, `radar(at: Int)` and `titles` can be updated with the RxSwift extension.

```Swift
viewModel.maxLevel.bind(to: chart.rx.maxLevel).disposed(by: disposeBag)
viewModel.radar.bind(to: chart.rx.radar(at: 1)).disposed(by: disposeBag)
viewModel.titles.bind(to: chart.rx.titles).disposed(by: disposeBag)
viewModel.innerShadow.bind(to: chart.rx.innerShadow).disposed(by: disposeBag)
viewModel.outerShadow.bind(to: chart.rx.outerShadow).disposed(by: disposeBag)
viewModel.radarColor.bind(to: chart.rx.radarColor).disposed(by: disposeBag)
```

## License

ShadowRadar is available under the MIT license. See the LICENSE file for more info.
