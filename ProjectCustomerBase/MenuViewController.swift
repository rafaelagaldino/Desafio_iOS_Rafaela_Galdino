//
//  MenuViewController.swift
//  ProjectCustomerBase
//
//  Created by Rafaela Galdino on 04/07/20.
//  Copyright © 2020 Rafaela Galdino. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    let container = UIView()
    let logo = UIImageView()
    let listClientButton = UIButton()
    let goOutButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        addContainer()
        addImage()
        addButtons()
        addConstraint()
    }
    
    func setupAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = #colorLiteral(red: 0.0431372549, green: 0.1137254902, blue: 0.2470588235, alpha: 1)
        appearance.shadowColor = .clear
        appearance.titleTextAttributes = [.foregroundColor: UIColor.darkText]
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
    }
    
    func addContainer() {
        container.backgroundColor = #colorLiteral(red: 0.0431372549, green: 0.1137254902, blue: 0.2470588235, alpha: 1)
        view.addSubview(container)
    }
    
    func addImage() {
        logo.image = UIImage(named: "electrolux.png")
        logo.contentMode = UIView.ContentMode.scaleToFill

        container.addSubview(logo)
    }
    
    func addButtons() {
        listClientButton.clipsToBounds = true
        listClientButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        listClientButton.layer.cornerRadius = 10
        listClientButton.setTitleColor(UIColor.darkGray, for: .normal)
        listClientButton.setTitle("Clientes".uppercased(), for: UIControl.State.normal)
        listClientButton.addTarget(self, action:#selector(accessListClient), for: .touchUpInside)
        container.addSubview(listClientButton)
        
        goOutButton.setTitle("Sair", for: UIControl.State.normal)
        container.addSubview(goOutButton)
    }
    
    @objc func accessListClient() {
        navigationController?.pushViewController(ListCustomerTableViewController(), animated: true)
    }

    func addConstraint() {
        container.anchorFillSuperview()

        logo.anchor(
            centerY: (container.centerYAnchor, -50),
            leading: (container.leadingAnchor, 20),
            trailing: (container.trailingAnchor, 20),
            height: 100
        )
        
        listClientButton.anchor(
            top: (logo.bottomAnchor, 20),
            leading: (container.leadingAnchor, 20),
            trailing: (container.trailingAnchor, 20)
        )
        
        goOutButton.anchor(
            centerX: (container.centerXAnchor, 0),
            top: (listClientButton.bottomAnchor, 20)
        )
    }

}
