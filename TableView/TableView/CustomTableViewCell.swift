//
//  CustomTableViewCell.swift
//  TableView
//
//  Created by User on 7/5/23.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    static let identifier = "CustomTVC"
    
    /// ICON
        public let _icon : UIImageView = {
            let _icon  = UIImageView()
            _icon.contentMode  = .scaleAspectFit
            _icon.clipsToBounds = true
            return _icon
        }()
        
        /// LABEL
        public let _label : UILabel = {
            let label  = UILabel()
            label.textColor = .darkGray
            label.font = .systemFont(ofSize: 17, weight: .thin)
            return label
        }()
        
        /// ARROW
        public let _arrow : UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(systemName: "arrow.right.circle")
            imageView.tintColor = .darkGray
            imageView.contentMode  = .scaleAspectFill
            imageView.clipsToBounds = true
            return imageView
        }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white // ?? why use contentView instead of view
        
        contentView.addSubview(_icon)
        contentView.addSubview(_label)
        contentView.addSubview(_arrow)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // to configure each cell of table dynamically
    public func configure(text: String, imgName: String){ // usually a model is passed as param instead of the properties
        _label.text = text
        _icon.image = UIImage(systemName: imgName)
        _icon.tintColor = .gray
    }
    override func prepareForReuse() { // we are making a blank slate for using later
        super.prepareForReuse()
        _label.text = nil
        _icon.image = nil
    }
    
    // FOR making cells Clickable
    override func awakeFromNib() {
        super.awakeFromNib()
        _label.isUserInteractionEnabled = true
        contentView.isUserInteractionEnabled = true
    }
    
    // LAYOUT DESIGN
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let iconSize = contentView.frame.size.height - 15
        let arrowSize = _arrow.sizeThatFits(contentView.frame.size).width
        
        // x : offset from left margin
        // y : offset from top margin
        // width, height: dimension of the obj
        
        _icon.frame = CGRect(x: 10, y: (contentView.frame.size.height - iconSize)/2 , width: iconSize, height: iconSize) // we want to subtract 5 from top and 5 from bottom
        
        _label.frame = CGRect(x: 25 + iconSize - 0 , y: 5, width: contentView.frame.size.width - 10 - iconSize - arrowSize , height: contentView.frame.size.height - 10)
        
        _arrow.frame = CGRect(x: contentView.frame.size.width - 2*arrowSize , y: 15, width: arrowSize, height: arrowSize)
    }

}
