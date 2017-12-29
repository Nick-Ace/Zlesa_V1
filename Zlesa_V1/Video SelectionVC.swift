//
//  Video SelectionVC.swift
//  Zlesa_V1
//
//  Created by Nikesh Hyanju on 12/22/17.
//  Copyright © 2017 zlesa. All rights reserved.
//Video_SelectionVC


import UIKit
import Photos

class Video_SelectionVC: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var imageArray = [Any]()
    var _selectedCells : NSMutableArray = []
    var photos: PHFetchResult<PHAsset>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        check_record_permission()
        
        collectionView.allowsMultipleSelection=true
        // 1. create a gesture recognizer (tap gesture)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        
        // 2. add the gesture recognizer to a view
        
        collectionView.backgroundView?.addGestureRecognizer(tapGesture)
    }
    // 3. this method is called when a tap is recognized
    @objc func handleTap(sender: UITapGestureRecognizer) {
        print("eee\tap")
    }
     
   

    func check_record_permission()
    {
        let status = PHPhotoLibrary.authorizationStatus()
        
        if (status == PHAuthorizationStatus.authorized) {
            getAssetFromPhoto()
            self.collectionView.reloadData()
        }
            
        else if (status == PHAuthorizationStatus.denied) {
            print("acess denied")
        }
            
        else if (status == PHAuthorizationStatus.notDetermined) {
            
            // Access has not been determined.
            PHPhotoLibrary.requestAuthorization({ (newStatus) in
                
                if (newStatus == PHAuthorizationStatus.authorized) {
                    self.getAssetFromPhoto()
                    
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
    func getAssetFromPhoto() {
        let options = PHFetchOptions()
        options.sortDescriptors = [ NSSortDescriptor(key: "creationDate", ascending: false) ]
        options.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.video.rawValue)
        photos = PHAsset.fetchAssets(with: options)
        print(photos)
        collectionView.reloadData() // reload your collectionView
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoCell", for: indexPath)
        let asset = photos!.object(at: indexPath.row)
        
       
        PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width : 112, height : 116), contentMode: .aspectFill, options: nil) { (image, userInfo) -> Void in
            var imageView = cell.viewWithTag(1) as! UIImageView
            imageView.layer.cornerRadius = 5.0
            imageView.layer.borderWidth = 1.0
            imageView.layer.borderColor = UIColor.clear.cgColor
            imageView.layer.masksToBounds = true
            imageView.image = image
            let labelView = cell.viewWithTag(2) as! UILabel
            
            
            labelView.text = String(format: "%02d:%02d",Int((asset.duration / 60)),Int(asset.duration) % 60)
            
        }
        
        var imageViewTick = cell.viewWithTag(3) as! UIImageView
        
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
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        //add the selected cell contents to _selectedCells arr when cell is selected
        _selectedCells.add(indexPath)
        collectionView.reloadItems(at: [indexPath])
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        //remove the selected cell contents from _selectedCells arr when cell is De-Selected
        
        _selectedCells.remove(indexPath)
        collectionView.reloadItems(at: [indexPath])
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
