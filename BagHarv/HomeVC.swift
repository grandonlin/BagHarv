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
    var post = Post()
    var discussions = [Discussion]()
    var discussion = Discussion()
    var postComponents = [PostComponent]()
    let postRef = DataService.ds.REF_POSTS
    let discussionRef = DataService.ds.REF_DISCUSSIONS
    
    
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
            
            }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        postRef.removeObserver(withHandle: 0)
        discussionRef.removeObserver(withHandle: 0)
    }
    
    func initialize() {
        collectionView.isPagingEnabled = true
        DispatchQueue.global().async {
            self.fetchPostData()
            self.fetchDiscussionData()
        }
    }

    func fetchPostData() {
        posts.removeAll()
        postRef.observe(.value, with: { (snapshot) in
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
                                                    print("HomeVC: this post ID is \(post.postID)")
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
                                                if let postScenario = postData["Post Scenario"] as? String {
                                                    post.postScenario = postScenario
                                                }
                                                if let postComponentsData = postData["Post Components"] as? Dictionary<String, Any> {
                                                    let componentsCount = postComponentsData.count
                                                    var componentID: String!
                                                    
                                                    for i in 1...componentsCount {
                                                        if i < 10 {
                                                            componentID = "0\(i)"
                                                        } else {
                                                            componentID = "\(i)"
                                                        }
                                                        if let componentData = postComponentsData[componentID] as? Dictionary<String, String> {
                                                            if let componentDesc = componentData["Component Description"], let componentImageURL = componentData["Component Image URL"] {
                                                                let ref = Storage.storage().reference(forURL: componentImageURL)
                                                                ref.getData(maxSize: 1024 * 1024, completion: { (data, error) in
                                                                    if error != nil {
                                                                        print("Grandon(ProfileVC): the error is \(error?.localizedDescription)")
                                                                    } else {
                                                                        let img = UIImage(data: data!)
                                                                        let postComponent = PostComponent(componentImage: img!, componentDescription: componentDesc)
                                                                        self.postComponents.append(postComponent)
                                                                        post.postComponents = self.postComponents
                                                                    }
                                                                })
                                                            }
                                                        }
                                                        print("Now the postComponents array has \(self.postComponents.count) records")
                                                    }
                                                }
                                                
                                                if self.posts.count < 10 {
                                                    self.posts.append(post)
                                                    self.pageControl.numberOfPages = self.posts.count
                                                } else {
                                                    self.pageControl.numberOfPages = self.posts.count
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
            self.collectionView.reloadData()
        })
    }
    
    func fetchDiscussionData() {
        discussions.removeAll()
        discussionRef.observe(.value, with: { (snapshot) in
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
                                        let totalDiscussions = dayData.count
                                        for k in 0..<totalDiscussions {
                                            var discussionToBeLooped: String!
                                            let discussionCount = totalDiscussions - k
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
                                                if let body = discussionData["Body"] as? String {
                                                    discussion.body = body
                                                }
                                                if let commentData = discussionData["Comments"] as? Dictionary<String, Any> {
                                                    var comments = [Comment]()
                                                    let commentCount = commentData.count
                                                    for i in 1...commentCount {
                                                        var commentNumber: String
                                                        if i < 10 {
                                                            commentNumber = "0\(i)"
                                                        } else {
                                                            commentNumber = "\(i)"
                                                        }
                                                        if let commentDisc = commentData[commentNumber] as? Dictionary<String, Any> {
                                                            let message = commentDisc["Message"] as! String
                                                            let comment = Comment(content: message)
                                                            comments.append(comment)
                                                        }
                                                    }
                                                   discussion.comments = comments
                                                }
                                                if self.discussions.count < 10 {
                                                    self.discussions.append(self.discussion)
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
        post = posts[indexPath.item]
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as? HomeCollectionViewCell {
            cell.configureCell(post: post)
            let layout = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
            layout.minimumLineSpacing = 0
            return cell
        }
        return UICollectionViewCell()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / view.frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        post = posts[indexPath.item]
        performSegue(withIdentifier: "PostDetailVC", sender: post)
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
        discussion = discussions[indexPath.row]
        performSegue(withIdentifier: "DiscussionVC", sender: discussion)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PostDetailVC {
            destination.post = post
            print("HomeVC: \(post.postID)")
        }
        if let destination = segue.destination as? DiscussionVC {
            destination.discussion = discussion
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
