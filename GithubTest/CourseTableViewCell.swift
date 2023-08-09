//
//  CourseTableViewCell.swift
//  GithubTest
//
//  Created by GhassanAbbas on 08/08/2023.
//

import UIKit

class CourseTableViewCell: UITableViewCell {

    @IBOutlet weak var courseName: UILabel!
    
    @IBOutlet weak var courseAgeRange: UILabel!
    
    @IBOutlet weak var coursePrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
