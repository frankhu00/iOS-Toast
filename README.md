# iOS-Toast
A simple and lightweight replication of Android's Toast for iOS. <br/>
Built with Swift3

## Installation
Just drag and drop [Toast.swift](https://github.com/frankhu00/iOS-Toast/blob/master/Toast.swift) into your project and you are ready to use it!

## Sample Usage

```swift
let msg = "Toast a message! Toast a paragraph or a short message."

// Ex 1 - General Usage
view.addSubview(Toast.alert(message: msg))


// Ex 2 - Configure Styles
let style = ToastStyle()
style.textColor = UIColor.black
style.backColor = UIColor.white
style.borderColor = UIColor.darkGray
style.borderWidth = 3
style.fontSize = 25
style.padding = 25
style.cornerRadius = 15
style.centerAt = .bottom
style.maxWidth = 300
view.addSubview(Toast.alert(message: msg, style: style))


// Ex 3 - Configure Toast Active Duration and Animation Speed
let style = ToastStyle()
style.centerAt = .positionAt(CGPoint(x: 200, y: 110))
view.addSubview(Toast.alert(message: msg, duration: 2.0, speed: 0.5, style: style))


// Ex 4 - Removing All Toasts
Toast.removeAllToasts()


// Ex 5 - Runs Handler After Toast Expires
Toast.isActive() {
  print("Run completion block")
}
```

## Toast
Main class that generates toast objects
+ **_Toast.alert(message:, duration:, speed:, style:)_**
⋅⋅* Static method that creates a toast object
⋅⋅* Duration, speed, and style arguments are optional
+ **_Toast.removeAllToasts()_**
⋅⋅* Static method that forcefully removes all toast objects
+ **_Toast.isActive(delay:, completion:)_**
⋅⋅* Static method that runs completion block once all toast objects expire
⋅⋅* Delay is optional and signifies the time interval between each check
<br>
<br>

-------

<br>
## ToastStyle
Supplementary class that instructs Toast class on toast style specifications <br>
Below is a list of styling specifications:
+ **_textColor_**
+ **_backColor_**
+ **_borderColor_**
+ **_borderWidth_**
+ **_fontSize_**
+ **_cornerRadius_**
+ **_padding_**
+ **_centerAt : ToastPosition_**
+ **_maxWidth_**
+ **_numberOfLines_**
+ **_lineBreakMode_**
<br>

### enum ToastPosition
This is used to define the position at which the toast will appear <br>
There are four cases:
+ **_top_** : Defines toast position to be horizontally centered with a spacing of 20 from the top
+ **_center_** : Defines the position to be both horizontally and vertically centered
+ **_bottom_** : Defines the position to be horizontally centered with a spacing of 20 from the bottom
+ **_positionAt(CGPoint)_** : Pins the **center** of the toast onto the point defined

