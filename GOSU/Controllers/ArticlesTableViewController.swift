//
//  ArticlesTableViewController.swift
//  GOSU
//
//  Created by Tanya Tomchuk on 03/02/2018.
//  Copyright © 2018 Tanya Tomchuk. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ArticlesTableViewController: UITableViewController {

    var categoryID = 0
    var refArticles: DatabaseReference?
    var articlesList = [ArticlesData]()

    override func viewDidLoad() {
        super.viewDidLoad()

        refArticles = Database.database().reference().child("articles")

        //observing the data changes
        refArticles?.observe(DataEventType.value, with: { (snapshot) -> Void in
            print(snapshot)
            if snapshot.childrenCount > 0 {
                //clearing the list
                self.articlesList.removeAll()

                //iterating through all the values
                for articles in snapshot.children.allObjects as! [DataSnapshot] {
                    //getting values
                    let articleObject = articles.value as? [String: AnyObject]
                    let articleTitle  = articleObject?["title"]
                    let articleDescription = articleObject?["description"]
                    let articleImage = articleObject?["image"]
                    let categoryID = articleObject?["category_id"]
                    let articleBody = articleObject?["body"]
                    let articleVideo = articleObject?["video_link"]
                    let articleID = articleObject?["id"]


                    if Int(truncating: categoryID as! NSNumber) == self.categoryID {
                        //creating artist object with model and fetched values
                        let category = ArticlesData(title: articleTitle as! String?,
                                                    description: articleDescription as! String?,
                                                    pictureURL: articleImage as! String?,
                                                    category_id: categoryID as! Int?,
                                                    body: articleBody as! String?,
                                                    video_link: articleVideo as! String?,
                                                    id: articleID as! Int?)

                        //appending it to list
                        self.articlesList.append(category)
                    }
                }

                //reloading the tableview
                self.tableView.reloadData()

            }
        })
        
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return articlesList.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticlesTableViewCell

        // Configure the cell...
        //the artist object
        let article: ArticlesData

        //getting the artist of selected position
        article = articlesList[indexPath.row]

        //adding values to labels
        cell.articleTitle.text = article.title
        cell.articleDescription.text = article.description
        if article.pictureURL != "" {
            cell.articleImage.image = try! UIImage(data: Data(contentsOf: URL(string: article.pictureURL!)!))
            cell.articleImage.layer.cornerRadius = 90 / 2
            cell.articleImage.layer.borderWidth = 1.0
            cell.articleImage.layer.borderColor = UIColor.white.cgColor
            cell.articleImage.clipsToBounds = true
        }

        return cell
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            // Get the new view controller using segue.destinationViewController.
            // Pass the selected object to the new view controller.
            let selectedArticle: ArticlesData
            selectedArticle = articlesList[indexPath.row]
            let detailArticleVC = segue.destination as! DetailArticleViewController
            detailArticleVC.articlesID = selectedArticle.id!
        }
    }
}
