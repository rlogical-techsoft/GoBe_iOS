//
//  sharedTipsVisibilityViewController.swift
//  GoBe
//
//  Created by rlogical-dev-35 on 28/07/17.
//  Copyright © 2017 rlogical-dev-35. All rights reserved.
//

import UIKit

class sharedTipsVisibilityViewController: UIViewController
{
    @IBOutlet weak var imageview_Event: UIImageView!
    var Dict_SharedEvent : NSDictionary!
    
    @IBOutlet weak var txtview_EventDescription: UITextView!
    @IBOutlet weak var txtview_EventTitle: UITextView!
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Set DisplayData..
        txtview_EventTitle.text=Dict_SharedEvent?.value(forKey: "EventTitle") as! String
        txtview_EventDescription.text=Dict_SharedEvent?.value(forKey: "EventDescription") as! String
        imageview_Event.image=Dict_SharedEvent?.value(forKey: "EventImage") as? UIImage

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Button tap Event
    
    @IBAction func btn_publicClick(_ sender: Any) {
        
        let move = self.storyboard?.instantiateViewController(withIdentifier: "sharedEventMapSelectionViewController") as! sharedEventMapSelectionViewController
        move.str_visibility = "PUBLIC"
        self.navigationController?.pushViewController(move, animated: true)
    }
    @IBAction func btn_FriendsClick(_ sender: Any) {
        let move = self.storyboard?.instantiateViewController(withIdentifier: "sharedEventMapSelectionViewController") as! sharedEventMapSelectionViewController
        move.str_visibility = "FRIENDS"
        self.navigationController?.pushViewController(move, animated: true)
    }
    @IBAction func btn_PrivateClick(_ sender: Any) {
        let move = self.storyboard?.instantiateViewController(withIdentifier: "sharedEventMapSelectionViewController") as! sharedEventMapSelectionViewController
        move.str_visibility = "PRIVATE"
        self.navigationController?.pushViewController(move, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}