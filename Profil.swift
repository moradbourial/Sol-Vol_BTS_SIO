//
//  Profil.swift
//  Sol'Vol_BTS_SIO
//
//  Created by Morad Bourial on 07/06/2015.
//  Copyright (c) 2015 Morad Bourial. All rights reserved.
//

import UIKit

class Profil: UIViewController {

    @IBOutlet weak var nom: UILabel!
    @IBOutlet weak var prenom: UILabel!
    @IBOutlet weak var ville: UILabel!
    @IBOutlet weak var adresse: UILabel!
    @IBOutlet weak var cp: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var waiting: UIActivityIndicatorView!
    @IBOutlet weak var labelChargement: UILabel!
    var NomVc = ""
    var PrenomVc = ""
    var VilleVc = ""
    var AdresseVc = ""
    var CodePostalVc = ""
    var TelephoneVc = ""
    var EmailVc = ""


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        var user =  prefs.valueForKey("USERNAME") as! NSDictionary
        var userid: String = user.valueForKey("id") as! String
        
        self.waiting.startAnimating()
        self.labelChargement.hidden = false
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "fond.jpg")!)
        
        
        
        var url : String = "http://api.moradbourial.fr/index.php/clients/\(userid)"
        var request : NSMutableURLRequest = NSMutableURLRequest()
        request.URL = NSURL(string: url)
        request.HTTPMethod = "GET"
        print("avant");
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{ (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            print("dl termine");
            var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
            let jsonResult: NSDictionary! = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers, error: error) as? NSDictionary
            
            if (jsonResult != nil) {
                self.nom.text = jsonResult["nom_clients"] as? String
                self.NomVc = (jsonResult["nom_clients"] as? String)!
                self.prenom.text = jsonResult["prenom_clients"] as? String
                self.PrenomVc = (jsonResult["prenom_clients"] as? String)!
                self.ville.text = jsonResult["ville_clients"] as? String
                self.VilleVc = (jsonResult["ville_clients"] as? String)!
                self.adresse.text = jsonResult["adresse_clients"] as? String
                self.AdresseVc = (jsonResult["adresse_clients"] as? String)!
                self.cp.text = jsonResult["cp_clients"] as? String
                self.CodePostalVc = (jsonResult["cp_clients"] as? String)!
                self.phone.text = jsonResult["tel_clients"] as? String
                self.TelephoneVc = (jsonResult["tel_clients"] as? String)!
                self.email.text = jsonResult["mail_clients"] as? String
                self.EmailVc = (jsonResult["mail_clients"] as? String)!
                self.waiting.stopAnimating()
                self.waiting.hidesWhenStopped = true
                self.labelChargement.hidden = true
                
            }else{
                println("json vide")
            }
            print("parsing termine");
            
        })
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender:AnyObject?)
    {
        if segue.identifier == "Edite" {
            var SecondVC:ModifierProfil = segue.destinationViewController as! ModifierProfil
            SecondVC.NomVc = NomVc
            SecondVC.PrenomVc = PrenomVc
            SecondVC.VilleVc = VilleVc
            SecondVC.AdresseVc = AdresseVc
            SecondVC.CodePostalVc = CodePostalVc
            SecondVC.TelephoneVc = TelephoneVc
            SecondVC.EmailVc = EmailVc
        }
    }
}
