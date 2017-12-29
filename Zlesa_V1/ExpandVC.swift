//
//  ExpandVC.swift
//  ZlesaV1
//
//  Created by Nikesh Hyanju on 12/8/17.
//  Copyright © 2017 zlesa. All rights reserved.
//

import UIKit

class ExpandVC: UIViewController {
    var heightOfKeyboard : CGFloat = 0

    @IBOutlet weak var viewWithTextView: UIView!
    @IBOutlet weak var viewSelectedToUpload: UIView!
    @IBOutlet weak var selectionView: UIView!
    @IBOutlet weak var textfield: UITextView!
    @IBOutlet weak var constraintsTop: NSLayoutConstraint!
    @IBOutlet weak var constraintsBottom: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        selectionView.isHidden = true
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
        textfield.becomeFirstResponder()
        viewWithTextView.clipsToBounds = true
        viewWithTextView.layer.cornerRadius = 10
        if #available(iOS 11.0, *) {
            viewWithTextView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        } else {
           
        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
        let path = UIBezierPath(roundedRect:viewWithTextView.bounds,
                                byRoundingCorners:[.topRight, .topLeft],
                                cornerRadii: CGSize(width: 20, height:  20))
        
        let maskLayer = CAShapeLayer()
        
        maskLayer.path = path.cgPath
        viewWithTextView.layer.mask = maskLayer

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc  func keyboardWillShow(notification:NSNotification) {
        if let info = notification.userInfo {
            
            let rect:CGRect = info["UIKeyboardFrameEndUserInfoKey"] as! CGRect
            
            
            heightOfKeyboard = rect.height
            
            self.view.layoutIfNeeded()
            
            UIView.animate(withDuration: 0, delay: 0, options: .transitionFlipFromTop, animations: {
                self.constraintsBottom.constant = self.heightOfKeyboard
                
            }, completion: nil)
            self.constraintsTop.constant = 22.1
            
        }
        
    }
    @objc func keyboardWillHide(notification:NSNotification) {
        if let info = notification.userInfo {
            
            let rect:CGRect = info["UIKeyboardFrameEndUserInfoKey"] as! CGRect
            
           
                
                self.constraintsBottom.constant = 0
                self.constraintsTop.constant = self.constraintsTop.constant + self.heightOfKeyboard
                
            
            
            
        }
        
        
    }
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func buttonExpand(_ sender: Any) {
        self.view.endEditing(true)
       
        
    }
    @IBAction func buttonImageSelect(_ sender: Any) {
        self.view.endEditing(true)
        
        self.constraintsBottom.constant = 267.1
       self.constraintsTop.constant = 25.2
        
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "imageCollection")

        controller.view.frame = self.selectionView.bounds
        //controller.willMove(toParentViewController: self)
        UIView.animate(withDuration: 2, delay: 2, options: .curveEaseOut, animations: {
            self.selectionView.addSubview(controller.view)
            self.addChildViewController(controller)
        }, completion: nil)

        
        
      
        self.selectionView.isHidden = false
        
        
    }
   
    @IBAction func buttonVideoSelect(_ sender: Any) {
        self.view.endEditing(true)
        self.constraintsBottom.constant = 267.1
        self.constraintsTop.constant = 25.2
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "videoCollection")
        //controller.ANYPROPERTY=THEVALUE // If you want to pass value
        controller.view.frame = self.selectionView.bounds;
        //controller.willMove(toParentViewController: self)
        UIView.animate(withDuration: 2, delay: 2, options: .curveEaseOut, animations: {
            self.selectionView.addSubview(controller.view)
            self.addChildViewController(controller)
        }, completion: nil)
        
        
        
        //controller.didMove(toParentViewController: self)
        //buttonSend.isHidden = true
        //buttonImageSend.isHidden = false
        self.selectionView.isHidden = false
       
    }
    @IBAction func buttonAudioSelect(_ sender: Any) {
        self.view.endEditing(true)
        self.constraintsBottom.constant = 267.1
        self.constraintsTop.constant = 25.2
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "Recorder")
        //controller.ANYPROPERTY=THEVALUE // If you want to pass value
        controller.view.frame = self.selectionView.bounds;
        //controller.willMove(toParentViewController: self)
        UIView.animate(withDuration: 2, delay: 2, options: .curveEaseOut, animations: {
            self.selectionView.addSubview(controller.view)
            self.addChildViewController(controller)
        }, completion: nil)
        
        
        
        //controller.didMove(toParentViewController: self)
        //buttonSend.isHidden = true
        //buttonImageSend.isHidden = false
        self.selectionView.isHidden = false
    }
    
}


