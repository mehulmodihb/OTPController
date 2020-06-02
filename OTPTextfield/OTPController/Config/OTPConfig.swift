//
//  OTPConfig.swift
//  OTPTextfield
//
//  Created by hb on 14/05/20.
//  Copyright © 2020 hb. All rights reserved.
//

import UIKit

class OTPConfig: NSObject {
    var titleText = "Please enter OTP to verify your Mobile Number"
    var descText = "9812345678"
    
    var fontLblTitle: UIFont = .systemFont(ofSize: 14.0)
    var fontLblDesc: UIFont = .boldSystemFont(ofSize: 18.0)
    
    var fontBtnResendOTP: UIFont = .boldSystemFont(ofSize: 12.0)
    var fontBtnConfirm: UIFont = .systemFont(ofSize: 14.0)
    var fontLblProgress: UIFont = .boldSystemFont(ofSize: 12)
    
    var textColorLblTitle: UIColor = #colorLiteral(red: 0.3333333333, green: 0.3333333333, blue: 0.3333333333, alpha: 1)
    var textColorLblDesc: UIColor = #colorLiteral(red: 0.3333333333, green: 0.3333333333, blue: 0.3333333333, alpha: 1)
    var textColorBtnResendOTP: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    var textColorBtnConfirm: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    var bgColorBtnConfirm: UIColor = #colorLiteral(red: 0.8078431373, green: 0.8196078431, blue: 0.8352941176, alpha: 1)
    var textColorLblProgress: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    var colorOuterProgress: UIColor = #colorLiteral(red: 0.8078431373, green: 0.8196078431, blue: 0.8352941176, alpha: 1)
    var colorInnerProgress: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    var fontVwOTP: UIFont = UIFont(name: "Noteworthy-light", size: 20.0) ?? UIFont.systemFont(ofSize: 20.0)
    var textColorVwOTP: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    var bgColorActiveText: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    var bgColorEmptyText: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    var bgColorFilledText: UIColor = #colorLiteral(red: 0.8078431373, green: 0.8196078431, blue: 0.8352941176, alpha: 1)
    var bgColorTextField: UIColor = #colorLiteral(red: 0.8078431373, green: 0.8196078431, blue: 0.8352941176, alpha: 1)
    var OTPStyle: style = .box
    var timerInterval: TimeInterval = 60
    var pinLength: Int = 4 // Lenght should be between 4 to 10
}
