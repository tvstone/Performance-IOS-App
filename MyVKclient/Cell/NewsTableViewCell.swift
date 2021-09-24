//
//  NewsTableViewCell.swift
//  MyVKclient
//
//  Created by Владислав Тихоненков on 06.07.2021.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    func setupCell(){
        

        
    }
    func clearCell(){
 
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        clearCell()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
        clearCell()
      
    }

    func configureCell (title : String?, image : UIImage?) {
     
        
    }
    
    
    
    


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
