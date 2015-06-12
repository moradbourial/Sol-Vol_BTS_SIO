//
//  ModifierProfil.swift
//  Sol'Vol_BTS_SIO
//
//  Created by Morad Bourial on 08/06/2015.
//  Copyright (c) 2015 Morad Bourial. All rights reserved.
//

import UIKit

class ModifierProfil: UIViewController,UITextFieldDelegate {


    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var Nom: UITextField!
    @IBOutlet weak var Prenom: UITextField!
    @IBOutlet weak var Ville: UITextField!
    @IBOutlet weak var Adresse: UITextField!
    @IBOutlet weak var CodePostal: UITextField!
    @IBOutlet weak var TElephone: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Valider: UIButton!
    
    
    var NomVc = ""
    var PrenomVc = ""
    var VilleVc = ""
    var AdresseVc = ""
    var CodePostalVc = ""
    var TelephoneVc = ""
    var EmailVc = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "fond.jpg")!)
        
        
        Nom.text = NomVc
        Prenom.text = PrenomVc
        Ville.text = VilleVc
        Adresse.text = AdresseVc
        CodePostal.text = CodePostalVc
        TElephone.text = TelephoneVc
        Email.text = EmailVc
        
        Nom.delegate=self
        Prenom.delegate=self
        Ville.delegate=self
        Adresse.delegate=self
        CodePostal.delegate=self
        TElephone.delegate=self
        Email.delegate=self
        
        
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "hideKeyboard")
        
        // prevents the scroll view from swallowing up the touch event of child buttons
        tapGesture.cancelsTouchesInView = false
        
        scrollView.addGestureRecognizer(tapGesture)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
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
        var buttonOrigin: CGPoint = self.Valider.frame.origin;
        var buttonHeight: CGFloat = self.Valider.frame.size.height;
        var visibleRect: CGRect = self.view.frame
        visibleRect.size.height -= keyboardSize.height
        
        if (!CGRectContainsPoint(visibleRect, buttonOrigin)) {
            var scrollPoint: CGPoint = CGPointMake(0.0, buttonOrigin.y - visibleRect.size.height + buttonHeight + 20)
            self.scrollView.setContentOffset(scrollPoint, animated: true)
            
        }
    }
    
    func hideKeyboard() {
        Nom.resignFirstResponder()
        Prenom.resignFirstResponder()
        Ville.resignFirstResponder()
        Adresse.resignFirstResponder()
        CodePostal.resignFirstResponder()
        TElephone.resignFirstResponder()
        Email.resignFirstResponder()
        self.scrollView.setContentOffset(CGPointZero, animated: true)
    }
    
    
    @IBAction func Modifier(sender: AnyObject) {
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        var user =  prefs.valueForKey("USERNAME") as! NSDictionary
        var userid: String = user.valueForKey("id") as! String
        
        var url : String = ""
        var request : NSMutableURLRequest = NSMutableURLRequest()
        request.URL = NSURL(string: url)
        request.HTTPMethod = "PUT"
        print("avant");
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{ (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            
            var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
            let jsonResult: NSDictionary! = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers, error: error) as? NSDictionary
        })
        
    }
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true;
    }

}
