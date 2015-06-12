//
//  AfficherVol.swift
//  Sol'Vol_BTS_SIO
//
//  Created by Morad Bourial on 06/06/2015.
//  Copyright (c) 2015 Morad Bourial. All rights reserved.
//

import UIKit

class AfficherVol: UIViewController, UITextFieldDelegate{
    var Date: String = ""
    var Depart: String = ""
    var Arriver: String = ""
    var idVol: String = ""
    var placeDemander: String = ""
    

    @IBOutlet weak var DateDep: UILabel!
    @IBOutlet weak var DateArr: UILabel!
    @IBOutlet weak var place: UILabel!
    @IBOutlet weak var prix: UILabel!
    @IBOutlet weak var VilleDep: UILabel!
    @IBOutlet weak var VilleArr: UILabel!
    @IBOutlet weak var divise: UILabel!
    @IBOutlet weak var waiting: UIActivityIndicatorView!
    @IBOutlet weak var nbrPlaceReserv: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        
        nbrPlaceReserv.delegate=self
        self.waiting.startAnimating()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "fond.jpg")!)
        var url : String = "http://api.moradbourial.fr/index.php/vols/search/Londre?depart=\(Depart)&arriver=\(Arriver)&date=\(Date)"
        var request : NSMutableURLRequest = NSMutableURLRequest()
        request.URL = NSURL(string: url)
        request.HTTPMethod = "GET"
        print("avant");
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{ (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            print("dl termine");
            var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
            let jsonResult: NSDictionary! = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers, error: error) as? NSDictionary
//                println(jsonResult.count)
//            if(jsonResult.count > 0){
//                for index in 0...jsonResult.count-1 {
//                    
//                    let utilisateur : AnyObject? = jsonResult[index]
//                    
//                    let info = utilisateur! as! Dictionary<String, AnyObject>
//                    println(info)
//                    
//                }
//            }
//            })
//    }
    
            
            
            
            if (jsonResult != nil) {
                println(jsonResult.count)
                self.idVol = (jsonResult["id_vols"] as? String)!
                self.VilleArr.text = self.Arriver
                self.VilleDep.text = self.Depart
                self.DateDep.text = jsonResult["depart_vols"] as? String
                self.DateArr.text = jsonResult["arrivee_vols"] as? String
                self.place.text = jsonResult["places_dispo_vols"] as? String
                self.prix.text = jsonResult["prix_vols"] as? String
                self.divise.text = "Euro"
                self.waiting.stopAnimating()
                self.waiting.hidesWhenStopped = true
                

                
   
            } else {

                println("Aucun Vol Disponible")
            }
            })
    }
    
            
            

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Reserve(sender: AnyObject) {
        self.placeDemander = nbrPlaceReserv.text
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        var user =  prefs.valueForKey("USERNAME") as! NSDictionary
        var userid: String = user.valueForKey("id") as! String
        
        var url : String = "http://api.moradbourial.fr/index.php/reservation/\(userid)?vols=\(idVol)&place=\(placeDemander))"
        var request : NSMutableURLRequest = NSMutableURLRequest()
        request.URL = NSURL(string: url)
        request.HTTPMethod = "POST"
        print("avant");
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{ (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in

            var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
            let jsonResult: NSDictionary! = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers, error: error) as? NSDictionary
            
          
                
                println("reserver")
        })
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true;
    }


    

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
