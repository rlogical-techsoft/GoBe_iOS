//
//  TipsAddToListViewController.swift
//  GoBe
//
//  Created by rlogical-dev-35 on 26/07/17.
//  Copyright © 2017 rlogical-dev-35. All rights reserved.
//

import UIKit

class TipsAddToListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tblTipsList: UITableView!
    
    @IBOutlet weak var view_tipAdded: UIView!
    //MARK:- Viewcontroller methods

    override func viewDidLoad() {
        super.viewDidLoad()

        //For Friends List
        tblTipsList.register(UINib(nibName: "Cell_TipsadToList", bundle: nil), forCellReuseIdentifier: "Cell_TipsadToList")

        view_tipAdded.isHidden = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableview Datasurce And Delegate

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var dcell: Cell_TipsadToList? = tableView.dequeueReusableCell(withIdentifier: "Cell_TipsadToList", for: indexPath as IndexPath) as? Cell_TipsadToList
        if (dcell == nil)
        {
            if dcell == nil
            {
                // Load the top-level objects from the custom cell XIB.
                var topLevelObjects: [Any] = Bundle.main.loadNibNamed("Cell_TipsadToList", owner: self, options: nil)!
                // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
                dcell = topLevelObjects[0] as? Cell_TipsadToList
            }
        }
        dcell?.btn_addtips.layer.cornerRadius = 12
        dcell?.btn_addtips.layer.masksToBounds = true

        dcell?.btn_addtips.tag = indexPath.row
        dcell?.btn_addtips.addTarget(self, action: #selector(btnAddTapped(_:)), for: .touchUpInside)

        return dcell!
    }
    
    func btnAddTapped(_ sender : UIButton){
        
        sender.isHighlighted = true
        self.startAnimation()
    }
    //MARK:- Animation
    
    func startAnimation() -> Void {
        
        view_tipAdded.isHidden = true
        
        self.view_tipAdded.alpha = 0.0
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [], animations: {
            self.view_tipAdded.isHidden = false
            self.view_tipAdded.alpha = 1.0
            
        }, completion: { (finished: Bool) in
            
            UIView.animate(withDuration: 3.0, delay: 0.0, options: [], animations: {
                
            }, completion: { (finished: Bool) in
                
                UIView.animate(withDuration: 1.5, delay: 0.0, options: [], animations: {
                    
                    self.view_tipAdded.alpha = 0.0
                    
                }, completion: { (finished: Bool) in
                    
                })
            })
        })
    }

    // MARK: - Button Tap Event
    
    @IBAction func btn_back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_StartANewList(_ sender: Any)
    {
        let move = self.storyboard?.instantiateViewController(withIdentifier: "StartANewListViewController") as! StartANewListViewController
        self.navigationController?.pushViewController(move, animated: true)
    }
    
    @IBAction func btn_HomeClickEvent(_ sender: Any) {
        
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
