//
//  AllTheRandomUsers.swift
//  SearchGitHub
//
//  Created by IMCS2 on 11/11/19.
//  Copyright © 2019 com.phani. All rights reserved.
//

import UIKit

class AllTheRandomUsers: UITableViewCell {
    
    @IBOutlet weak var imageOfTheGitRepositoryHolder: UIImageView?
    @IBOutlet weak var userName: UILabel?
    @IBOutlet weak var numberOfRepository: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
