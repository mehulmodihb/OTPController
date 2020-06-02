//
//  Constant.swift
//
//  Created by Binal Shah on 06/09/19.
//  Copyright © 2019 Hidden Brains. All rights reserved.
//

import Foundation
import UIKit

let APP_DELEGATE = UIApplication.shared.delegate as! AppDelegate

let APP_NAME = "CustomHub"
let app_version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String ?? ""

struct DeviceInfo {
    static let deviceType = "iOS"
    static let deviceName = UIDevice.current.name
    static let deviceOS = UIDevice.current.systemVersion
}

struct ScreenSize {
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}
