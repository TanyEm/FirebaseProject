//
//  ArticleCategoriesTableViewController.swift
//  GOSU
//
//  Created by Tanya Tomchuk on 29/01/2018.
//  Copyright © 2018 Tanya Tomchuk. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CategoriesTableViewController: UITableViewController {

    //defining firebase reference var
    var refCategories: DatabaseReference?
    //list to store all the categories
    var categoriesList = [CategoriesData]()

    override func viewDidLoad() {
        super.viewDidLoad()

        refCategories = Database.database().reference().child("categories")

        //observing the data changes
        refCategories?.observe(DataEventType.value, with: { (snapshot) -> Void in

            print(snapshot)
            if snapshot.childrenCount > 0 {
                //clearing the list
                self.categoriesList.removeAll()

                //iterating through all the values
                for categories in snapshot.children.allObjects as! [DataSnapshot] {
                    //getting values
                    let categoryObject = categories.value as? [String: AnyObject]
                    print(categoryObject)
                    let categoryName  = categoryObject?["name"]
                    let categoryDescription = categoryObject?["description"]
                    //let categoryImage = categoryObject?["categoryImage"]

                    //creating artist object with model and fetched values
                    let category = CategoriesData(name: categoryName as! String?,
                                                  description: categoryDescription as! String?)

                    print(category)

                    //appending it to list
                    self.categoriesList.append(category)
                }
                
                //reloading the tableview
                self.tableView.reloadData()

            }
        })
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categoriesList.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryTableViewCell

        // Configure the cell...
        //the artist object
        let category: CategoriesData

        //getting the artist of selected position
        category = categoriesList[indexPath.row]

        //adding values to labels
        cell.categoryName.text = category.name
        cell.categoryDescription.text = category.description

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
