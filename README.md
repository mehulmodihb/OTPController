# OTPController

OTPController is basically made for integrating One time password view. 
There are two styles: **Line** and **Box**. 

 ![Box Style](https://i.imgur.com/GvLFL2E.png)  ![Line Style](https://i.imgur.com/rL9FgOA.png)

## Getting Started

### Prerequisites

1. Minimum deployment target: iOS 10
2. Orientation: Portrait Only
3. Supported Language: English

### Dependency

* [UICircularProgressRing](https://github.com/luispadron/UICircularProgressRing) - For showing circular progress.

### Installation

Copy ```OTPController``` directory in your project

## Box Style OTPController Implementation

```swift
let vc = VerifyOTPViewController.instance()!
let config = BoxStyleConfig()
```

#### • Present OTPController

```swift
vc.presentWith(config:config, to: self) { (otp) in
    print(otp)
    vc.dismiss(animated: true, completion: nil)
}
```

#### • Navigate to OTPController

```swift
vc.pushWith(config:config, to: self) { (otp) in
    print(otp)
    vc.dismiss(animated: true, completion: nil)
}
```

## Line Style OTPController Implementation

```swift
let vc = VerifyOTPViewController.instance()!
let config = LineStyleConfig()
```

#### • Present OTPController

```swift
vc.presentWith(config:config, to: self) { (otp) in
    print(otp)
    vc.dismiss(animated: true, completion: nil)
}
```

#### • Navigate to OTPController

```swift
vc.pushWith(config:config, to: self) { (otp) in
    print(otp)
    vc.dismiss(animated: true, completion: nil)
}
```
# Style Configuration

Config class has following properties where you can customize the look and feel of control.

```swift
var titleText = "Please enter OTP to verify your Mobile Number"
var descText = "9812345678"
var fontLblTitle: UIFont = .systemFont(ofSize: 14.0)
var fontLblDesc: UIFont = .boldSystemFont(ofSize: 18.0)
var fontBtnResendOTP: UIFont = .boldSystemFont(ofSize: 12.0)
var fontBtnConfirm: UIFont = .systemFont(ofSize: 14.0)
var fontLblProgress: UIFont = .boldSystemFont(ofSize: 12)
var textColorLblTitle: UIColor =  colorLiteral(red: 0.3333333333, green: 0.3333333333, blue: 0.3333333333, alpha: 1)
var textColorLblDesc: UIColor =  colorLiteral(red: 0.3333333333, green: 0.3333333333, blue: 0.3333333333, alpha: 1)
var textColorBtnResendOTP: UIColor =  colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
var textColorBtnConfirm: UIColor =  colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
var bgColorBtnConfirm: UIColor =  colorLiteral(red: 0.8078431373, green: 0.8196078431, blue: 0.8352941176, alpha: 1)
var textColorLblProgress: UIColor =  colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
var colorOuterProgress: UIColor =  colorLiteral(red: 0.8078431373, green: 0.8196078431, blue: 0.8352941176, alpha: 1)
var colorInnerProgress: UIColor =  colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
var fontVwOTP: UIFont = UIFont(name: "Noteworthy-light", size: 20.0) ?? UIFont.systemFont(ofSize: 20.0)
var textColorVwOTP: UIColor =  colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
var bgColorActiveText: UIColor =  colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
var bgColorEmptyText: UIColor =  colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
var bgColorFilledText: UIColor =  colorLiteral(red: 0.8078431373, green: 0.8196078431, blue: 0.8352941176, alpha: 1)
var bgColorTextField: UIColor =  colorLiteral(red: 0.8078431373, green: 0.8196078431, blue: 0.8352941176, alpha: 1)
var timerInterval: TimeInterval = 60
var pinLength: Int = 4  // Lenght should be between 4 to 10
```
  
# License

```
Copyright 2020

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and

limitations under the License.
```
