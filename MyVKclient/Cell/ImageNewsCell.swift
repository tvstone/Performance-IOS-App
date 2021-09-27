//
//  ImageNewsCell.swift
//  MyVKclient
//
//  Created by Владислав Тихоненков on 17.09.2021.
//

import UIKit
import Kingfisher

<<<<<<< HEAD
class ImageNewsCell: UITableViewCell {

    @IBOutlet weak var imageNews: UIImageView!
=======
 class ScaledHeightImageView: UIImageView {

    override var intrinsicContentSize: CGSize {

        if let myImage = self.image {
            let myImageWidth = myImage.size.width
            let myImageHeight = myImage.size.height
            let myViewWidth = self.frame.size.width

            let ratio = myViewWidth/myImageWidth
            let scaledHeight = myImageHeight * ratio

            return CGSize(width: myViewWidth, height: scaledHeight)
        }

        return CGSize(width: -1.0, height: -1.0)
    }

}

class ImageNewsCell: UITableViewCell{

    @IBOutlet weak var imageNews: UIImageView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
>>>>>>> lesson2

    func clearNewsCell() {
        imageNews.image = nil

<<<<<<< HEAD
=======

>>>>>>> lesson2
    }

    override func prepareForReuse() {
        clearNewsCell()
<<<<<<< HEAD
    }

    func config (meNews: News){
        imageNews.kf.setImage(with: URL(string: meNews.imageNews))
    }
=======

    }

    func config (meNews: News){

        imageNews.kf.setImage(with: URL(string: meNews.imageNews))

          }
>>>>>>> lesson2

    override func awakeFromNib() {
        super.awakeFromNib()
        clearNewsCell()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
<<<<<<< HEAD
=======


>>>>>>> lesson2
