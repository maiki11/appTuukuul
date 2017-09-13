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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

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
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "postMine", for: indexPath) as! PostMineTableViewCell
            if let content = post.post?.base64Decoded() {
                cell.contentLabel.text = content
            }
            return cell
        }else{
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "post", for: indexPath) as! PostTableViewCell
            if let content = post.post?.base64Decoded() {
                cell.contentLabel.text = content
            }
            return cell
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

