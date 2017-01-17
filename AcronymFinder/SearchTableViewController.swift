//
//  SearchTableViewController.swift
//  AcronymFinder
//
//  Created by Diamond on 1/16/17.
//  Copyright © 2017 ethanthomas. All rights reserved.
//

import UIKit
import SwiftyJSON
import MBProgressHUD

class SearchTableViewController: UITableViewController {
    
    var networkManager = NetworkManager()
    var dataSource = [Acronym]()
    
    @IBOutlet weak var acronymSearchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "AcronymFinder"
        networkManager.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        acronymSearchBar.delegate = self
        acronymSearchBar.placeholder = "Enter an acronym or initialism"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SearchTableViewCell

        // Configure the cell...
        cell.setupCell(acronym: dataSource[indexPath.row])

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func createAndShowBasicAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SearchTableViewController: NetworkManagerDelegate, UISearchBarDelegate {
    func returnAPIResult(acronyms: [Acronym]) {
        if (acronyms.count == 0) { // if no results show error
           createAndShowBasicAlert(title: "Error getting definition", message: "There is no definition for this acronym / initialism please try searching another.")
        }
        dataSource = acronyms
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
            self.tableView.reloadData()
        }
    }
    
    func APIReturned(error: String) {
        MBProgressHUD.hide(for: self.view, animated: true)
        createAndShowBasicAlert(title: "Error retrieving definitions", message: error) // if error show error in alert controller
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            networkManager.callApiWith(term: text)
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.label.text = "Loading definitions..."
        }
        tableView.endEditing(true)
    }
}
