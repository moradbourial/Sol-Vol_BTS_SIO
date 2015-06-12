//
//  NewPassword.swift
//  Sol'Vol_BTS_SIO
//
//  Created by Morad Bourial on 08/06/2015.
//  Copyright (c) 2015 Morad Bourial. All rights reserved.
//

import UIKit

class NewPassword: UIViewController, UITextFieldDelegate {
    
    

    @IBOutlet weak var Pass: UITextField!
    @IBOutlet weak var CPass: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var Valider: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "fond.jpg")!)
        
        Pass.delegate=self
        CPass.delegate=self
        
        
    }
    
        
    @IBAction func Modifier(sender: AnyObject) {
        
    }
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true;
    }
    
}


