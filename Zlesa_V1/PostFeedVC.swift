//
//  PostFeedVC.swift
//  ZlesaV1
//
//  Created by Nikesh Hyanju on 11/21/17.
//  Copyright © 2017 zlesa. All rights reserved.
//

import UIKit

class PostFeedVC: UIViewController{
    
    var heightOfKeyboard : CGFloat = 0
    var constantForTopConstraint = 0.0
 var constantForHeightConstraint = 0.0
     let myView = UIView()
    var buttonPictureClicked : Bool = false
    @IBOutlet weak var buttonSend: UIButton!
    @IBOutlet weak var topConstraints: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraints: NSLayoutConstraint!
   
    @IBOutlet weak var constraintsViewTypingSpaceTop: NSLayoutConstraint!
    
    @IBOutlet weak var constraintsTextViewHeight: NSLayoutConstraint!
    @IBOutlet weak var costraintsTextViewbottom: NSLayoutConstraint!
    @IBOutlet weak var constraintsHeightTypingSpace: NSLayoutConstraint!
    @IBOutlet weak var topConstraintsMainView: NSLayoutConstraint!
    
    
    @IBOutlet weak var viewLine: UIView!
    @IBOutlet weak var selectionView: UIView!
    @IBOutlet weak var viewWithEverything: UIView!
    @IBOutlet weak var viewTypingSpace: UIView!
    @IBOutlet weak var viewAllPostFeed: UIView!
    @IBOutlet weak var textViewTypingSpace: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        constantForHeightConstraint = Double(self.constraintsTextViewHeight.constant)
        constantForTopConstraint = Double(topConstraintsMainView.constant)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        self.view.removeConstraint(self.constraintsHeightTypingSpace)
        selectionView.isHidden = true
        //adding keyboard listner
        addListener()
        
        viewTypingSpace.layer.cornerRadius = 5
        
        textViewTypingSpace.delegate = self
        self.view.removeConstraint(self.costraintsTextViewbottom)
        
    }
   
    func addListener(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
   

    
    @objc  func keyboardWillShow(notification:NSNotification) {
        if let info = notification.userInfo {
            
            let rect:CGRect = info["UIKeyboardFrameEndUserInfoKey"] as! CGRect
            
            
            heightOfKeyboard = rect.height
            
            self.view.layoutIfNeeded()
            
            UIView.animate(withDuration: 0, delay: 0, options: .beginFromCurrentState, animations: {
                self.bottomConstraints.constant = self.heightOfKeyboard
                self.view.layoutIfNeeded()
                
            }, completion: nil)
            
           self.selectionView.isHidden = true
            
        }
       
    }
    
    @objc func keyboardWillHide(notification:NSNotification) {
        if let info = notification.userInfo {
            
            let rect:CGRect = info["UIKeyboardFrameEndUserInfoKey"] as! CGRect
            
            UIView.animate(withDuration: 0, animations: {
                
                self.bottomConstraints.constant = 0
                self.view.layoutIfNeeded()
               
                
            })
            
      
    }

    
}
    
    @IBAction func buttonPicture(_ sender: Any) {
       
      self.view.endEditing(true)
         self.bottomConstraints.constant = 267.1
        UIView.animate(withDuration: 0.5, delay: 0, options: .transitionFlipFromBottom, animations: {
            
            let controller = self.storyboard!.instantiateViewController(withIdentifier: "imageCollection")
            //controller.ANYPROPERTY=THEVALUE // If you want to pass value
            controller.view.frame = self.selectionView.bounds;
            //controller.willMove(toParentViewController: self)
            self.selectionView.addSubview(controller.view)
            self.addChildViewController(controller)
            self.view.layoutIfNeeded()
        }, completion: nil)
    
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
        if buttonPictureClicked == false {
         self.view.removeConstraint(self.costraintsTextViewbottom)
        
        self.view.addConstraint(self.constraintsTextViewHeight)
        
       
        self.view.layoutIfNeeded()
        
        self.textViewTypingSpace.becomeFirstResponder()
       
       
        animateExpand()
        
        addViewSelectedStuff()
                print(self.viewTypingSpace.frame.height)
        self.constraintsTextViewHeight.constant = self.viewTypingSpace.frame.height - 100.8
        self.view.removeConstraint(self.constraintsTextViewHeight)
            let controller = self.storyboard!.instantiateViewController(withIdentifier: "selectedImageCollection")
            //controller.ANYPROPERTY=THEVALUE // If you want to pass value
            controller.view.frame = myView.bounds;
            //controller.willMove(toParentViewController: self)
            self.myView.addSubview(controller.view)
            self.addChildViewController(controller)
            self.view.layoutIfNeeded()
        
        buttonPictureClicked = true
        
        }else {
           
        }

        }
    func animateExpand() {
        self.viewLine.isHidden = true
        UIView.animate(withDuration: 1, delay: 0, options:.transitionFlipFromBottom, animations: {
            self.view.addConstraint(self.topConstraintsMainView)
            self.topConstraintsMainView.constant = 25.3
            
            //self.constraintsTextViewHeight.constant = self.viewTypingSpace.frame.height - 100.8
            self.view.layoutIfNeeded()
            self.viewWithEverything.layer.cornerRadius = 10
            if #available(iOS 11.0, *) {
                self.viewWithEverything.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            } else {
                // Fallback on earlier versions
            }
            //self.viewTypingSpace.layer.borderWidth = 0
            
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func  addViewSelectedStuff()  {
       
        myView.tag = 100
        myView.backgroundColor = UIColor.red
        self.viewTypingSpace.addSubview(myView)
        
        myView.translatesAutoresizingMaskIntoConstraints = false
        
        let leadingConstraint = NSLayoutConstraint(item: myView, attribute: .left, relatedBy: .equal, toItem: viewWithEverything, attribute: .left, multiplier: 1.0, constant: 10.5)
        let topConstraint = NSLayoutConstraint(item: myView, attribute: .bottom, relatedBy: .equal, toItem: viewTypingSpace, attribute: .bottom, multiplier: 1.0, constant: 0)
        //let trailingConstraint = NSLayoutConstraint(item: myView, attribute: .right, relatedBy: .equal, toItem: viewWithEverything, attribute: .right, multiplier: 1.0, constant: 30)
        let heightConstraint = NSLayoutConstraint(item: myView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100.0)
        let widthConstraint = NSLayoutConstraint(item: myView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: viewTypingSpace.frame.width)
        
        view.addConstraints([topConstraint, leadingConstraint, heightConstraint, widthConstraint])
    }
        
    }
extension PostFeedVC : UITextViewDelegate {
 
    
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
}
extension CALayer {
    
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer()
        
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: thickness)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect.init(x: 0, y: frame.height - thickness, width: frame.width, height: thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect.init(x: 0, y: 0, width: thickness, height: frame.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect.init(x: frame.width - thickness, y: 0, width: thickness, height: frame.height)
            break
        default:
            break
        }
        
        border.backgroundColor = color.cgColor;
        
        self.addSublayer(border)
    }
}


