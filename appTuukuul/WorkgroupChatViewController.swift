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
    var offset = 0;
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
                }else{
                    cell.imgView.image = #imageLiteral(resourceName: "video")
                }
                cell.layoutIfNeeded()
                cell.userImg.loadImage(urlString: Constants.ServerApi.filesurl+post.img!)
                cell.userImg.circleImage()
                return cell
            }else{
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "postMine", for: indexPath) as! PostMineTableViewCell
                if let content = post.post?.base64Decoded() {
                    let newString = content.replacingOccurrences(of: "<br />", with: "\n", options: .literal, range: nil)
                    cell.contentLabel.text = newString
                    cell.contentLabel.layer.cornerRadius = 5
                    cell.contentLabel.layer.masksToBounds = true
                    cell.contentLabel.backgroundColor = #colorLiteral(red: 0.8745098039, green: 0.8823529412, blue: 0.8980392157, alpha: 1)
                }
                cell.userImg.loadImage(urlString: Constants.ServerApi.filesurl+post.img!)
                cell.userImg.circleImage()
                return cell
            }
        }else{
            
            if post.fileType == "image" || post.fileType == "video"{
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "postImg", for: indexPath) as! PostImgTableViewCell
                if post.fileType != "video" {
                    cell.imgView.loadImage(urlString:Constants.ServerApi.filesurl+post.post!)
                }else{
                    cell.imgView.image = #imageLiteral(resourceName: "video")
                }
                cell.layoutIfNeeded()
                cell.userImg.loadImage(urlString: Constants.ServerApi.filesurl+post.img!)
                cell.userImg.circleImage()
                return cell
            }else{
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "post", for: indexPath) as! PostTableViewCell
                if let content = post.post?.base64Decoded() {
                    cell.contentLabel.text = content
                }
                cell.contentLabel.sizeToFit()
                cell.contentLabel.backgroundColor = #colorLiteral(red: 0.568627451, green: 0.6274509804, blue: 0.7411764706, alpha: 1)
                cell.contentLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                cell.contentLabel.layer.cornerRadius = 5
                cell.contentLabel.layer.masksToBounds = true
                cell.userImg.loadImage(urlString: Constants.ServerApi.filesurl+post.img!)
                cell.userImg.circleImage()
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.posts[indexPath.row].fileType! == "image" || self.posts[indexPath.row].fileType! == "video" {
            return 150.0
        }
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = self.posts[indexPath.row]
        if post.fileType == "image" || post.fileType == "video" {
            self.performSegue(withIdentifier: "previewPost", sender: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.scrollsToTop = true
    }
}

extension WorkgroupChatViewController: StoreSubscriber {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getPostsData()
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    override func viewWillDisappear(_ animated: Bool) {
        store.unsubscribe(self)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y <= 0){
            self.offset+=20
            getPostsData()
        }
    }
    
    func getPostsData(){
        store.dispatch(GetWorkgroupPostsAction(wid: store.state.workgroupState.workgroup.id!,offset: self.offset))
        store.subscribe(self) {
            state in
            state.workgroupState
        }
    }
    
    func newState(state: WorkgroupState) {
        switch state.status {
        case .finished:
            self.posts = state.posts
            self.tableView.reloadData()
            break
        default:
            break
        }
    }
}

