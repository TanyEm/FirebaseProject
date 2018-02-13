//
//  DetailArticleViewController.swift
//  GOSU
//
//  Created by Tanya Tomchuk on 07/02/2018.
//  Copyright © 2018 Tanya Tomchuk. All rights reserved.
//

import UIKit
import FirebaseDatabase

class DetailArticleViewController: UIViewController {

    var refArticles: DatabaseReference?
    var articlesList = [ArticlesData]()
    var articlesID = 0
    let spinner = UIActivityIndicatorView()

    @IBOutlet weak var articleImg: UIImageView!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleBody: UILabel!

//if selectArticle.id == articlesID
    override func viewDidLoad() {
        super.viewDidLoad()

        spinner.hidesWhenStopped = true
        spinner.center = view.center
        spinner.activityIndicatorViewStyle = .gray
        spinner.startAnimating()
        view.addSubview(spinner)

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


                    if Int(truncating: articleID as! NSNumber) == self.articlesID {
                        //creating artist object with model and fetched values
                        let article = ArticlesData(title: articleTitle as! String?,
                                                    description: articleDescription as! String?,
                                                    pictureURL: articleImage as! String?,
                                                    category_id: categoryID as! Int?,
                                                    body: articleBody as! String?,
                                                    video_link: articleVideo as! String?,
                                                    id: articleID as! Int?)

                        //appending it to list
                        self.articlesList.append(article)

                        self.articleBody.text = article.body
                        self.articleTitle.text = article.title
                        if article.pictureURL != "" {
                            self.articleImg.image = try! UIImage(data: Data(contentsOf: URL(string: article.pictureURL!)!))

                        } else {
                            self.articleImg.image = UIImage(named: "no_photo")!
                        }

                    }
                    self.spinner.stopAnimating()
                    self.spinner.removeFromSuperview()
                }
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
