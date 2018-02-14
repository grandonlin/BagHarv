//
//  HomeVC.swift
//  BagHarv
//
//  Created by Grandon Lin on 2018-01-17.
//  Copyright © 2018 Grandon Lin. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [Post]()
    var discussions = [Discussion]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        initialize()
        print("HomeVC: posts array has \(posts.count) records   ")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.global().async {
            self.fetchPostData()
            self.fetchDiscussionData()
            }
    }
    
    func initialize() {
        collectionView.isPagingEnabled = true
        
    }

    func fetchPostData() {
        posts.removeAll()
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            let currentSystemDate = Date()
            let calendar = Calendar.current
            let year = calendar.component(.year, from: currentSystemDate)
            
            if let snapShot = snapshot.value as? Dictionary<String, Any> {
                for h in 2017...year {
                    let differenceTo2017 = h - 2017
                    let yearToBeLooped = year - differenceTo2017
                    if let currentYearData = snapShot["\(yearToBeLooped)"] as? Dictionary<String, Any> {
                        for i in 0..<12 {
                            let monthIndexToLooped = 12 - 1 - i
                            let formatMonth = calendar.monthSymbols[monthIndexToLooped]
                            if let MonthData = currentYearData[formatMonth] as? Dictionary<String, Any> {
                                let totalDays = self.getAllDays(month: monthIndexToLooped + 1, year: year)
                                var dayToBeLooped: String!
                                for j in 1...totalDays {
                                    let daysDifference = totalDays + 1 - j
                                    if daysDifference < 10 {
                                        dayToBeLooped = "0\(daysDifference)"
                                    } else {
                                        dayToBeLooped = "\(daysDifference)"
                                    }
                                    if let dayData = MonthData[dayToBeLooped] as? Dictionary<String, Any> {
                                        //                                        print("(HomeVC): \(dayData)")
                                        let totalPosts = dayData.count
                                        for k in 0..<totalPosts {
                                            var postToBeLooped: String!
                                            let postCount = totalPosts - k
                                            if postCount < 10 {
                                                postToBeLooped = "0\(postCount)"
                                            } else {
                                                postToBeLooped = "\(postCount)"
                                            }
                                            if let postData = dayData[postToBeLooped] as? Dictionary<String, Any> {
                                                let post = Post()
                                                if let postID = postData["Post ID"] as? String {
                                                    post.postID = postID
                                                }
                                                if let title = postData["Title"] as? String {
                                                    post.title = title
                                                }
                                                if let created = postData["Created"] as? String {
                                                    post.created = created
                                                }
                                                if let displayImageUrl = postData["Display Image URL"] as? String {
                                                    post.displayImageURL = displayImageUrl
                                                }
                                                if let headImageURLData = postData["Head Image URL"] as? Dictionary<String, Any> {
                                                    var headImageURLs = [String]()
                                                    for headImageURLValue in headImageURLData.values {
                                                        headImageURLs.append(headImageURLValue as! String)
                                                    }
                                                    post.headImageURLs = headImageURLs
                                                }
                                                if let bodyImageURLData = postData["Body Image URL"] as? Dictionary<String, Any> {
                                                    var bodyImageURLs = [String]()
                                                    for bodyImageURLValue in bodyImageURLData.values {
                                                        bodyImageURLs.append(bodyImageURLValue as! String)
                                                    }
                                                    post.bodyImageURLs = bodyImageURLs
                                                }
                                                if let bottomImageURLData = postData["Bottom Image URL"] as? Dictionary<String, Any> {
                                                    var bottomImageURLs = [String]()
                                                    for bottomImageURLValue in bottomImageURLData.values {
                                                        bottomImageURLs.append(bottomImageURLValue as! String)
                                                    }
                                                    post.bottomImageURLs = bottomImageURLs
                                                }
                                                if self.posts.count < 10 {
                                                    self.posts.append(post)
                                                    
                                                } else {
                                                    break
                                                }
                                                self.pageControl.numberOfPages = self.posts.count
                                            }
                                        }
                                    }
                                    
                                }
                            }
                        }
                    }
                }
                
            }
            self.collectionView.reloadData()
        })
    }
    
    func fetchDiscussionData() {
        discussions.removeAll()
        DataService.ds.REF_DISCUSSIONS.observe(.value, with: { (snapshot) in
            let currentSystemDate = Date()
            let calendar = Calendar.current
            let year = calendar.component(.year, from: currentSystemDate)
            
            if let snapShot = snapshot.value as? Dictionary<String, Any> {
                for y in 2017...year {
                    let differenceTo2017 = y - 2017
                    let yearToBeLooped = year - differenceTo2017
                    if let currentYearData = snapShot["\(yearToBeLooped)"] as? Dictionary<String, Any> {
                        for m in 0..<12 {
                            let monthIndexToLooped = 12 - 1 - m
                            let formatMonth = calendar.monthSymbols[monthIndexToLooped]
                            if let MonthData = currentYearData[formatMonth] as? Dictionary<String, Any> {
                                let totalDays = self.getAllDays(month: monthIndexToLooped + 1, year: year)
                                var dayToBeLooped: String!
                                for d in 1...totalDays {
                                    let daysDifference = totalDays + 1 - d
                                    if daysDifference < 10 {
                                        dayToBeLooped = "0\(daysDifference)"
                                    } else {
                                        dayToBeLooped = "\(daysDifference)"
                                    }
                                    if let dayData = MonthData[dayToBeLooped] as? Dictionary<String, Any> {
                                        let totalDiscussionss = dayData.count
                                        for k in 0..<totalDiscussionss {
                                            var discussionToBeLooped: String!
                                            let discussionCount = totalDiscussionss - k
                                            if discussionCount < 10 {
                                                discussionToBeLooped = "0\(discussionCount)"
                                            } else {
                                                discussionToBeLooped = "\(discussionCount)"
                                            }
                                            if let discussionData = dayData[discussionToBeLooped] as? Dictionary<String, Any> {
                                                let discussion = Discussion()
                                                if let topic = discussionData["Topic"] as? String {
                                                    discussion.topic = topic
                                                }
                                                if self.discussions.count < 10 {
                                                    self.discussions.append(discussion)
                                                } else {
                                                    break
                                                }
                                            }
                                        }
                                    }
                                    
                                }
                            }
                        }
                    }
                }
                
            }
            self.tableView.reloadData()
        })
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let post = posts[indexPath.row]
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as? HomeCollectionViewCell {
            cell.configureCell(post: post)
            let layout = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
            layout.minimumLineSpacing = 0
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "PostDetailVC", sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if discussions.count < 10 {
            return discussions.count
        } else {
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let discussion = discussions[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell") as? HomeCell {
            cell.configureCell(discussion: discussion)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "DiscussionVC", sender: nil)
    }
    
    @IBAction func logoutBtnPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            KeychainWrapper.standard.removeObject(forKey: KEY_UID)
            performSegue(withIdentifier: "LogonVC", sender: nil)
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func getAllDays(month: Int, year: Int) -> Int {
        let dateComponents = DateComponents(year: year, month: month)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!
        
        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count
        return numDays
    }
}
