//
//  StartANewListViewController.swift
//  GoBe
//
//  Created by rlogical-dev-35 on 27/07/17.
//  Copyright © 2017 rlogical-dev-35. All rights reserved.
//

import UIKit

class StartANewListViewController: UIViewController {

    @IBOutlet weak var btn_Private: UIButton!
    @IBOutlet weak var btn_Public: UIButton!
    @IBOutlet weak var btn_friends: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Button Tap Event
    
    @IBAction func btn_BackClick(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btn_OkClick(_ sender: Any) {
    }
    @IBAction func btn_HomeClick(_ sender: Any) {
        
    }

    @IBAction func btn_PublicClick(_ sender: Any) {
        
        btn_Private.isSelected = false
        btn_Public.isSelected = true
        btn_friends.isSelected = false
        

    }
    @IBAction func btn_FriendsClick(_ sender: Any) {
        
        btn_Private.isSelected = false
        btn_Public.isSelected = false
        btn_friends.isSelected = true

    }
    @IBAction func btn_PrivateClick(_ sender: Any) {
        
        btn_Private.isSelected = true
        btn_Public.isSelected = false
        btn_friends.isSelected = false

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
