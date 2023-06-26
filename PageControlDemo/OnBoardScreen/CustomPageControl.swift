//
//  CustomPageControl2.swift
//  PageControlDemo
//
//  Created by Alok Rathaur on 20/06/23.
//

import Foundation
import UIKit

class CustomPageControl: UIPageControl {

    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    @IBInspectable var labelString: String?
    
    @IBInspectable var currentPageImage: UIImage?

    @IBInspectable var otherPagesImage: UIImage?

    override var numberOfPages: Int {
        didSet {
            updateDots()
        }
    }

    override var currentPage: Int {
        didSet {
            updateDots()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        if #available(iOS 14.0, *) {
            defaultConfigurationForiOS14AndAbove()
        } else {
            pageIndicatorTintColor = .clear
            currentPageIndicatorTintColor = .clear
            clipsToBounds = false
        }
    }

    private func defaultConfigurationForiOS14AndAbove() {
        if #available(iOS 14.0, *) {
            for index in 0..<numberOfPages {
                let image = index == currentPage ? currentPageImage : otherPagesImage
                setIndicatorImage(image, forPage: index)
            }

            // give the same color as "otherPagesImage" color.
            pageIndicatorTintColor = .gray
            
            // give the same color as "currentPageImage" color.
            currentPageIndicatorTintColor = .black
            /*
             Note: If Tint color set to default, Indicator image is not showing. So, give the same tint color based on your Custome Image.
            */
        }
    }

    private func updateDots() {
        if #available(iOS 14.0, *) {
            defaultConfigurationForiOS14AndAbove()
        } else {
            for (index, subview) in subviews.enumerated() {
                let imageView: UIImageView
                if let existingImageview = getImageView(forSubview: subview) {
                    imageView = existingImageview
                } else {
                    imageView = UIImageView(image: otherPagesImage)
                    
                    imageView.center = subview.center
                    subview.addSubview(imageView)
                    subview.clipsToBounds = false
                }
                imageView.image = currentPage == index ? currentPageImage : otherPagesImage
                
                if(currentPage == index){
                    let label = UILabel();
                    label.text = "1/2";
                    label.textColor = UIColor.red
                    label.sizeToFit();
                    imageView.addSubview(label)
                    // Set the label's position and size to be centered within the image view
                    label.translatesAutoresizingMaskIntoConstraints = false
                    NSLayoutConstraint.activate([
                        label.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
                        label.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
                    ])
                }
                
            }
        }
    }

    private func getImageView(forSubview view: UIView) -> UIImageView? {
        if let imageView = view as? UIImageView {
            return imageView
        } else {
            let view = view.subviews.first { (view) -> Bool in
                return view is UIImageView
            } as? UIImageView

            return view
        }
    }
}



extension UIView {

    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
