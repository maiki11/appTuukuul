//
//  WorkgroupFilesViewController.swift
//  appTuukuul
//
//  Created by Developer on 9/1/17.
//  Copyright © 2017 tuukuul. All rights reserved.
//

import UIKit
import ReSwift
import XLPagerTabStrip

class WorkgroupFilesViewController: UIViewController {

    @IBOutlet weak var filesCollectionView: UICollectionView!
    var files:[WorkgroupFile] = []
    
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

extension WorkgroupFilesViewController: IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Archivos")
    }
}

extension WorkgroupFilesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.files.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.filesCollectionView.dequeueReusableCell(withReuseIdentifier: "wFileID", for: indexPath) as! WFileCollectionViewCell
        let file = self.files[indexPath.row]
        
        cell.fileNameLbl.text = file.name! + file.ext! == nil ? "" : file.ext!
        
        return cell
    }
}

extension WorkgroupFilesViewController: StoreSubscriber {
    func newState(state: WorkgroupState) {
        self.files = store.state.workgroupState.files ?? []
        self.filesCollectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        store.dispatch(GetWorkgroupFilesAction(wid: store.state.workgroupState.workgroup.id!, fid: "0"))
        store.subscribe(self) {
            state in
            state.workgroupState
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        store.unsubscribe(self)
    }
}
