//
//  RootViewController.swift
//  OTPTextfield
//
//  Created by hb on 11/05/20.
//  Copyright © 2020 hb. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    /// Opens OTPController by Pushing from navigationController
    @IBAction func selectVerifyPhone_box(_ sender: Any) {
        let obj = self.getController(style: .box)
        obj.vc.pushWith(config:obj.config, to: self) { (otp) in
            print(otp)
            GlobalUtility_OTP.showHud()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2.0) {
                GlobalUtility_OTP.hideHud()
                GlobalUtility_OTP.showSuccessMessage(withStatus: "OTP verified successfully.")
                obj.vc.navigationController?.popViewController(animated: true)
            }
        }
    }

    @IBAction func selectVerifyPhone_line(_ sender: Any) {
        let obj = self.getController(style: .line)
        obj.vc.pushWith(config:obj.config, to: self) { (otp) in
            print(otp)
            GlobalUtility_OTP.showHud()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2.0) {
                GlobalUtility_OTP.hideHud()
                GlobalUtility_OTP.showSuccessMessage(withStatus: "OTP verified successfully.")
                obj.vc.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    /// Opens OTPController by Presenting
    @IBAction func selectVerifyPhone_present_box(_ sender: Any) {
        let obj = self.getController(style: .box)
        obj.vc.presentWith(config:obj.config, to: self) { (otp) in
            print(otp)
            GlobalUtility_OTP.showHud()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2.0) {
                GlobalUtility_OTP.hideHud()
                GlobalUtility_OTP.showSuccessMessage(withStatus: "OTP verified successfully.")
                obj.vc.dismiss(animated: true, completion: nil)
            }
        }
    }

    @IBAction func selectVerifyPhone_present_line(_ sender: Any) {
        let obj = self.getController(style: .line)
        obj.vc.presentWith(config:obj.config, to: self) { (otp) in
            print(otp)
            GlobalUtility_OTP.showHud()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2.0) {
                GlobalUtility_OTP.hideHud()
                GlobalUtility_OTP.showSuccessMessage(withStatus: "OTP verified successfully.")
                obj.vc.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    /// Initialize OTPController.
    func getController(style: style) -> (vc: VerifyOTPViewController, config: OTPConfig)
    {
        let vc = VerifyOTPViewController.instance()!
        var con = OTPConfig()
        if style == .box {
            con = BoxStyleConfig()
        } else {
            con = LineStyleConfig()
        }
        con.pinLength = 6
        return (vc, con)
    }
    
}
