//
//  selectedImageCollectionViewVC.swift
//  Zlesa_V1
//
//  Created by Nikesh Hyanju on 1/3/18.
//  Copyright © 2018 zlesa. All rights reserved.
//

import UIKit

class selectedImageCollectionViewVC: UIViewController {

    @IBOutlet weak var collectionViewImageSelected: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
       NotificationCenter.default.addObserver(self, selector: #selector(loadList), name:NSNotification.Name(rawValue: "load"), object: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func loadList(notification: NSNotification){
        self.collectionViewImageSelected.reloadData()
    }

}
extension selectedImageCollectionViewVC : UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
}
extension selectedImageCollectionViewVC : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellTest", for: indexPath)
        
        return cell
    }
    
}
extension selectedImageCollectionViewVC : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = 77.4
        let height = 80.6
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10.6, 9.2, 9.7, 4.6)// top left bottom right
        
        
    }
    
}

