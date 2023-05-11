//
//  GalleryCollectionViewCell.swift
//  TableView
//
//  Created by User on 10/5/23.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()
    
    static let identifier = "GalleryCell"
    
    private let img: UIImageView = {
        let imageView = UIImageView()
        //imageView.frame = contentView.bounds
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return  imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(img)
        
        let img_name = [UIImage(named:"cat_black"), UIImage(named:"cat_brown"), UIImage(named:"cat_gray"), UIImage(named:"cat_green"), UIImage(named:"cat_white"),UIImage(named:"aus"),UIImage(named:"fra"),UIImage(named:"ken"),UIImage(named:"slo"),UIImage(named:"ban")].compactMap({$0})
        //let images = []
                
        //img.image = (UIImage(named: img_name.randomElement()! ))
        img.image = img_name.randomElement()
                
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        img.frame = contentView.bounds
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        //img.image = nil
    }
}
