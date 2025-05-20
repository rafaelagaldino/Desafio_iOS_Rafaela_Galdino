//
//  ViewController.swift
//  ProjectCustomerBase
//
//  Created by Rafaela Galdino on 03/07/20.
//  Copyright © 2020 Rafaela Galdino. All rights reserved.
//

import UIKit
import CoreData

class InsertCustomerViewController: UIViewController {
    let container = UIView()
    lazy var clientNameLabel = getLabel(string: "Nome")
    lazy var clientNameTextField = getTextField()
    lazy var clientPhoneLabel = getLabel(string: "Telefone")
    lazy var clientPhoneTextField = getTextField()
    lazy var clientCpfLabel = getLabel(string: "CPF")
    lazy var clientCpfTextField = getTextField()
    lazy var clientDateOfbirthLabel = getLabel(string: "Data de nascimento")
    lazy var clientDateOfbirthTextField = getTextField()
    lazy var clientGenreLabel = getLabel(string: "Genêro")
    let clientGenreSegmentedControl = UISegmentedControl(items: ["F", "M"])
    var genre: String = ""
    var ageYears: Int = 0
    var popDatePicker: PopDatePicker?

    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    var client: Client?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cadastro".uppercased()

        if client != nil {
            clientNameTextField.text = client?.clientName
            clientPhoneLabel.text = client?.clientPhone
            clientCpfLabel.text = client?.clientCpf
            clientGenreLabel.text = client?.clientGenre
            clientDateOfbirthTextField.text = client?.clientDateOfbirth
        }
        
        popDatePicker = PopDatePicker(forTextField: clientDateOfbirthTextField)
        clientDateOfbirthTextField.delegate = self
        
        addBarButtonItem()
        addView()
        addLabels()
        addTextFields()
        addSegmentedControl()
        addConstraints()
    }
    
    func addBarButtonItem() {
        let addLeftButton = UIBarButtonItem(title: NSLocalizedString("Cancel", comment: ""),
                                        style: .plain,
                                        target: self,
                                        action: #selector(actionCancel(_:)))
        navigationItem.leftBarButtonItem = addLeftButton
        
        let addRightButton = UIBarButtonItem(title: NSLocalizedString("Save", comment: ""),
                                        style: .plain,
                                        target: self,
                                        action: #selector(actionSave(_:)))
        navigationItem.rightBarButtonItem = addRightButton
    }
    
    @objc func actionSave(_ sender: AnyObject) {
        let fields: [String?] = [
            clientNameTextField.text,
            clientCpfTextField.text,
            clientPhoneTextField.text,
            clientDateOfbirthTextField.text,
            genre
        ]

        let hasEmptyField = fields.contains { $0?.trimmingCharacters(in: .whitespaces).isEmpty ?? true }

        if hasEmptyField || ageYears == 0 {
            showAlert()
            return
        }
        
            if client == nil {
                client = Client(context: context)
            }
            client?.clientName = clientNameTextField.text
            client?.clientCpf = clientCpfTextField.text
            client?.clientPhone = clientPhoneTextField.text
            client?.clientDateOfbirth = clientDateOfbirthTextField.text
            client?.clientGenre = genre
            client?.clientAge = "\(ageYears)"
            
            do {
                try context.save()
                navigationController?.popViewController(animated: true)
            } catch {
                print(error.localizedDescription)
            }
    }
    
    @objc func actionCancel(_ sender: AnyObject) {
        navigationController?.popViewController(animated: true)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Campo vazio", message: "Por favor, preencha todos os campos", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func addView() {
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.addSubview(container)
    }

    func addLabels() {
        container.addSubview(clientNameLabel)
        container.addSubview(clientPhoneLabel)
        container.addSubview(clientCpfLabel)
        container.addSubview(clientDateOfbirthLabel)
        container.addSubview(clientGenreLabel)
    }
    
    func getLabel(string: String) -> UILabel {
        var label = UILabel()
        label.text = string
        return label
    }
    
    func getTextField() -> UITextField {
        var textField = UITextField()
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        return textField
    }
    
    func addTextFields() {
        container.addSubview(clientNameTextField)
        container.addSubview(clientPhoneTextField)
        container.addSubview(clientCpfTextField)
        container.addSubview(clientDateOfbirthTextField)
    }
    
    func addSegmentedControl() {
        container.addSubview(clientGenreSegmentedControl)
        clientGenreSegmentedControl.addTarget(self, action: #selector(action), for: .valueChanged)
    }
    
    @objc func action(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            genre = "F"
            clientGenreSegmentedControl.selectedSegmentIndex = 0
        default:
            genre = "M"
            clientGenreSegmentedControl.selectedSegmentIndex = 1
        }
    }
    
    func addConstraints() {
        container.anchorFillSuperview()
        
        var topAnchor: NSLayoutYAxisAnchor
        if #available(iOS 11.0, *) {
            topAnchor = view.safeAreaLayoutGuide.topAnchor
        } else {
            topAnchor = view.topAnchor
        }
        
        clientNameLabel.anchor(
            top: (topAnchor, 30),
            leading: (container.leadingAnchor, 30)
        )
        
        clientNameTextField.anchor(
            top: (clientNameLabel.bottomAnchor, 2),
            leading: (container.leadingAnchor, 30),
            trailing: (container.trailingAnchor, 30),
            height: 30
        )
        
        clientPhoneLabel.anchor(
            top: (clientNameTextField.bottomAnchor, 30),
            leading: (container.leadingAnchor, 30)
        )
        
        clientPhoneTextField.anchor(
            top: (clientPhoneLabel.bottomAnchor, 2),
            leading: (container.leadingAnchor, 30),
            trailing: (container.trailingAnchor, 30),
            height: 30
        )
        
        clientCpfLabel.anchor(
            top: (clientPhoneTextField.bottomAnchor, 30),
            leading: (container.leadingAnchor, 30)
        )
        
        clientCpfTextField.anchor(
            top: (clientCpfLabel.bottomAnchor, 2),
            leading: (container.leadingAnchor, 30),
            trailing: (container.trailingAnchor, 30),
            height: 30
        )
        
        clientDateOfbirthLabel.anchor(
            top: (clientCpfTextField.bottomAnchor, 30),
            leading: (container.leadingAnchor, 30)
        )
        
        clientDateOfbirthTextField.anchor(
            top: (clientDateOfbirthLabel.bottomAnchor, 2),
            leading: (container.leadingAnchor, 30),
            trailing: (container.trailingAnchor, 30),
            height: 30
        )
        
        clientGenreLabel.anchor(
            top: (clientDateOfbirthTextField.bottomAnchor, 30),
            leading: (container.leadingAnchor, 30)
        )
        
        clientGenreSegmentedControl.anchor(
            top: (clientGenreLabel.bottomAnchor, 2),
            leading: (container.leadingAnchor, 30),
            width: 120
        )
    }
    
    func btnCalculateAge(_ newDate: Date) {
        let birthDate = newDate
        let today = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: birthDate, to: today)
         
        ageYears = components.year!
        let ageMonths = components.month
        let ageDays = components.day
         
        print("\(ageYears) years, \(ageMonths!) months, \(ageDays!) days")
    }
}

extension InsertCustomerViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if (textField == clientDateOfbirthTextField) {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            formatter.string(for: "dd/MM/yyyy")

            let initDate: Date? = formatter.date(from: clientDateOfbirthTextField.text!)
            
            let dataChangedCallback: PopDatePicker.PopDatePickerCallback = { (newDate : Date, forTextField : UITextField) -> () in
                self.btnCalculateAge(newDate)
                forTextField.text = (newDate.formatterDate(newDate) ?? "?") as String
            }
            
            popDatePicker!.pick(self, initDate: initDate, dataChanged: dataChangedCallback)
            return false
        } else {
            return true
        }
    }
}
