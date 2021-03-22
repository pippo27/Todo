//
//  TaskTableViewCell.swift
//  Todo
//
//  Created by Arthit Thongpan on 20/3/2564 BE.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var task: Task! {
        didSet {
            descriptionLabel.text = task.description
            dateLabel.text = ""
            timeLabel.text = ""
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
