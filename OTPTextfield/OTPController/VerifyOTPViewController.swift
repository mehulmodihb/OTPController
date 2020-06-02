//
//  VerifyOTPViewController.swift
//  ATP
//
//  Created by Binal Shah on 06/09/19.
//  Copyright © 2019 Hidden Brains. All rights reserved.
//

import UIKit

class VerifyOTPViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var vwContent: UIView!
    @IBOutlet private weak var vwOTP: OTPView!
    
    @IBOutlet private weak var btnConfirm: UIButton!
    @IBOutlet private weak var btnResendOTP: UIButton!
    
    @IBOutlet private weak var vwTimer: UICircularTimerRing!

    @IBOutlet private weak var lblTitle: UILabel!
    
    private var config:OTPConfig = OTPConfig()
    private var onOTPEntered: ((String) -> Void)?
    
    // MARK: - View Lifecycle
    
    class func instance() -> VerifyOTPViewController? {
        return UIStoryboard(name: "VerifyOTP", bundle: nil).instantiateViewController(withIdentifier: "VerifyOTPViewController") as? VerifyOTPViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Verify Phone"
        ///Setup Back Button
        if self.isModal {
            self.navigationItem.setLeftBarButton(UIBarButtonItem.init(title: "Cancel", style: .plain, target: self, action: #selector(dismissVC)), animated: false)
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5) {
            self.setupUI()
            self.startTimer()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Custom methods
    
    /// Back
    @IBAction private func btnBackClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }

    /// Setup UI
    private func setupUI()
    {
        ///Setup Title Label
        lblTitle.text = config.titleText
        lblTitle.textColor = config.textColorLblTitle
        lblTitle.font = config.fontLblTitle
        
        ///Setup Resend Button
        btnResendOTP.titleLabel?.font = config.fontBtnResendOTP
        btnResendOTP.setTitleColor(config.textColorBtnResendOTP, for: .normal)
        
        ///Setup Confirm Button
        btnConfirm.titleLabel?.font = config.fontBtnConfirm
        btnConfirm.setTitleColor(config.textColorBtnConfirm, for: .normal)
        btnConfirm.backgroundColor = config.bgColorBtnConfirm
        btnConfirm.isEnabled = false
        
        ///Setup TimerView
        vwTimer.isHidden = true
        vwTimer.font = config.fontLblProgress
        vwTimer.fontColor = config.textColorLblProgress
        vwTimer.outerRingColor = config.colorOuterProgress
        vwTimer.innerRingColor = config.colorInnerProgress
        vwTimer.style = .ontop
        vwTimer.font = config.fontLblProgress
        var formatValue = UICircularProgressRingFormatter()
        formatValue.valueIndicator = ""
        vwTimer.valueFormatter = formatValue
        
        ///Setup OTP View
        self.vwOTP.textFont = config.fontVwOTP
        self.vwOTP.textColor = config.textColorVwOTP
        self.vwOTP.bgColorActiveText = config.bgColorActiveText
        self.vwOTP.bgColorEmptyText = config.bgColorEmptyText
        self.vwOTP.bgColorFilledText = config.bgColorFilledText
        self.vwOTP.bgColorTextField = config.bgColorTextField
        self.vwOTP.OTPStyle = config.OTPStyle
        
        //-----Compulsory need to set pinLength-----//
        self.vwOTP.pinLength = config.pinLength// Lenght should be between 4 to 10
        //-----Compulsory need to set pinLength-----//
        
        self.vwOTP.textDidChange = {() in
            self.btnConfirm.isEnabled = (self.vwOTP.getOTP().count == self.vwOTP.pinLength) ? true : false
        }
        
        self.vwOTP.OTPIsEntered = { [weak self] () in
              guard let weakSelf = self else {return}
              weakSelf.vwTimer.resetTimer()
              weakSelf.onOTPEntered?(weakSelf.vwOTP.getOTP())
        }
        
    }
    
    // MARK: - IBAcion methods
    /// Verify OTP
    @IBAction private func selectContinue(sender: UIButton) {
        
        self.view.endEditing(true)
        guard isValidCredentails() else { return }
        
        print(self.vwOTP.getOTP())
    }
    
    //MARK:- Button Resend Action
    @IBAction private func btnResendPressed(_ sender: UIButton) {
        self.btnResendOTP.isHidden = true
        self.vwTimer.resetTimer()
        
        DispatchQueue.main.async {
            self.startTimer()
        }
        /// Make API Call for resend OTP here
    }

    /// Check validation
    private func isValidCredentails() -> Bool
    {
        var message : String!
        var isValid : Bool = true
        
        if self.vwOTP.getOTP().count != self.vwOTP.pinLength
        {
            message = "Please enter OTP."
            isValid = false
        }
        
        if !isValid {
            GlobalUtility_OTP.showErrorMessage(withStatus: message)
        }
        
        return isValid
    }

    
    private func startTimer()
    {
        self.vwTimer.isHidden = false
        self.vwTimer.startTimer(to: config.timerInterval) { (state) in
            switch state {
            case .finished:
                self.vwTimer.isHidden = true
                self.btnResendOTP.isHidden = false
            case .continued( _):
                print("Continue")
            case .paused( _):
                print("Paused")
            }
        }
    }
    
    @objc private func dismissVC() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Public Methods
    func presentWith(config: OTPConfig? = nil, to: UIViewController, onOTPEntered: @escaping ((String) -> Void)) {
        if let config = config {
            self.config = config
        }
        self.onOTPEntered = onOTPEntered
        let nc = UINavigationController(rootViewController: self)
        to.present(nc, animated: true, completion: nil)
    }
    
    func pushWith(config: OTPConfig? = nil, to: UIViewController, onOTPEntered: @escaping ((String) -> Void)) {
        if let config = config {
            self.config = config
        }
        self.onOTPEntered = onOTPEntered
        to.navigationController?.pushViewController(self, animated: true)
    }
}

