//
//  Reservation.swift
//  Sol'Vol_BTS_SIO
//
//  Created by Morad Bourial on 10/06/2015.
//  Copyright (c) 2015 Morad Bourial. All rights reserved.
//

import UIKit

class Reservation: UIViewController, UITableViewDelegate, UITableViewDataSource{
    

    var path = NSIndexPath()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var labelChargement: UILabel!
    @IBOutlet weak var waiting: UIActivityIndicatorView!
    var Num:[String] = []
    var Date:[String] = []
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.waiting.startAnimating()
        self.labelChargement.hidden = false
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "fond.jpg")!)
        var nib = UINib(nibName: "CellRes", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "cell")

        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        var user =  prefs.valueForKey("USERNAME") as! NSDictionary
        var userid: String = user.valueForKey("id") as! String
        
        var url : String = "http://api.moradbourial.fr/index.php/reservation/\(userid)"
        var request : NSMutableURLRequest = NSMutableURLRequest()
        request.URL = NSURL(string: url)
        request.HTTPMethod = "GET"
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{ (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            
            var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
            let jsonResult: NSArray! = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers, error: error) as? NSArray
            
            if let json = jsonResult as? Array<AnyObject> {
                if(json.count > 0){
                    for index in 0...json.count-1 {

                        
                        let reservation : AnyObject? = json[index]
                        let info = reservation as! Dictionary<String, AnyObject>
                        
                        var DateRes = info["date_reservation"] as AnyObject? as! String
                        var NumRes = info["id_vols"] as AnyObject? as! String
                        

                        self.Num.append(NumRes)
                        self.Date.append(DateRes)
                        self.tableView.reloadData()
                        self.waiting.stopAnimating()
                        self.waiting.hidesWhenStopped = true
                        self.labelChargement.hidden = true
                        


                        
                    }
                }
            }
    })
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Num.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:TblRes = self.tableView.dequeueReusableCellWithIdentifier("cell") as! TblRes
        
        cell.Num.text = Num[indexPath.row]
        cell.Date.text = Date[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            Num.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var dest = segue.destinationViewController as! InfoReservation
        let indexPath = self.tableView.indexPathForSelectedRow()
        dest.rowTitle = self.Num[indexPath!.row]
        dest.rowDateReservation = self.Date[indexPath!.row]
    }

}
