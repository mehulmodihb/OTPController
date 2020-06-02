//
//  OTPView.swift
//  ATP
//
//  Created by Binal Shah on 06/09/19.
//  Copyright © 2019 Hidden Brains. All rights reserved.
//

import UIKit

enum style {
    case box
    case line
}

/// This view is basically made for implementing One Time Password text.

class OTPView: UIView {
    
    //MARK: - IBOutlets

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var collectionVw: UICollectionView!

    var OTPStyle: style = .box
    
    private var isEmpty : Bool = true
    var pinLength: Int = 4 // Don't change its default value. It must be 4.
    {
        didSet{
            self.pinLength = min(max(pinLength, 4), 10)
            self.setPinLength(length: min(pinLength, 10))
        }
    }
    var textFont: UIFont = UIFont.systemFont(ofSize: 14.0)
    var textColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    var bgColorActiveText: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    var bgColorEmptyText: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    var bgColorFilledText: UIColor = #colorLiteral(red: 0.9606800675, green: 0.9608443379, blue: 0.9606696963, alpha: 1)
    var bgColorTextField: UIColor = #colorLiteral(red: 0.8078431373, green: 0.8196078431, blue: 0.8352941176, alpha: 1)
    var textDidChange:(()->())?
    var OTPIsEntered:(()->())?
    
    /// Init with frame
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    /// Init with coder
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    /// Set Pin Lenght between 4 to 10
    func setPinLength(length: Int)
    {
        self.collectionVw.reloadData()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.1) {
            self.setupUI()
        }
    }

    
    /// Initialize common controls
    private func commonInit()
    {
        Bundle.main.loadNibNamed("OTPView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionVw.delegate = self
        collectionVw.dataSource = self
        collectionVw.register(UINib(nibName: "OTPCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "OTPCollectionViewCell")
    }
    
    
    /// AwakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    /// Setup UI
    func setupUI()
    {
        for i in (0..<pinLength)
        {
            if let txtFd = self.viewWithTag(1000+i) as? OTPTextField
            {
                self.setupTextField(textField: txtFd)
            }
        }
        self.updateTextFields()
        if let txtFd = self.viewWithTag(1000) as? OTPTextField
        {
            DispatchQueue.main.async {
                txtFd.becomeFirstResponder()
            }
        }
    }

    /// textfield setup
    ///
    /// - Parameter textField: textfield
    func setupTextField(textField: OTPTextField)
    {
        if self.OTPStyle == .box
        {
            textField.layer.cornerRadius = 3.0
            textField.layer.masksToBounds = true
            textField.layer.borderColor = #colorLiteral(red: 0.9293106794, green: 0.929469943, blue: 0.9293007255, alpha: 1)
            textField.layer.borderWidth = 1
        }
                
        textField.addTarget(self, action: #selector(textDidChange(textField:)), for: .editingChanged)
        textField.font = self.textFont
        textField.textColor = self.textColor
        textField.backPressed =  {
            DispatchQueue.main.async(execute: {
                if (textField.text?.isEmpty)!// && !self.isEmpty
                {
                    self.manageTextFieldResponderOnBackPress(textField: textField)
                }
                self.isEmpty = false
            })
        }
    }

    /// manage textfield responder
    ///
    /// - Parameter textField: textfield
    func updateTextFields()
    {
        for i in (0..<pinLength)
        {
            if let txtFd = self.viewWithTag(1000+i) as? OTPTextField
            {
                self.checkTextField(txtField: txtFd)
            }
        }
    }
    
    /// update textfield colors based on its state
    ///
    /// - Parameter textField: textfield
    func checkTextField(txtField: OTPTextField)
    {
        let vwBottomLineTag = 2000+(txtField.tag-1000)
        if txtField.isFirstResponder {
            if OTPStyle == .box
            {
                txtField.backgroundColor = bgColorActiveText
            } else {
                if let vwBottomLine = txtField.superview?.viewWithTag(vwBottomLineTag)
                {
                    vwBottomLine.backgroundColor = bgColorActiveText
                    txtField.backgroundColor = .clear
                }
            }
        } else {
            if (txtField.text?.isEmpty)! == true {
                if OTPStyle == .box
                {
                    txtField.backgroundColor = bgColorEmptyText
                } else {
                    if let vwBottomLine = txtField.superview?.viewWithTag(vwBottomLineTag)
                    {
                        vwBottomLine.backgroundColor = bgColorEmptyText
                        txtField.backgroundColor = .clear
                    }
                }
                
            } else {
                if OTPStyle == .box
                {
                    txtField.backgroundColor = bgColorFilledText
                } else {
                    if let vwBottomLine = txtField.superview?.viewWithTag(vwBottomLineTag)
                    {
                        vwBottomLine.backgroundColor = bgColorFilledText
                        txtField.backgroundColor = .clear
                    }
                }
            }
        }
    }
    
    

    /// Clear Textfieds
    func clearEnteredOTP()
    {
        for i in (0..<pinLength)
        {
            if let txtFd = self.viewWithTag(1000+i) as? OTPTextField
            {
                txtFd.text = ""
            }
        }
    }
    
    /// Get entered OTP
    func getOTP() -> String
    {
        var sOTPCode = ""
        for i in (0..<pinLength)
        {
            if let txtFd = self.viewWithTag(1000+i) as? OTPTextField, txtFd.text?.isValidText() == true
            {
                sOTPCode = sOTPCode + txtFd.text!
            }
        }
        return sOTPCode
    }
    
    /// manage textfield change responder
    ///
    /// - Parameter textField: textfield
    @objc func textDidChange(textField: UITextField)
    {
        var sOTPCode = ""
        for i in (0..<pinLength)
        {
            if let txtFd = self.viewWithTag(1000+i) as? OTPTextField, txtFd.text?.isValidText() == true
            {
                sOTPCode = sOTPCode + txtFd.text!
            }
        }
        self.manageTextFieldResponder(textField: textField)
        self.textDidChange?()
    }
    
    /// manage textfield responder for handling logic for OTP
    ///
    /// - Parameter textField: textfield
    func manageTextFieldResponder(textField: UITextField)
    {
        isEmpty = true
        
        if textField.text?.count == 1 {
            
            let currentTextIndex = textField.tag-1000
            
            
            if currentTextIndex == pinLength-1 {
                isEmpty = false
                textField.resignFirstResponder()
                if self.getOTP().count == pinLength
                {
                    self.OTPIsEntered?()
                }
            } else {
                if let txtFd_next = self.viewWithTag(1000+currentTextIndex+1) as? OTPTextField
                {
                    if let cell = collectionVw.viewWithTag(5000+currentTextIndex+1) as? OTPCollectionViewCell
                    {
                        cell.setBeginTxt(viewTopCont: cell.con_top_vwBg, lineHeightCont: cell.con_height_vwBottomLine, view: cell.vwBottomLine)
                    }
                    
                    txtFd_next.becomeFirstResponder()
                }
            }
        }
        else if textField.text?.count == 0
        {
            let currentTextIndex = textField.tag-1000
            if currentTextIndex == 0 || currentTextIndex == 1 {
                if let txtFd_first = self.viewWithTag(1000) as? OTPTextField {
                    txtFd_first.becomeFirstResponder()
                }
            } else {
                if let txtFd_prev = self.viewWithTag(1000+currentTextIndex-1) as? OTPTextField
                {
                    txtFd_prev.becomeFirstResponder()
                }
            }
        }
        else if (textField.text?.count)! > 1
        {
            let lastChar = String(describing: (textField.text?.last)!)
            textField.text = lastChar
            
            let currentTextIndex = textField.tag-1000
            if currentTextIndex == pinLength-1 {
                isEmpty = false
                textField.resignFirstResponder()
            } else {
                if let txtFd_next = self.viewWithTag(1000+currentTextIndex+1) as? OTPTextField
                {
                    txtFd_next.becomeFirstResponder()
                }
            }
        }
    }
    
    /// manage textfield responder on back press
    ///
    /// - Parameter textField: textfield
    func manageTextFieldResponderOnBackPress(textField: UITextField)
    {
        if textField.text?.count == 1
        {
            let currentTextIndex = textField.tag-1000
            if currentTextIndex == pinLength-1 {
                isEmpty = false
                textField.resignFirstResponder()
            } else {
                if let txtFd_next = self.viewWithTag(1000+currentTextIndex+1) as? OTPTextField
                {
                    txtFd_next.becomeFirstResponder()
                }
            }
        }
        else if textField.text?.count == 0
        {
            let currentTextIndex = textField.tag-1000
            if currentTextIndex == 0 {
                if let txtFd_first = self.viewWithTag(1000) as? OTPTextField {
                    txtFd_first.becomeFirstResponder()
                }
            } else if currentTextIndex == 1 {
                if let txtFd_first = self.viewWithTag(1000) as? OTPTextField {
                    txtFd_first.text = ""
                    txtFd_first.becomeFirstResponder()
                }
            }
            else {
                if let txtFd_prev = self.viewWithTag(1000+currentTextIndex-1) as? OTPTextField
                {
                    txtFd_prev.becomeFirstResponder()
                }
            }
        }
        else if (textField.text?.count)! > 1
        {
            let lastChar = String(describing: (textField.text?.last)!)
            textField.text = lastChar
        }
    }

    
}

// MARK: - UITextFieldDelegate
extension OTPView: UITextFieldDelegate {
    /// textFieldDidBeginEditing : Handles textfield when editing begins
    ///
    /// - Parameter textField: textfield
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.updateTextFields()
    }
    
    /// textFieldDidEndEditing: Handles textfield when editing ends.
    ///
    /// - Parameter textField: textfield
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        let currentIndex = textField.tag-1000
        if let cell = collectionVw.viewWithTag(5000+currentIndex) as? OTPCollectionViewCell
        {
            cell.setBeginTxt(viewTopCont: cell.con_top_vwBg, lineHeightCont: cell.con_height_vwBottomLine, view: cell.vwBottomLine, textField: cell.txtField)
        }
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }

        self.updateTextFields()
    }
    
    /// textFieldDidEndEditing: Handles textfield when editing begins.
    ///
    /// - Parameter textField: textfield
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let currentIndex = textField.tag-1000
        if let cell = collectionVw.viewWithTag(5000+currentIndex) as? OTPCollectionViewCell
        {
            for cell in collectionVw.visibleCells
            {
                if let aCell = cell as? OTPCollectionViewCell
                {
                    if aCell.txtField.isFirstResponder {
                        aCell.setBeginTxt(viewTopCont: aCell.con_top_vwBg, lineHeightCont: aCell.con_height_vwBottomLine, view: aCell.vwBottomLine)
                    }
                }
            }
            
            cell.setBeginTxt(viewTopCont: cell.con_top_vwBg, lineHeightCont: cell.con_height_vwBottomLine, view: cell.vwBottomLine, forBegin: true)
            
            UIView.animate(withDuration: 0.3) {
                cell.layoutIfNeeded()
            }
        }
        return true
    }
}

/// custom class for textfield for handling back call.
class OTPTextField: UITextField
{
    var backPressed : (() -> ())?
    override func deleteBackward() {
        super.deleteBackward()
        self.backPressed?()
    }
}


/// String extension for validating text.
extension String {
    
    /// It will validate the given text
    /// - Returns: true or false
    func isValidText() -> Bool {
        let str:String = self.replacingOccurrences(of: " ", with: "")
        return str.count>0 ? true:false
    }
    
}

extension OTPView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return pinLength
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        print(self.frame)
        print(pinLength)
        let rWidth = self.frame.size.width
        let totalBoxWidth: CGFloat = CGFloat((pinLength*50)+((pinLength-1)*10))
        let finalWidth: CGFloat = rWidth-totalBoxWidth
        if finalWidth>0
        {
            return CGSize(width: 50.0, height: 50.0)
        } else {
            let expectedWidth: CGFloat = CGFloat((rWidth - CGFloat((pinLength-1)*10))/CGFloat(pinLength))
            print(expectedWidth)
            return CGSize(width: expectedWidth, height: 50.0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let rWidth = self.frame.size.width
        let totalBoxWidth: CGFloat = CGFloat((pinLength*50)+((pinLength-1)*10))
        let finalWidth: CGFloat = rWidth-totalBoxWidth
        if finalWidth>0
        {
            let totalCellWidth = 50 * collectionView.numberOfItems(inSection: 0)
            let totalSpacingWidth = 10 * (collectionView.numberOfItems(inSection: 0) - 1)
            
            let leftInset = (collectionView.layer.frame.size.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
            let rightInset = leftInset
            
            return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
        } else {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OTPCollectionViewCell", for: indexPath) as! OTPCollectionViewCell
        cell.tag = 5000+indexPath.row
        cell.txtField.tag = 1000+indexPath.row
        cell.vwBottomLine.tag = 2000+indexPath.row
        cell.vwBg.backgroundColor = bgColorTextField
        cell.txtField.delegate = self
        cell.vwBottomLine.isHidden = (OTPStyle == .line ? false : true)
        cell.vwBg.isHidden = (OTPStyle == .line ? false : true)
        return cell
    }
    
}
