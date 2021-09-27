//
//  ImageNewsCell.swift
//  MyVKclient
//
//  Created by Владислав Тихоненков on 17.09.2021.
//

import UIKit
import Kingfisher

<<<<<<< HEAD
<<<<<<< HEAD
class ImageNewsCell: UITableViewCell {

    @IBOutlet weak var imageNews: UIImageView!
=======
=======
>>>>>>> lesson3
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
<<<<<<< HEAD
>>>>>>> lesson2
=======
>>>>>>> lesson3

    func clearNewsCell() {
        imageNews.image = nil

<<<<<<< HEAD
<<<<<<< HEAD
=======

>>>>>>> lesson2
=======

>>>>>>> lesson3
    }

    override func prepareForReuse() {
        clearNewsCell()
<<<<<<< HEAD
<<<<<<< HEAD
    }

    func config (meNews: News){
        imageNews.kf.setImage(with: URL(string: meNews.imageNews))
    }
=======
=======
>>>>>>> lesson3

    }

    func config (meNews: News){

        imageNews.kf.setImage(with: URL(string: meNews.imageNews))

          }
<<<<<<< HEAD
>>>>>>> lesson2
=======
>>>>>>> lesson3

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
<<<<<<< HEAD
=======


>>>>>>> lesson2
=======


>>>>>>> lesson3
