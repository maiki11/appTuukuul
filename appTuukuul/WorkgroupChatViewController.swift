//
//  WorkgroupChatViewController.swift
//  appTuukuul
//
//  Created by Developer on 9/1/17.
//  Copyright © 2017 tuukuul. All rights reserved.
//

import UIKit
import ReSwift
import PusherSwift
import XLPagerTabStrip

class WorkgroupChatViewController: UIViewController, UIGestureRecognizerDelegate, PusherDelegate {

    @IBOutlet var textField: UITextField!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var sendButton: UIButton!
    var posts:[WorkgroupPost] = []
    var user:User = store.state.userState.user!
    var offset = 0;
    var pusher: Pusher! = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y = 0
            }
        }
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
    
    @IBAction func sendPost(_ sender: Any) {
        print(store.state.userState.user.id!)
        print(store.state.workgroupState.workgroup.id!)
        if self.textField.text != "" {
        store.dispatch(CreatePostAction(uid: store.state.userState.user.id!, wid: store.state.workgroupState.workgroup.id!, text: self.textField.text!))
            self.textField.text = ""
        }


    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view != self.sendButton
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
        print(indexPath.row)
        if indexPath.row == 0 {
            self.offset += 20
            getPostsData()
        }
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
//        print(self.posts.count)
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("View did appear")
        pusher = Pusher(key: "33c0b3a95370c4456a8c")
        
        pusher.connect()
        
        pusher.delegate = self

        let _ = pusher.bind({ (message: Any?) in
            if let message = message as? [String: AnyObject], let eventName = message["TNM_Event_WG_\(store.state.workgroupState.workgroup.id!)"] as? String, eventName == "pusher:error" {
                if let data = message["data"] as? [String: AnyObject], let errorMessage = data["message"] as? String {
                    print("Error message: \(errorMessage)")
                }
            }
        })
        
        let onMemberAdded = { (member: PusherPresenceChannelMember) in
            print(member)
        }
        
        let chan = pusher.subscribe("Tuukuul_Notificacions", onMemberAdded: onMemberAdded)
        
        let _ = chan.bind(eventName: "TNM_Event_WG_\(store.state.workgroupState.workgroup.token!)", callback: { data in
            print(data)
            let _ = self.pusher.subscribe("Tuukuul_Notificacions", onMemberAdded: onMemberAdded)
            
            if let data = data as? [String : AnyObject] {
                if let testVal = data["test"] as? String {
                    print(testVal)
                }
            }
        })
        
        
//        let channel = pusher.subscribe("Tuukuul_Notificacions")
//        let _ = channel.bind(eventName: "TNM_Event_WG_\(store.state.workgroupState.workgroup.id!)") { (data: Any?) -> Void in
//            if let data = data as? [String:AnyObject]{
//                if let message = data["message"] as? String{
//                    print("Mensaje a ver si sale")
//                    print(message)
//                }
//            }
//        }
        
        
    }
    
    func subscribedToChannel(name: String) {
        print("Subscribed to \(name)")
    }
    
    func subscribedToInterest(name: String) {
        print("Subscribed to \(name)")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        store.unsubscribe(self)
        pusher.disconnect()
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y <= 0){
            print("Llegue")
//            getPostsData()
//            self.offset+=20
//            let index = IndexPath(row: 10, section: 0)
//            print(scrollView.contentOffset)
//            self.tableView.scrollToRow(at: index, at: UITableViewScrollPosition.middle, animated: false)
//            store.state.workgroupState.status = .finished
            
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
            let indexPath = IndexPath(row: self.posts.count - 1 - self.offset, section: 0)
            print(indexPath.row)
            self.tableView.reloadData()
            if self.offset == 0{
                self.tableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.bottom, animated: false)
            } else {
                self.tableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.top, animated: false)
            }
            
            break
        default:
            break
        }
    }
}

