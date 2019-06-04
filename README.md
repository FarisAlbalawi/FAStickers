# FAStickers

[![CI Status](https://img.shields.io/travis/farisalbalawi/FAStickers.svg?style=flat)](https://travis-ci.org/farisalbalawi/FAStickers)
[![Version](https://img.shields.io/cocoapods/v/FAStickers.svg?style=flat)](https://cocoapods.org/pods/FAStickers)
[![License](https://img.shields.io/cocoapods/l/FAStickers.svg?style=flat)](https://cocoapods.org/pods/FAStickers)
[![Platform](https://img.shields.io/cocoapods/p/FAStickers.svg?style=flat)](https://cocoapods.org/pods/FAStickers)

![ColorfulTornJunco-small](https://user-images.githubusercontent.com/18473439/58902641-7faf6a00-86d1-11e9-9e9c-2535af524384.gif)



## Features 

- Supports Stickers
- Supports Emojis
- Supports Gifs
- Swift 5



## Requirements

- iOS 11.0 and later
- swift 5

## Installation

FAStickers is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'FAStickers'
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

```swift
import FAStickers
import UIKit
class ViewController: UIViewController{

var StickerVC: StickerViewController!
public var stickers : [String] = []
public var gifs : [String] = []
}


override func viewDidLoad() {
super.viewDidLoad()

// append stickers
for i in 100...110 {
stickers.append(i.description)
}


let gifImage = ["gif1","gif2","gif3","gif4", "gif5","gif6","gif7","gif8", "gif9"]
// append gitf
for i in gifImage {
gifs.append(i)
}

StickerVC = StickerViewController(nibName: nil, bundle: Bundle(for: StickerViewController.self))


}

@IBAction func AddSticker(_ sender: Any) {
showStickerView()
}



}


extension ViewController: StickerEmojiDelegate {


func GitTapped(GifName: String) {
print(GifName)
let Gif = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
Gif.loadGif(name: GifName)
Gif.contentMode = .scaleAspectFit
Gif.center = view.center
self.view.addSubview(Gif)

self.removeStickerView()
}


func EmojiTapped(EmojiName: String) {
print(EmojiName)
var emojiView = UIView()
let emojiLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
emojiLabel.text = EmojiName
emojiLabel.font = UIFont.systemFont(ofSize: 50)
emojiView = emojiLabel
emojiView.center = view.center
self.view.addSubview(emojiView)
self.removeStickerView()
}

func StickerTapped(StickerName: String) {
print(StickerName)
let Sticker = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
Sticker.image = UIImage(named: StickerName)
Sticker.contentMode = .scaleAspectFit
Sticker.center = view.center
self.view.addSubview(Sticker)

self.removeStickerView()
}



func showStickerView() {

StickerVC.stickerDelegate = self


// append gifs
for gifImage in self.gifs {
StickerVC.gits.append(gifImage)
}

// append stickers
for stickersImage in self.stickers {
StickerVC.stickers.append(stickersImage)
}

self.addChild(StickerVC)
self.view.addSubview(StickerVC.view)
StickerVC.didMove(toParent: self)
let height = view.frame.height
let width  = view.frame.width
StickerVC.view.frame = CGRect(x: 0, y: self.view.frame.maxY , width: width, height: height)
}

func removeStickerView() {
UIView.animate(withDuration: 0.3,
delay: 0,
options: UIView.AnimationOptions.curveEaseIn,
animations: { () -> Void in
var frame = self.StickerVC.view.frame
frame.origin.y = UIScreen.main.bounds.maxY
self.StickerVC.view.frame = frame

}, completion: { (finished) -> Void in
self.StickerVC.view.removeFromSuperview()
self.StickerVC.removeFromParent()
})
}

}
```

## Delegate:

```ruby
StickerEmojiDelegate
```

```swift
func EmojiTapped(EmojiName: String)
func StickerTapped(StickerName: String)
func GitTapped(GifName: String)
```

## Author

Faris Albalawi,
developer.faris@gmail.com

## License

FAStickers is available under the MIT license. See the LICENSE file for more info.

