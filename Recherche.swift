//
//  Recherche.swift
//  Sol'Vol_BTS_SIO
//
//  Created by Morad Bourial on 06/06/2015.
//  Copyright (c) 2015 Morad Bourial. All rights reserved.
//

import UIKit

class Recherche: UIViewController,UITextFieldDelegate {


    @IBOutlet weak var Depart: UITextField!
    @IBOutlet weak var Arriver: UITextField!
    @IBOutlet weak var Jour: UITextField!
    @IBOutlet weak var Mois: UITextField!
    @IBOutlet weak var Annee: UITextField!



    var VilleDep = ""
    var VilleArr = ""
    var DateDep = ""
    var ClassType = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "fond.jpg")!)
        Depart.delegate=self
        Arriver.delegate=self
        Jour.delegate=self
        Mois.delegate=self
        Annee.delegate=self
        
        


    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true;
    }
    
    

    
    @IBAction func Recherche(sender: AnyObject) {
        VilleDep = Depart.text
        VilleArr = Arriver.text
        DateDep = Annee.text + "-" + Mois.text + "-" + Jour.text
        
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender:AnyObject?)
    {
        var SecondVC:AfficherVol = segue.destinationViewController as! AfficherVol
        SecondVC.Date = DateDep
        SecondVC.Depart = VilleDep
        SecondVC.Arriver = VilleArr
    }

}
