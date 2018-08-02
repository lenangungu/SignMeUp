//
//  StudiesViewController.swift
//  SignMeUp
//
//  Created by Lena Ngungu on 7/10/18.
//  Copyright © 2018 Lena Ngungu. All rights reserved.
//

import UIKit

class StudiesViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    var studies = [Study]()
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        reloadTimeline()
    }
    
    @objc func reloadTimeline() {
                UserService.timeline { (studies) in
                    self.studies = studies
        
                    if self.refreshControl.isRefreshing {
                        self.refreshControl.endRefreshing()
                    }
        
                    self.tableView.reloadData()
                }
    }
    func configureTableView() {
                // remove separators for empty cells
                tableView.tableFooterView = UIView()
                // remove separators from cells
                tableView.separatorStyle = .none
        
                refreshControl.addTarget(self, action: #selector(reloadTimeline), for: .valueChanged)
                tableView.addSubview(refreshControl)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC =  segue.destination as! MyStudyDetailsViewController
        let index = tableView.indexPathForSelectedRow!.row
        let study = studies[index]
        nextVC.createdBy = study.poster.firstName + " " + study.poster.lastName
        nextVC.personName = study.personName
        nextVC.date = study.date
        nextVC.time = study.time
//        nextVC.sittingInOneLabel.text =
//        nextVC.sittingInThreeLabel =
//        nextVC.sittingInTwoLabel =
        nextVC.studyTitle = study.studyTitle 

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
extension StudiesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studies.count 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let study = studies[indexPath.row]
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "studyCell") as! StudyTableViewCell
       
        cell.createdByLabel.text = study.poster.firstName + " " + study.poster.lastName
            cell.ministryLabel.text = study.ministry
            cell.dateLabel.text = study.date
            cell.timeLabel.text = study.time
        cell.numOfPeopleLabel.text = String(study.people) 
        
        return cell
        
    }
    
    
}

extension StudiesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

}
