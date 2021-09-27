//
//  NewsCell.swift
//  MyVKclient
//
//  Created by Владислав Тихоненков on 04.07.2021.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var tatleNews: UILabel!
    @IBOutlet weak var imageNews: UIImageView!
    @IBOutlet weak var newsTextView: UITextView!
    
    
    
    
    func setupCell(){
        
    
        
    }
   
    func clearCell() {
        
        imageNews.image = nil
        tatleNews.text = nil
        newsTextView.text = nil
    }
    
    override func prepareForReuse() {
        clearCell()
        
    }
    
    func configCellNews (image: UIImage?, lableText : String?, textView : String?){
        imageNews.image = image
        tatleNews.text = lableText
        newsTextView.text = textView
        
    }
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
        clearCell()
        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
