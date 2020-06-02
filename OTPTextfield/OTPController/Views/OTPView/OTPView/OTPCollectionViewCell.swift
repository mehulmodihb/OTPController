//
//  OTPCollectionViewCell.swift
//  OTPTextfield
//
//  Created by Binal Shah on 06/09/19.
//  Copyright © 2019 Hidden Brains. All rights reserved.
//

import UIKit

class OTPCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var txtField: OTPTextField!
    @IBOutlet weak var vwBottomLine: UIView!
    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var con_top_vwBg: NSLayoutConstraint!
    @IBOutlet weak var con_height_vwBottomLine: NSLayoutConstraint!
    
    
    /// awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setBeginTxt(viewTopCont: con_top_vwBg, lineHeightCont: con_height_vwBottomLine, view: vwBottomLine)
        self.makeCurveAndAlpha(view: vwBg)

    }
    
    /// Set Curve and Alpha value of the given view
    /// - Parameter view: UIView
    func makeCurveAndAlpha(view: UIView){
        view.layer.cornerRadius = 1.0
        view.alpha = 0.2
    }
    
    /// Handles view display based on given parameters for type ".line"
    /// - Parameters:
    ///   - viewTopCont: top constraint of vwBg
    ///   - lineHeightCont: height constraint of vwBottomLine
    ///   - view: vwBg
    ///   - forBegin: Bool value that handles top constraint, height and shadow.
    ///   - textField: txtField
    func setBeginTxt(viewTopCont: NSLayoutConstraint, lineHeightCont: NSLayoutConstraint, view: UIView, forBegin: Bool = false, textField: OTPTextField? = nil) {
        if forBegin {
            con_top_vwBg.constant = 0
            lineHeightCont.constant = 2.0
            setShadowOrNot(shadow: true, view: view)
        }
        else {
            con_top_vwBg.constant = 50
            lineHeightCont.constant = 1.0
            setShadowOrNot(shadow: false, view: view)
        }
        if textField != nil {
            makeTextFieldMoreDarker(textField: textField!, view: view)
        }
    }
    
    /// Function to add or remove shadow for the given view
    /// - Parameters:
    ///   - shadow: Bool value for adding shadow or not
    ///   - view: the view to add or from remove shadow.
    func setShadowOrNot(shadow: Bool, view: UIView) {
        if shadow{
//            view.backgroundColor = activeColor
//            view.layer.shadowColor = activeColor.cgColor
            view.layer.shadowOpacity = 1
            view.layer.shadowOffset = CGSize.zero
            view.layer.shadowRadius = 2
            view.layer.cornerRadius = 1.0
            view.alpha = 1.0
        }
        else{
            view.alpha = 0.50
            view.layer.shadowOpacity = 0.0
            view.layer.cornerRadius = 0.0
//            view.backgroundColor = lineColor
        }
    }
    
    /// Check the textfield value, If the value is not empty it will display bottom line more darker to highlight.
    /// - Parameters:
    ///   - textField: txtField
    ///   - view: vwBottomLine
    func makeTextFieldMoreDarker(textField: OTPTextField, view: UIView) {
        if textField.text?.isEmpty == false{
            view.alpha = 1.0
        }
        else{
            view.alpha = 0.50
        }
    }


}

