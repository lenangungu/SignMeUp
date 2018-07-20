//
//  NewStudyViewController.swift
//  SignMeUp
//
//  Created by Lena Ngungu on 6/9/18.
//  Copyright © 2018 Lena Ngungu. All rights reserved.
//

import UIKit
import Foundation

class NewStudyViewController: UIViewController {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentDate = NSDate()
        datePicker.date = currentDate as Date
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createButtonTapped(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE,MMMM dd"
        let day = dateFormatter.string(from: datePicker.date)
        dateFormatter.dateFormat = "hh:mma"
        let time = dateFormatter.string(from: datePicker.date)
        let personName = nameTextField.text ?? ""
        let location = locationTextField.text ?? "" 
        let ministry = "campus"
        StudyService.create(personName: personName, date: day, time: time, location: location, ministry: ministry, people: 1)
        
    }
    

}
