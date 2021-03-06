//
//  ResultsTableViewController.swift
//  GitMeAJob
//
//  Created by Alvar Aronija on 26/04/2018.
//  Copyright © 2018 Alvar Aronija. All rights reserved.
//

import UIKit

class ResultsTableViewController: UITableViewController {
    var jobs: [Job]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(jobs)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 150
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (jobs?.count)! > 0 ? jobs!.count : 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath) as! CustomTableViewCell
        if jobs!.count > 0 {
            let job = jobs![indexPath.row]
            
            cell.jobTitleLabel.numberOfLines = 0
            cell.jobTitleLabel.text = job.title
            cell.companyLabel.text = job.company
            cell.locationLabel.text = job.location
            cell.timeLabel.text = Date.getJobPublishedDate(convertDate: job.createdAt)
            
            if job.type == "Full Time" {
                cell.fullTimeLabel.text = "FULL \nTIME"
            } else {
                cell.fullTimeLabel.isHidden = true
            }
        } else {
            cell.jobTitleLabel.text = "Nothing found"
        }
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewC = segue.destination as! WebViewController
        if let row = tableView.indexPathForSelectedRow?.row{
            if jobs!.count > 0 {
               viewC.stringUrl = jobs![row].url
            } else {
                viewC.stringUrl = URL(string: "https://jobs.github.com")
            }
        }
    }
    

}
