//
//  CategoryTableViewCell.swift
//  GOSU
//
//  Created by Tanya Tomchuk on 31/01/2018.
//  Copyright © 2018 Tanya Tomchuk. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var categoryDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
