//
//  CustomPageControl.swift
//  PageControlDemo
//
//  Created by Alok Rathaur on 16/06/23.
//

import Foundation
import UIKit

class CustomPageControl2: UIPageControl {
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private let image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var pageCount: Int = 0
    
    override var currentPage: Int {
        didSet {
            label.text = "\(currentPage + 1)/\(pageCount)"
        }
    }
    
    override var numberOfPages: Int {
        didSet {
            pageCount = numberOfPages
            label.text = "\(currentPage + 1)/\(pageCount)"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        addSubview(label)
        addSubview(image)
        
        // Customize the appearance of the label and image here
        // For example:
        label.textColor = .white
        image.image = UIImage(named: "dot")
        
        // Position the label and image within the page control
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.trailingAnchor.constraint(equalTo: label.leadingAnchor, constant: -8).isActive = true
        image.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
