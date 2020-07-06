//
//  PopDatePicker.swift
//  ProjectCustomerBase
//
//  Created by Rafaela Galdino on 04/07/20.
//  Copyright © 2020 Rafaela Galdino. All rights reserved.
//

import UIKit

class PopDatePicker: NSObject, UIPopoverPresentationControllerDelegate, DataPickerViewControllerDelegate {
    public typealias PopDatePickerCallback = (_ newDate : Date, _ forTextField : UITextField)->()
    
    var datePickerVC: PopDateViewController
    var popover: UIPopoverPresentationController?
    var textField: UITextField!
    var dataChanged: PopDatePickerCallback?
    var presented = false
    var offset: CGFloat = 8.0
    
    public init(forTextField: UITextField) {
        datePickerVC = PopDateViewController()
        self.textField = forTextField
        super.init()
    }
    
    public func pick(_ inViewController : UIViewController, initDate : Date?, dataChanged : @escaping PopDatePickerCallback) {
        if presented { return }
        datePickerVC.delegate = self
        datePickerVC.modalPresentationStyle = UIModalPresentationStyle.popover
        datePickerVC.preferredContentSize = CGSize(width: 500,height: 208)
        datePickerVC.currentDate = initDate
        
        popover = datePickerVC.popoverPresentationController
        if let popover = popover {
            popover.sourceView = textField
            popover.sourceRect = CGRect(x: self.offset,y: textField.bounds.size.height,width: 0,height: 0)
            popover.delegate = self
            self.dataChanged = dataChanged
            inViewController.present(datePickerVC, animated: true, completion: nil)
            presented = true
        }
    }
    
    //Added UITraitCollection parameter to fix the full screen popover stretch in iPhone 6s and 6s plus - Pramod Joshi
    public func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
            return .none
    }
    
    func datePickerVCDismissed(_ date : Date?) {
        if let dataChanged = dataChanged {
            if let date = date {
                dataChanged(date, textField)
            }
        }
        presented = false
    }
}
