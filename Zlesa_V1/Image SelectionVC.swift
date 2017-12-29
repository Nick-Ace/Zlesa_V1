//
//  ImageSelectionViewController.swift
//  ZlesaV1
//
//  Created by Nikesh Hyanju on 11/21/17.
//  Copyright © 2017 zlesa. All rights reserved.
//

import UIKit
import Photos

class CollectionVC_Image: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    var _selectedCells : NSMutableArray = []
    
   
   
    @IBOutlet weak var imageSelectionView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    var count = 0
    
    var imageArray = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
        check_record_permission()
       
        
        collectionView.allowsMultipleSelection=true
        // Do any additional setup after loading the view.
        func touchesBegan(_ touches: Set<AnyHashable>, with event: UIEvent) {
            var touch: UITouch? = touches.first as! UITouch
            //location is relative to the current view
            // do something with the touched point
            if touch?.view != imageSelectionView {
                print("fmafiafiafainfia")
            }
    }
   
    
    }
    func check_record_permission()
    {
        let status = PHPhotoLibrary.authorizationStatus()
        
        if (status == PHAuthorizationStatus.authorized) {
            grabPhotos()
            self.collectionView.reloadData()
        }
            
        else if (status == PHAuthorizationStatus.denied) {
           print("acess denied")
        }
            
        else if (status == PHAuthorizationStatus.notDetermined) {
            
            // Access has not been determined.
            PHPhotoLibrary.requestAuthorization({ (newStatus) in
                
                if (newStatus == PHAuthorizationStatus.authorized) {
                    self.grabPhotos()
                    
                    self.collectionView.reloadData()
                    
                }
                    
                else {
                    print("acess denied")
                }
            })
            self.collectionView.reloadData()
        }
            
        else if (status == PHAuthorizationStatus.restricted) {
            // Restricted access - normally won't happen.
        }
        
        
    }
   
    func grabPhotos(){
        
        let imageManager = PHImageManager.default()
        
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        requestOptions.deliveryMode = .highQualityFormat
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        if let fetchResult : PHFetchResult = PHAsset.fetchAssets(with:.image, options: fetchOptions){
            if fetchResult.count > 0{
                for i in 0..<fetchResult.count{
                    imageManager.requestImage(for: fetchResult.object(at: i) as! PHAsset, targetSize: CGSize(width : 112, height : 116), contentMode: .aspectFill , options:
                        requestOptions, resultHandler: { (image, error) in
                            self.imageArray.append(image!)
                            
                            
                    })
                }
            }else {
                print("no photos! ")
               self.collectionView.reloadData()
            }
        }
        
    }

     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        //add the selected cell contents to _selectedCells arr when cell is selected
        _selectedCells.add(indexPath)
        collectionView.reloadItems(at: [indexPath])
        count = count + 1
        print("c\(count)")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        //remove the selected cell contents from _selectedCells arr when cell is De-Selected
        
        _selectedCells.remove(indexPath)
        collectionView.reloadItems(at: [indexPath])
        count = count - 1
        print("c\(count)")
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath)
        
        var imageView = cell.viewWithTag(1) as! UIImageView
        imageView.layer.cornerRadius = 5.0
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.clear.cgColor
        imageView.layer.masksToBounds = true
        
        imageView.image = imageArray[indexPath.row]
        
        
        var imageViewTick = cell.viewWithTag(2) as! UIImageView
        
        imageViewTick.image = #imageLiteral(resourceName: "tickoverlay_img")
        
        if _selectedCells.contains(indexPath) {
            cell.isSelected=true
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition.top)
            imageViewTick.isHidden=false
        }
        else{
            cell.isSelected=false
            imageViewTick.isHidden=true
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = 112.2
        let height = 116.7
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(13.3, 14, 7.7, 6.7)
        
    }


    

}
