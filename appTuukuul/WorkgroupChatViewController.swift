//
//  WorkgroupChatViewController.swift
//  appTuukuul
//
//  Created by Developer on 9/1/17.
//  Copyright © 2017 tuukuul. All rights reserved.
//

import UIKit
import ReSwift
import XLPagerTabStrip

class WorkgroupChatViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    var posts:[WorkgroupPost] = []
    var user:User = store.state.userState.user!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "previewPost" {
            let vc = segue.destination as! PostPreviewViewController
            let indexPath = self.tableView.indexPathForSelectedRow!
            vc.url = self.posts[indexPath.row].post!
        }
    }
 

}

extension WorkgroupChatViewController: IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Posts")
    }
}

extension WorkgroupChatViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post:WorkgroupPost = self.posts[indexPath.row]
        
        if user.id! == post.user! {
            
            if post.fileType == "image" || post.fileType == "video"{
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "postMineImg", for: indexPath) as! PostMineImgTableViewCell
                if post.fileType != "video" {
                    cell.imgView.loadImage(urlString:Constants.ServerApi.filesurl+post.post!)
                }
                print(cell.imgView.frame.height)
                print(cell.frame.height)
                cell.layoutIfNeeded()
                return cell
            }else{
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "postMine", for: indexPath) as! PostMineTableViewCell
                if let content = post.post?.base64Decoded() {
                    let newString = content.replacingOccurrences(of: "<br />", with: "\n", options: .literal, range: nil)
                    cell.contentLabel.text = newString
                    
                    cell.contentLabel.sizeToFit()
                    cell.contentLabel.frame = CGRect(x: cell.contentLabel.frame.origin.x, y: cell.contentLabel.frame.origin.y, width: cell.contentLabel.frame.width, height: cell.contentLabel.frame.height)
                    cell.contentLabel.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                    cell.sizeToFit()
                }
                return cell
            }
        }else{
            
            if post.fileType == "image" || post.fileType == "video"{
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "postImg", for: indexPath) as! PostImgTableViewCell
                if post.fileType != "video" {
                    cell.imgView.loadImage(urlString:Constants.ServerApi.filesurl+post.post!)
                }
                print(cell.imgView.frame.height)
                print(cell.frame.height)
                cell.layoutIfNeeded()
                return cell
            }else{
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "post", for: indexPath) as! PostTableViewCell
                if let content = post.post?.base64Decoded() {
                    let newString = content.replacingOccurrences(of: "<br />", with: "\n", options: .literal, range: nil)
                    cell.contentLabel.text = newString
                    
                    cell.contentLabel.sizeToFit()
                    cell.contentLabel.frame = CGRect(x: cell.contentLabel.frame.origin.x, y: cell.contentLabel.frame.origin.y, width: cell.contentLabel.frame.width, height: cell.contentLabel.frame.height)
                    cell.contentLabel.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                    cell.sizeToFit()
                }
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.posts[indexPath.row].fileType! == "image" || self.posts[indexPath.row].fileType! == "video" {
            return 150.0
        }
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = self.posts[indexPath.row]
        if post.fileType == "image" || post.fileType == "video" {
            print(post.post!)
            self.performSegue(withIdentifier: "previewPost", sender: nil)
        }
    }
}

extension WorkgroupChatViewController: StoreSubscriber {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        store.dispatch(GetWorkgroupPostsAction(wid: store.state.workgroupState.workgroup.id!))
        store.subscribe(self) {
            state in
            state.workgroupState
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        store.unsubscribe(self)
    }
    
    func newState(state: WorkgroupState) {
        self.posts = store.state.workgroupState.posts
        self.tableView.reloadData()
    }
    
}

