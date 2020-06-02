//
//  ActivityView.swift
//  BazaarBazigar
//
//  Created by hb on 12/04/17.
//  Copyright © 2017 Hidden Brains. All rights reserved.
//

import UIKit

/* Sample:
ActivityView.instanceFromNib().show()
*/

/// This is a custom view for showing Activity.
class ActivityView: UIView {
	
    @IBOutlet weak var vwMain: UIView!
    @IBOutlet weak var vwAnimation: UIView!
    
    static let shared = ActivityView.instanceFromNib()
    
    class func instanceFromNib() -> ActivityView {
		let activityView = UINib(nibName: "ActivityView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! ActivityView
        activityView.frame = APP_DELEGATE.window!.frame
        activityView.center = APP_DELEGATE.window!.center
        return activityView
	}
    
    /// Show view on top of the window.
	func show() {
        vwMain.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5)
        vwAnimation.isHidden = false
        if UIApplication.shared.windows.count > 2 {
            UIApplication.shared.windows[1].addSubview(self)
        } else {
            UIApplication.shared.windows.last?.addSubview(self)
        }
	}
	
    /// Hide View from its superview.
	func hide() {
        vwAnimation.isHidden = true
        self.removeFromSuperview()
	}
}
