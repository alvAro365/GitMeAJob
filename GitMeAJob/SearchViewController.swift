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
    @IBOutlet weak var progressView: UIProgressView!
    var jobs = [Job]()
    var fullTimeJobOnly = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressView.isHidden = true
        searchButtonState()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // MARK: - Actions
    
    @IBAction func onSearchButtonClick(_ sender: UIButton) {
        progressView.isHidden = false
        progressView.setProgress(0.95, animated: true)
        let description = jobDescription.text
        let location = jobLocation.text
        print("The description is: \(description!)")
        print("The location is: \(location!)")
        
        Job.getJobs(description: description!, location: location!, fullTime: fullTimeJobOnly) { result in
            switch result {
            case .success(let jobs):
                self.progressView.setProgress(1.0, animated: true)
                self.jobs = jobs
                self.performSegue(withIdentifier: "searchSegue", sender: nil)
            case .failure(let error):
                fatalError("error: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchSegue" {
            let resultsViewController = segue.destination as? ResultsTableViewController
            resultsViewController?.jobs = self.jobs
            progressView.isHidden = true
            progressView.setProgress(0.0, animated: false)
        }
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
