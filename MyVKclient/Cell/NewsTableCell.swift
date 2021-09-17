//
//  NewsTableCell.swift
//  MyVKclient
//
//  Created by Владислав Тихоненков on 06.07.2021.
//

import UIKit
import Kingfisher

class NewsTableCell: UITableViewCell {
    @IBOutlet weak var newsLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!

    func setupNewsCell(){
   
    }
   
    func clearNewsCell() {
        newsLabel.text = nil
        newsImage.image = nil
        
    }
    
    override func prepareForReuse() {
        clearNewsCell()
    }
    
    func config (meNews: News){

        newsLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        newsLabel.numberOfLines = 0
        newsLabel.text = meNews.titleNews
        newsImage.kf.setImage(with: URL(string: meNews.imageNews))
        
    }
     
    override func awakeFromNib() {
        super.awakeFromNib()
        setupNewsCell()
        clearNewsCell()

    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//    }
    
}
