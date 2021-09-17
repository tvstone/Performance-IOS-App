//
//  ImageNewsCell.swift
//  MyVKclient
//
//  Created by Владислав Тихоненков on 17.09.2021.
//

import UIKit
import Kingfisher

class ImageNewsCell: UITableViewCell {

    @IBOutlet weak var imageNews: UIImageView!

    func clearNewsCell() {
        imageNews.image = nil

    }

    override func prepareForReuse() {
        clearNewsCell()
    }

    func config (meNews: News){
        imageNews.kf.setImage(with: URL(string: meNews.imageNews))
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        clearNewsCell()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
