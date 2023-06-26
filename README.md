# OnboardSliderScreen
OnboardSliderScreen is to provide a onboard screen with extended dot and extended images.

It also have custom Page Control without using Page Control element in iOS . 

FileName: OnBoardingScreenViewController.swift 

Below function is used for returning the index for displaying image for desired index . 
Case : We displaying only 5 Image Indicator max, even if the images count is greater than 5 that can be any like 30,40 .


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


Setting the Layout for insetForSectionAt for collectionview .

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


//MARK: Setting cell for row for both collection view, one for image slider, another is for custom Page Control .

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

Function for getting the page Index and reload the collection view. 

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
