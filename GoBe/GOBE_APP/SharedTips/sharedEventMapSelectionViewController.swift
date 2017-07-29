//
//  sharedEventMapSelectionViewController.swift
//  GoBe
//
//  Created by rlogical-dev-35 on 28/07/17.
//  Copyright © 2017 rlogical-dev-35. All rights reserved.
//

import UIKit

class sharedEventMapSelectionViewController: UIViewController
{

    //MARK: variable
    var str_visibility : NSString?
    var Dict_SharedEvent : NSDictionary!

    //MARK: IBOUTLETS
    
    @IBOutlet weak var imageview_Event: UIImageView!
    @IBOutlet weak var txtview_Description: UITextView!
    @IBOutlet weak var txtview_EventTitle: UITextView!

    @IBOutlet weak var lbl_visibility: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        lbl_visibility.text = str_visibility as String?
        self.setDataonDisplay()
        
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        txtview_Description.textContainerInset = UIEdgeInsets(top: 15,left: 0,bottom: 0,right: 0)
        txtview_Description.textContainer.lineFragmentPadding = 0
    }

    // MARK: - Common Method
    func setDataonDisplay()
    {
        txtview_EventTitle.text=Dict_SharedEvent?.value(forKey: "EventTitle") as! String
        txtview_Description.text=Dict_SharedEvent?.value(forKey: "EventDescription") as! String
        imageview_Event.image=Dict_SharedEvent?.value(forKey: "EventImage") as? UIImage
    }

    @IBAction func btn_BackClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btn_LocateMap(_ sender: Any)
    {
        let move = self.storyboard?.instantiateViewController(withIdentifier: "SharedTipsSearchLocViewController") as! SharedTipsSearchLocViewController
        move.str_visibility = str_visibility
        move.Dict_SharedEvent = Dict_SharedEvent
        self.navigationController?.pushViewController(move, animated: true)
    }
    
    @IBAction func btn_donNeedMapClick(_ sender: Any) {
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
