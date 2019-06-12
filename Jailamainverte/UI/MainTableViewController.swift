//
//  MainTableViewController.swift
//  Jailamainverte
//
//  Created by Admin on 24/05/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController, PlantCellDelegate {
    
    var datasUpdated: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    /*override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }*/
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (datasUpdated) {
            //let indexPath = IndexPath(row: UserData.getInstance()._plantsArray.count - 1, section: 0)
            //tableView.insertRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
            datasUpdated = false
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if UserData.getInstance().getPlantsCount() == 0 {
            return 1
        } else {
            return UserData.getInstance().getPlantsCount()
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       /* let cell = tableView.dequeueReusableCell(withIdentifier: "plantCard", for: indexPath)*/
        var cellModel: UITableViewCell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "plantCard", for: indexPath) as? PlantTableViewCell else {
            fatalError("ERROR")
        }
        guard let cell2 = tableView.dequeueReusableCell(withIdentifier: "addPlantCell", for: indexPath) as? NewUserTableViewCell else {
            fatalError("ERROR")
        }
    
        if UserData.getInstance().getPlantsCount() == 0 {
            cellModel = cell2
            tableView.rowHeight = 300
            
        } else {
            cell.display(plant: UserData.getInstance().getSpecificPlant(index: indexPath.row))
            cell.delegate = self
            cellModel = cell
            tableView.rowHeight = 100
        }
        return cellModel
    }
    
    func wateringWasDone(forPlant plant: Plant) {
        Toast.show(message: "\(plant._plantName) \(Values().wateringToastString)", controller: self.parent ?? self)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserData.getInstance().removePlant(index: indexPath.row)
        tableView.reloadData()
        //tableView.deleteRows(at: [indexPath], with: .automatic)
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
