//
//  InfoReservation.swift
//  Sol'Vol_BTS_SIO
//
//  Created by Morad Bourial on 11/06/2015.
//  Copyright (c) 2015 Morad Bourial. All rights reserved.
//

import UIKit

class InfoReservation: UIViewController {
    var rowTitle = ""
    var rowDateReservation = ""
    
    @IBOutlet weak var NumVol: UILabel!
    @IBOutlet weak var DepartVol: UILabel!
    @IBOutlet weak var ArriverVol: UILabel!
    @IBOutlet weak var DateHeureVol: UILabel!
    @IBOutlet weak var DateHeureVolArri: UILabel!
    @IBOutlet weak var EtatReservation: UILabel!
    @IBOutlet weak var NbrPlace: UILabel!
    @IBOutlet weak var Prix: UILabel!
    
    func condenseWhitespace(string: String) -> String {
        let components = string.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).filter({!isEmpty($0)})
        return join("", components)
    }




    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "fond.jpg")!)
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        var user =  prefs.valueForKey("USERNAME") as! NSDictionary
        var userid: String = user.valueForKey("id") as! String

        
        
        
        var url : String = "http://api.moradbourial.fr/index.php/reservation/info/1?id_vols=1&date_reservation=\(condenseWhitespace(rowDateReservation))"
        var request : NSMutableURLRequest = NSMutableURLRequest()
        request.URL = NSURL(string: url)
        request.HTTPMethod = "GET"
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{ (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            
            var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
            let jsonResult: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers, error: error) as AnyObject!
            println(jsonResult)

            if let jsonDict = jsonResult as? NSDictionary {
                if let address = jsonDict["id_vols"] as? NSDictionary {
                    var test = address as AnyObject? as? String
                    println(test)
                    }
            }
            

        })


        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
