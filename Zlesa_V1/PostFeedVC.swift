//
//  PostFeedVC.swift
//  ZlesaV1
//
//  Created by Nikesh Hyanju on 11/21/17.
//  Copyright © 2017 zlesa. All rights reserved.
//

import UIKit

class PostFeedVC: UIViewController, UITextViewDelegate {
    
    var heightOfKeyboard : CGFloat = 0
    var buttonPictureClicked : Bool = false
    @IBOutlet weak var buttonSend: UIButton!
    //@IBOutlet weak var buttonImageSend: UIButton!
    
    @IBOutlet weak var bottomConstraints: NSLayoutConstraint!
   
    @IBOutlet weak var selectionView: UIView!
    
    
   
    @IBOutlet weak var viewTypingSpace: UIView!
    @IBOutlet weak var viewAllPostFeed: UIView!
    @IBOutlet weak var textViewTypingSpace: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        selectionView.isHidden = true
        //adding keyboard listner
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        viewTypingSpace.layer.cornerRadius = 5
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        textViewTypingSpace.delegate = self
        //buttonImageSend.isHidden = true
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool{
        if (textView.contentSize.height < 150){
            textView.isScrollEnabled = false
        }
        else{
            textView.isScrollEnabled = true
        }
        return true
    }
    
    @objc  func keyboardWillShow(notification:NSNotification) {
        if let info = notification.userInfo {
            
            let rect:CGRect = info["UIKeyboardFrameEndUserInfoKey"] as! CGRect
            
            
            heightOfKeyboard = rect.height
            
            self.view.layoutIfNeeded()
            
            UIView.animate(withDuration: 0, delay: 0, options: .transitionFlipFromTop, animations: {
                self.bottomConstraints.constant = self.heightOfKeyboard
                
            }, completion: nil)
            
           self.selectionView.isHidden = true
            
        }
       
    }
    @objc func keyboardWillHide(notification:NSNotification) {
        if let info = notification.userInfo {
            
            let rect:CGRect = info["UIKeyboardFrameEndUserInfoKey"] as! CGRect
            
            UIView.animate(withDuration: 0, animations: {
                
                self.bottomConstraints.constant = 0
               
                
            })
            
      
    }

    
}
    @IBAction func buttonPicture(_ sender: Any) {
       
        self.view.endEditing(true)
        
        self.bottomConstraints.constant = 267.1
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "imageCollection")
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
            buttonPictureClicked = true
        
        
    }
    @IBAction func buttonVideo(_ sender: Any) {
        self.view.endEditing(true)
        
        self.bottomConstraints.constant = 267.1
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
    
    @IBAction func buttonVoiceRecord(_ sender: Any) {
        self.view.endEditing(true)
        
        self.bottomConstraints.constant = 267.1
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
    
    @IBAction func expandTypingSpace(_ sender: Any) {
         print("Hello")
//        UIView.animate(withDuration: 0, animations: {
//            //self.bonacinno.frame.size.width += 10
//            self.textViewTypingSpace.frame.size.height += 10
//             self.viewAllPostFeed.frame.size.height += 10
//             self.viewTypingSpace.frame.size.height += 10
//            
//        }, completion: nil)
                
        
        
    }
    
   
        
}
