//
//  Extensions.swift
//  OTPTextfield
//
//  Created by hb on 13/05/20.
//  Copyright © 2020 hb. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    /// isModel will let you know the controller is Presented or not.
    var isModal: Bool {
        if let index = navigationController?.viewControllers.firstIndex(of: self), index > 0 {
            return false
        } else if presentingViewController != nil {
            return true
        } else if navigationController?.presentingViewController?.presentedViewController == navigationController {
            return true
        } else if tabBarController?.presentingViewController is UITabBarController {
            return true
        } else {
            return false
        }
    }
}
