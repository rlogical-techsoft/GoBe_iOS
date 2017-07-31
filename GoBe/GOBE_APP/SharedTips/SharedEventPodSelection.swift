//
//  SharedEventPodSelection.swift
//  GoBe
//
//  Created by rlogical-dev-35 on 29/07/17.
//  Copyright © 2017 rlogical-dev-35. All rights reserved.
//

import UIKit

class SharedEventPodSelection: UIViewController {

    var str_visibility : NSString?
    var str_Address : NSString?

    var Dict_SharedEvent : NSDictionary!

    @IBOutlet weak var Event_image: UIImageView!
    
    @IBOutlet weak var lbl_visibility: UILabel!
    @IBOutlet weak var lbl_inspiring: UILabel!
    @IBOutlet weak var lbl_practical: UILabel!
    @IBOutlet weak var lbl_Fun: UILabel!
    @IBOutlet weak var lbl_address: UILabel!
    @IBOutlet weak var txtview_Title: UITextView!
    
    @IBOutlet weak var txtview_Descr: UITextView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        lbl_inspiring.transform = CGAffineTransform(rotationAngle:-120.2)
        lbl_practical.transform = CGAffineTransform(rotationAngle:-43.2)
        
        lbl_visibility.text = str_visibility! as String
        lbl_address.text = str_Address! as String
        
        self.setDataonDisplay()
        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        txtview_Descr.textContainerInset = UIEdgeInsets(top: 15,left: 0,bottom: 0,right: 0)
        txtview_Descr.textContainer.lineFragmentPadding = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Common Method
    func setDataonDisplay()
    {
        txtview_Title.text=Dict_SharedEvent?.value(forKey: "EventTitle") as! String
        txtview_Descr.text=Dict_SharedEvent?.value(forKey: "EventDescription") as! String
        Event_image.image=Dict_SharedEvent?.value(forKey: "EventImage") as? UIImage
    }

    @IBAction func btn_BackClick(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)

    }
    @IBAction func btn_SeePreviewClick(_ sender: Any) {
        
        let move = self.storyboard?.instantiateViewController(withIdentifier: "EventPostPreviewViewController") as! EventPostPreviewViewController
        move.str_visibility = str_visibility
        move.Dict_SharedEvent = Dict_SharedEvent
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
