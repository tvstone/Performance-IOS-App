//
//  NewsTableCellImages.swift
//  MyVKclient
//
//  Created by Владислав Тихоненков on 31.08.2021.
//

import UIKit
import Kingfisher

class NewsTableCellImages: UITableViewCell {

    @IBOutlet weak var imageNews: UIImageView!

    func setupNewsCell(){

    }

    func clearNewsCell() {
        imageNews.image = nil

    }

    override func prepareForReuse() {
        clearNewsCell()
    }

    func configImage (meNews: News){

        imageNews.kf.setImage(with: URL(string: meNews.imageNews))

    }


    override func awakeFromNib() {
        super.awakeFromNib()
        setupNewsCell()
        clearNewsCell()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}


