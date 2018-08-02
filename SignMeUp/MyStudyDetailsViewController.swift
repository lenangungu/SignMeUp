//
//  MyStudyDetailsViewController.swift
//  SignMeUp
//
//  Created by Lena Ngungu on 7/30/18.
//  Copyright © 2018 Lena Ngungu. All rights reserved.
//

import UIKit

class MyStudyDetailsViewController: UIViewController {
   
    var studyTitle: String?
    var createdBy: String?
    var personName: String?
    var sittinginone: String?
    var sittingintwo: String?
    var sittinginthree: String?
    var date: String?
    var time: String?
  
    
    @IBOutlet var studyTitleLabel: UILabel!
    
    @IBOutlet var createdByLabel: UILabel!
    
    @IBOutlet var personNameLabel: UILabel!
    
    @IBOutlet var sittingInOne: UILabel!
    
    @IBOutlet var sittingInTwo: UILabel!
    
    @IBOutlet var sittingInThree: UILabel!
    
    @IBOutlet var dateLabel: UILabel!
    
    @IBOutlet var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        studyTitleLabel.text = studyTitle
        createdByLabel.text = createdBy
        personNameLabel.text = personName
        dateLabel.text = date
        timeLabel.text = time 

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
