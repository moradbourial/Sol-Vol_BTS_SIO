//
//  NewAccount.swift
//  Sold'Vols
//
//  Created by Morad Bourial on 31/03/2015.
//  Copyright (c) 2015 Morad Bourial. All rights reserved.
//

import UIKit

class NewAccount: UIViewController {

    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var TextUsername: UITextField!
    @IBOutlet weak var TextPassword: UITextField!
    @IBOutlet weak var TextPassword2: UITextField!
    @IBOutlet weak var signin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "fond.jpg")!)
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "hideKeyboard")
        
        // prevents the scroll view from swallowing up the touch event of child buttons
        tapGesture.cancelsTouchesInView = false
        
        scrollView.addGestureRecognizer(tapGesture)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.registerForKeyboardNotifications()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.deregisterFromKeyboardNotifications()
        super.viewWillDisappear(true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    //MARK: Keyboard Avoidance
    func registerForKeyboardNotifications() -> Void {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardWillShowNotification, object: nil)
        
    }
    
    func deregisterFromKeyboardNotifications() -> Void {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardDidHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardWillHideNotification, object: nil)
        
    }
    
    func keyboardWasShown(notification: NSNotification) {
        var info: Dictionary = notification.userInfo!
        var keyboardSize: CGSize = (info[UIKeyboardFrameBeginUserInfoKey]?.CGRectValue().size)!
        var buttonOrigin: CGPoint = self.signin.frame.origin;
        var buttonHeight: CGFloat = self.signin.frame.size.height;
        var visibleRect: CGRect = self.view.frame
        visibleRect.size.height -= keyboardSize.height
        
        if (!CGRectContainsPoint(visibleRect, buttonOrigin)) {
            var scrollPoint: CGPoint = CGPointMake(0.0, buttonOrigin.y - visibleRect.size.height + buttonHeight + 4)
            self.scrollView.setContentOffset(scrollPoint, animated: true)
            
        }
    }
    
    func hideKeyboard() {
        TextUsername.resignFirstResponder()
        TextPassword.resignFirstResponder()
        TextPassword2.resignFirstResponder()
        self.scrollView.setContentOffset(CGPointZero, animated: true)
    }
    

    
    @IBAction func signinTapped(sender: AnyObject) {
        
        var username:NSString = TextUsername.text
        var password:NSString = TextPassword.text
        var password2:NSString = TextPassword2.text
        
        if ( username.isEqualToString("") || password.isEqualToString("")) {
            
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Échec!"
            alertView.message = "Nom Utilisateur/Mot de Passe vide!"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        }else if(password != password2){
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Echec!"
            alertView.message = "Mot de Passe est différent!"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
            
        }else {
            
            
            
            var url:NSURL = NSURL(string:"http://moradbourial.fr/script_mobile/newaccount.php?mail=\(username)&password=\(password)")!
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Compte Créer!"
            alertView.message = "Vous pouvez vous connecter!"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
            self.performSegueWithIdentifier("connection", sender: self)
            
        }
    }
    @IBAction func Account(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }


}
