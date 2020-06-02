//
//  LineStyleConfig.swift
//  OTPTextfield
//
//  Created by hb on 14/05/20.
//  Copyright © 2020 hb. All rights reserved.
//

import UIKit

class LineStyleConfig: OTPConfig {
    override init() {
        super.init()
        OTPStyle = .line
        ///ideal colors for Line style
        bgColorActiveText = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        bgColorEmptyText = #colorLiteral(red: 0.8078431373, green: 0.8196078431, blue: 0.8352941176, alpha: 1)
        bgColorFilledText = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        bgColorTextField = #colorLiteral(red: 0.8078431373, green: 0.8196078431, blue: 0.8352941176, alpha: 1)
    }
}
