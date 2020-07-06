//
//  ListCustomerCell.swift
//  ProjectCustomerBase
//
//  Created by Rafaela Galdino on 03/07/20.
//  Copyright © 2020 Rafaela Galdino. All rights reserved.
//

import UIKit

class ListCustomerCell: UITableViewCell {

    let clientName = UILabel()
    static let reuseIdentifier = "ListCustomerCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureCell()
    }

    func configureCell() {
        contentView.addSubview(clientName)
        clientName.anchor(
            centerX: (centerXAnchor, 0),
            centerY: (centerYAnchor, 0)
        )
    }
}
