//
//  ViewController.swift
//  PageControlDemo
//
//  Created by Alok Rathaur on 20/06/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionViewPageControl: UICollectionView!
    
    var imagesArray = ["onboarding-1","onboarding-2","onboarding-3"]

    var currentSlider:Int = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let flowLayout = UICollectionViewFlowLayout()
       flowLayout.minimumInteritemSpacing = 0
       flowLayout.minimumLineSpacing = 0

       flowLayout.scrollDirection = .horizontal
        collectionViewPageControl.collectionViewLayout = flowLayout
        collectionViewPageControl.isPagingEnabled = true
        collectionViewPageControl.register(UINib(nibName: "PageControlCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PageControlCollectionViewCell")
        collectionViewPageControl.register(UINib(nibName: "OtherPageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "OtherPageCollectionViewCell")
        
        // Do any additional setup after loading the view.
    }
    

}



extension ViewController:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //MARK:- CollectionView Delegates...
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if(collectionView == collectionView_slider){
//
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == collectionViewPageControl){
            if(indexPath.row == currentSlider){
                let cellPageControl = collectionViewPageControl.dequeueReusableCell(withReuseIdentifier: "PageControlCollectionViewCell", for: indexPath) as! PageControlCollectionViewCell
                let str = "\(currentSlider+1)"+"/"+"\(imagesArray.count)"
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

