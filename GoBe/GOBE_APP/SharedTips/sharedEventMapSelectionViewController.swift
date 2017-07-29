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

    var str_visibility : NSString?
    
    @IBOutlet weak var lbl_visibility: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        lbl_visibility.text = str_visibility as String?
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
