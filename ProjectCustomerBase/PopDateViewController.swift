//
//  DateOfbirthDatePicker.swift
//  ProjectCustomerBase
//
//  Created by Rafaela Galdino on 04/07/20.
//  Copyright © 2020 Rafaela Galdino. All rights reserved.
//

import UIKit

protocol DataPickerViewControllerDelegate: class {
    func datePickerVCDismissed(_ date: Date?)
}

class PopDateViewController: UIViewController {
    var container = UIView()
    var datePicker = UIDatePicker()
    let buttonOk = UIButton()
    
    weak var delegate : DataPickerViewControllerDelegate?

    var currentDate : Date? {
        didSet {
            updatePickerCurrentDate()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        updatePickerCurrentDate()
        addDatePicker()
    }
    
    private func updatePickerCurrentDate() {
        guard let currentDate = self.currentDate else { return }
        datePicker.date = currentDate
        
    }
    
    func addDatePicker() {
        view.addSubview(container)
        container.anchor(
            top: (view.topAnchor, 0),
            leading: (view.leadingAnchor, 0),
            trailing: (view.trailingAnchor, 0),
            height: 200
        )
        
        datePicker.datePickerMode = .date
        container.addSubview(datePicker)
        datePicker.anchor(
            top: (container.topAnchor, 0),
            leading: (container.leadingAnchor, 0),
            trailing: (container.trailingAnchor, 0),
            height: 162
        )
        
        buttonOk.setTitle("Ok", for: .normal)
        buttonOk.setTitleColor(UIColor.blue, for: .normal)
        buttonOk.addTarget(self, action: #selector(actionOk), for: .touchUpInside)
        container.addSubview(buttonOk)
        buttonOk.anchor(
            centerX: (container.centerXAnchor, 0), bottom: (container.bottomAnchor, 0), height: 44
        )
        
    }

    @objc func actionOk(_ sender: AnyObject) {
        self.dismiss(animated: true) {
            let nsdate = self.datePicker.date
            self.delegate?.datePickerVCDismissed(nsdate)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.delegate?.datePickerVCDismissed(nil)
    }
}
