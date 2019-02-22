//
//  UserVC.swift
//  GrinChallenge
//
//  Created by Stephane Gardon on 2/21/19.
//  Copyright © 2019 Stephane Gardon. All rights reserved.
//

import UIKit

class UserVC: UIViewController {

    @IBOutlet weak var textView: UITextView!
    var originalContainerFrame: CGRect?
    var viewMoved = false
    var cells = ["ITEM1","ITEM2","ITEM3"]
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        textView.delegate = self
        
        originalContainerFrame = self.parent?.view.frame
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        self.collectionView.register( UINib(nibName: "UserCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UserCollectionViewCell")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObserverKeyboard()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObserverKeyboard()
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func addObserverKeyboard(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name:  UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name:  UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeObserverKeyboard(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
//    func setAvatar(miImagen: Dictionary<String, Any>){
//
//        let dto = miImagen["ImagenAvatarURL"]
//        UserSettings.setAvatar(avatar: dto as? String)
//        if UserSettings.getAvatar() != nil{
//            self.cambioImage()
//            imgUser.image = miAvatar
//        }else{
//            imgUser.image = UIImage(named: UserSettings.getAvatar()!)
//        }
//    }
    
    //Mark: Keyboard Functionality
    
    @objc func keyboardWillShow(notification: NSNotification) {
        var info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        if textView!.frame.midY > (keyboardFrame.minY - 30) {
            var newFrame = self.parent?.view.frame
            newFrame!.origin.y = (keyboardFrame.minY - 30) - textView!.frame.midY
                - 50
            viewMoved = true
            
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                self.parent?.view.frame = newFrame!
                self.parent?.view.layoutIfNeeded()
            })
            
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if viewMoved == true {
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                self.parent?.view.frame = self.originalContainerFrame!
            })
            viewMoved = false
        }
    }

}
extension UserVC:UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        let origHeight = textView.frame.size.height
        
        let fixedWidth = textView.frame.size.width
        textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        var newFrame = textView.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        textView.frame = newFrame
        
        let diff = newFrame.size.height - origHeight
        if  diff > 0 {
            var newFrameP = self.parent?.view.frame
            newFrameP!.origin.y = newFrameP!.origin.y - 15
            viewMoved = true
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                self.parent?.view.frame = newFrameP!
                self.parent?.view.layoutIfNeeded()
            })
        }else if diff < 0{
            var newFrameP = self.parent?.view.frame
            newFrameP!.origin.y = newFrameP!.origin.y + 15
            viewMoved = true
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                self.parent?.view.frame = newFrameP!
                self.parent?.view.layoutIfNeeded()
            })
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.resignFirstResponder()
    }
}

extension UserVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cellUser: UserCollectionViewCell!
        cellUser = collectionView.dequeueReusableCell(withReuseIdentifier: "UserCollectionViewCell", for: indexPath) as! UserCollectionViewCell

        return cellUser
    }
    
}

extension UserVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item + 1)
    }
}
