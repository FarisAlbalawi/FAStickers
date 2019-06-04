//
//  GifCell.swift
//  FAStickers
//
//  Created by Faris Albalawi on 6/4/19.
//

import UIKit

class GifCell: UICollectionViewCell {
    var gifImage = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.gifImage.contentMode = .scaleAspectFit
        gifImage.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.gifImage)
        
        let constraints = [
            
            gifImage.topAnchor.constraint(equalTo: topAnchor, constant: 1),
            gifImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1),
            gifImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -1),
            gifImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 1),
            
            ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //        fatalError("init(coder:) has not been implemented")
    }
}
