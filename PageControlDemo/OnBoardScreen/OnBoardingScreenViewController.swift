//
//  OnBoardingScreenViewController.swift
//  PageControlDemo
//
//  Created by Alok Rathaur on 20/06/23.
//

import UIKit

class OnBoardScreenViewController: UIViewController {
    
    //MARK:- IBOutlets...
    
    @IBOutlet weak var collectionView_slider : UICollectionView!
    
    @IBOutlet weak var pageControl: CustomPageControl!
    
    //CustomPageControl
    @IBOutlet weak var btn_arrow: UIButton!
    
    @IBOutlet weak var collectionViewPageControl: UICollectionView!
    
    var sliders_count:Int = 3
    
    var urlImgArray = [String]()
    var textHeading = [String]()
    var textPara = [String]()
    
    var imagesArray = ["onboarding-1","onboarding-2","onboarding-3","onboarding-1","onboarding-2","onboarding-3","onboarding-1","onboarding-2","onboarding-3","onboarding-1","onboarding-2","onboarding-3","onboarding-1","onboarding-2","onboarding-3"]

    var currentSlider:Int = 0;
    var currentImageIndex:Int = 0;
    
    public static let onScreenBoarding_status = "onScreenBoarding_status"
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let flowLayout = UICollectionViewFlowLayout()
       flowLayout.minimumInteritemSpacing = 5
       flowLayout.minimumLineSpacing = 0

       flowLayout.scrollDirection = .horizontal
        collectionViewPageControl.collectionViewLayout = flowLayout
        collectionViewPageControl.isPagingEnabled = true
        collectionViewPageControl.register(UINib(nibName: "PageControlCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PageControlCollectionViewCell")
        collectionViewPageControl.register(UINib(nibName: "OtherPageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "OtherPageCollectionViewCell")
        collectionViewPageControl.contentMode = .center
        
    }
    
    
    
    func swipeCollectionView(){
        let collectionBounds = self.collectionView_slider.bounds
        let contentOffset = CGFloat(floor(self.collectionView_slider.contentOffset.x + collectionBounds.size.width))
        self.moveCollectionToFrame(contentOffset: contentOffset)
    }
    
    func moveCollectionToFrame(contentOffset : CGFloat) {

           let frame: CGRect = CGRect(x : contentOffset ,y : self.collectionView_slider.contentOffset.y ,width : self.collectionView_slider.frame.width,height : self.collectionView_slider.frame.height)
           self.collectionView_slider.scrollRectToVisible(frame, animated: true)
       }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

}



extension OnBoardScreenViewController:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //MARK:- CollectionView Delegates...
    
    func calculateCurrentIndex(totalImages: Int, currentIndex: Int) -> Int {
        let displayedIndicators = 5 // Number of indicators to display

        if totalImages <= displayedIndicators {
            return currentIndex // Return the same index if total images are less than or equal to the displayed indicators
        } else {
            if currentIndex < 2 {
                return currentIndex // Return the same index if it's less than 2
            } else if currentIndex == totalImages - 2 {
                return displayedIndicators - 2 // Return the last index if it's within the last 2 indices
            } else if currentIndex >= totalImages - 2 {
                return displayedIndicators - 1 // Return the last index if it's within the last 2 indices
            } else {
                return 2 // Return the 3rd index for all other cases
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        if collectionView == collectionViewPageControl {
            let imageCount = imagesArray.count ?? 0
            if(imageCount >= 5){
                let totalCellWidth = (14*5)+28// 14 for otherPage collectionviewcell Width
                let totalSpacingWidth = 5 * (5 - 1)

                let leftInset = (collectionViewPageControl.frame.size.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
                let rightInset = leftInset

                return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
            }else{
                let totalCellWidth = (14*imageCount)+28// 14 for otherPage collectionviewcell Width
                let totalSpacingWidth = 5 * (imageCount - 1)

                let leftInset = (collectionViewPageControl.frame.size.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
                let rightInset = leftInset

                return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
            }
            
        }
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == collectionView_slider){
            return imagesArray.count
        }else{
            var imageCount = imagesArray.count ?? 0;
            if(imageCount >= 5){
                return 5
            }else{
                return imageCount
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == collectionView_slider){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCollectionViewCell", for: indexPath) as! SliderCollectionViewCell
            
            cell.sliderImage.image = UIImage(named: self.imagesArray[indexPath.row])
            cell.sliderHeading.text = "Heading \(indexPath.row)" //self.textHeading[indexPath.row]
            cell.sliderPara.text  = "Para \(indexPath.row)" //self.textPara[indexPath.row]
            
            return cell
        }
        if(collectionView == collectionViewPageControl){
            if(indexPath.row == currentSlider){
                let cellPageControl = collectionViewPageControl.dequeueReusableCell(withReuseIdentifier: "PageControlCollectionViewCell", for: indexPath) as! PageControlCollectionViewCell
                let imageCount = imagesArray.count ?? 0
                
                let str = "\(currentImageIndex+1)"+"/"+"\(imageCount)"
                cellPageControl.currentPageLabel.text = str
                
                return cellPageControl
            }else{
                let cellOtherPage = collectionViewPageControl.dequeueReusableCell(withReuseIdentifier: "OtherPageCollectionViewCell", for: indexPath) as! OtherPageCollectionViewCell

                return cellOtherPage
            }
        }
        return UICollectionViewCell()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
        if(collectionView == collectionView_slider){
            return CGSize(width: self.view.frame.size.width, height: collectionView_slider.frame.size.height)
        }
        if(collectionView == collectionViewPageControl){
            if(indexPath.row == currentSlider){
                return CGSize(width: 35, height: 30)
            }else{
                return CGSize(width: 14, height: 30)
            }
        }
        return CGSize(width: 0, height: 0)
        
    }
    
}

extension OnBoardScreenViewController{
    
    //MARK:- ScrollView Delegates...
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x
        self.pageControl.currentPage = Int(offset / collectionView_slider.frame.size.width)
        
        print("slider: \(Int(offset / collectionView_slider.frame.size.width))");
        
        let page = Int(offset / collectionView_slider.frame.size.width);
        
        let pageIndex = Int(offset / collectionView_slider.frame.size.width);
        self.currentImageIndex = pageIndex;
        var imageCounts = imagesArray.count ?? 0
     
        self.currentSlider = calculateCurrentIndex(totalImages: imageCounts, currentIndex: pageIndex)
        
        
        collectionViewPageControl.reloadData()
    }
}
