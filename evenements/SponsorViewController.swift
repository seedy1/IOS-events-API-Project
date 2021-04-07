//
//  SponsorViewController.swift
//  evenements
//
//  Created by Daniel FOGUE on 31/03/2021.
//

import UIKit

class SponsorViewController: UIViewController {
    
    

    @IBOutlet weak var card: UIView!
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        card.layer.cornerRadius = 20
        
        tableview.delegate = self
        tableview.dataSource = self

        // Do any additional setup after loading the view.
    }
}
    
extension SponsorViewController: UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you tapped me")
    }
}
    
extension SponsorViewController: UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            //use the same template over and over
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = "Sponsor's Name"
            return cell
        }
    }

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


