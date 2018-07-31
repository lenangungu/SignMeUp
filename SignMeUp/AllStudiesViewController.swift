//
//  AllStudiesTableViewController.swift
//  SignMeUp
//
//  Created by Lena Ngungu on 7/23/18.
//  Copyright © 2018 Lena Ngungu. All rights reserved.
//

import UIKit

class AllStudiesViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    var studies = [Study]()
    let refreshControl2 = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        reloadTimeline()
    }
    
    @objc func reloadTimeline() {
        UserService.timelineAll { (studies) in
            self.studies = studies
            
            if self.refreshControl2.isRefreshing {
                self.refreshControl2.endRefreshing()
            }
            
            self.tableView.reloadData()
        }
    }
    func configureTableView() {
        // remove separators for empty cells
        tableView.tableFooterView = UIView()
        // remove separators from cells
       // tableView.separatorStyle = .none
        
        refreshControl2.addTarget(self, action: #selector(reloadTimeline), for: .valueChanged)
        tableView.addSubview(refreshControl2)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension AllStudiesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let study = studies[indexPath.row]
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllStudiesCell") as! AllStudiesTableViewCell
        cell.createdByLabel.text = study.poster.firstName + " " + study.poster.lastName
        cell.ministryLabel.text = study.ministry
        cell.dateLabel.text = study.date
        cell.timeLabel.text = study.time
        cell.numOfpeopleLabel.text = String(study.people)
        
        return cell
        
    }
    
    
}

extension AllStudiesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}


