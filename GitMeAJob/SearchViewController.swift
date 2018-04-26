//
//  SearchViewController.swift
//  GitMeAJob
//
//  Created by Alvar Aronija on 26/04/2018.
//  Copyright © 2018 Alvar Aronija. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var jobDescription: UITextField!
    @IBOutlet weak var jobLocation: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    var jobs = [Job]()
    var fullTimeJobOnly = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchButtonState()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // MARK: - Actions
    
    @IBAction func onSearchButtonClick(_ sender: UIButton) {
        let description = jobDescription.text
        let location = jobLocation.text
        print("The description is: \(description!)")
        print("The location is: \(location!)")
        
        Job.getJobs(description: description!, location: location!, fullTime: fullTimeJobOnly) { result in
            switch result {
            case .success(let jobs):
                self.jobs = jobs
                print("The jobs are: \(self.jobs)")
            case .failure(let error):
                fatalError("error: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    // MARK: - Helper methods
    
    func searchButtonState() {
        searchButton.isEnabled = false
        jobDescription.addTarget(self, action: #selector (textFieldEditingDidChange(_:)), for: UIControlEvents.editingChanged)
        jobLocation.addTarget(self, action: #selector (textFieldEditingDidChange(_:)), for: UIControlEvents.editingChanged)
    }
    
    @IBAction func textFieldEditingDidChange(_ sender: Any) {
        if (jobDescription.text?.isEmpty)! && (jobLocation.text?.isEmpty)! {
            searchButton.isEnabled = false
        } else {
            searchButton.isEnabled = true
        }
    }
}