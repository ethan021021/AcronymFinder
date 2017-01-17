//
//  SearchTableViewCell.swift
//  AcronymFinder
//
//  Created by Diamond on 1/16/17.
//  Copyright © 2017 ethanthomas. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(acronym: Acronym) {
        textLabel?.text = acronym.longForm
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
