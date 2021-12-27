//
//  MusicTableViewCell.swift
//  MusicTableView
//
//  Created by 塗詠順 on 2021/12/24.
//

import UIKit

class MusicTableViewCell: UITableViewCell {
    
    @IBOutlet weak var musicPhotoImage: UIImageView!
    @IBOutlet weak var musicNameLabel: UILabel!
    @IBOutlet weak var singerLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
