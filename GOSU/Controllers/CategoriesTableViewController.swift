//
//  ArticleCategoriesTableViewController.swift
//  FirebaseProject
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
    let spinner = UIActivityIndicatorView()


    override func viewDidLoad() {
        super.viewDidLoad()

        spinner.hidesWhenStopped = true
        spinner.center = tableView.center
        spinner.activityIndicatorViewStyle = .gray
        spinner.startAnimating()
        tableView.addSubview(spinner)

        refCategories = Database.database().reference().child("categories")

        //observing the data changes
        refCategories?.observe(DataEventType.value, with: { (snapshot) -> Void in

            if snapshot.childrenCount > 0 {
                //clearing the list
                self.categoriesList.removeAll()

                //iterating through all the values
                for categories in snapshot.children.allObjects as! [DataSnapshot] {
                    //getting values
                    let categoryObject = categories.value as? [String: AnyObject]
                    let categoryName  = categoryObject?["name"]
                    let categoryDescription = categoryObject?["description"]
                    let categoryImage = categoryObject?["image"]
                    let categoryID = categoryObject?["id"]

                    //creating artist object with model and fetched values
                    let category = CategoriesData(name: categoryName as! String?,
                                                  description: categoryDescription as! String?,
                                                  pictureURL: categoryImage as! String?,
                                                  id: categoryID as! Int?)

                    //appending it to list
                    self.categoriesList.append(category)
                }

                self.spinner.stopAnimating()
                self.spinner.removeFromSuperview()
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
        if category.pictureURL != "" {
            cell.categoryImage.image = try! UIImage(data: Data(contentsOf: URL(string: category.pictureURL!)!))
            cell.categoryImage.layer.cornerRadius = 90 / 2
            cell.categoryImage.layer.borderWidth = 1.0
            cell.categoryImage.layer.borderColor = UIColor.white.cgColor
            cell.categoryImage.clipsToBounds = true
        }
        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let indexPath = tableView.indexPathForSelectedRow {
            let selectedCategory: CategoriesData
            selectedCategory = categoriesList[indexPath.row]
            let articlesVC = segue.destination as! ArticlesTableViewController
            articlesVC.categoryID = selectedCategory.id!
        }
    }
}
