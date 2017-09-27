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

    @IBOutlet var searchBarFiles: UISearchBar!
    @IBOutlet weak var filesCollectionView: UICollectionView!
    var files:[WorkgroupFile] = []
    var tree:[String] = ["/"]
    var treeIDs:[String] = ["0"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "filePreview" {
            let vc = segue.destination as! FilePreviewViewController
            vc.file = sender as! WorkgroupFile
        }
    }
    

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
        print(self.files.count)
        return self.files.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = filesCollectionView.dequeueReusableCell(withReuseIdentifier: "wFileID", for: indexPath) as! WFileCollectionViewCell
        let file = self.files[indexPath.row]
        
        cell.fileNameLbl.text = file.name!
        cell.fileImgView.image = (file.ext == nil ? #imageLiteral(resourceName: "folder") : #imageLiteral(resourceName: "file"))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.files[indexPath.row].ext != nil{
            self.performSegue(withIdentifier: "filePreview", sender: self.files[indexPath.row])
        }else{
            if self.files[indexPath.row].name! == ".."{
                if self.tree.count > 1{
                    self.tree.popLast()
                    self.treeIDs.popLast()
                    let id = self.treeIDs[self.treeIDs.count-1]
                    store.dispatch(GetWorkgroupFilesAction(wid: store.state.workgroupState.workgroup.id!, fid: id))
                }
            }else{
                self.tree.append(self.files[indexPath.row].name!)
                self.treeIDs.append(self.files[indexPath.row].id!)
                print(self.tree)
                store.dispatch(GetWorkgroupFilesAction(wid: store.state.workgroupState.workgroup.id!, fid: self.files[indexPath.row].id!))
            }
            
        }
        
    }
}

extension WorkgroupFilesViewController: StoreSubscriber {
    func newState(state: WorkgroupState) {
        switch state.status {
        case .failed:
//            self.view.makeToast("Ocurrió un error, intente nuevamente")
            break
        case .loading:
//            self.view.makeToastActivity(.center)
            break
        case .finished:
//            self.view.hideToastActivity()
            print("finished")
            self.filesCollectionView.reloadData()
            break
        case .none:
            break
        default:
            break
        }
        self.files = store.state.workgroupState.files
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

extension WorkgroupFilesViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if(!(searchBar.text?.isEmpty)!){
            //reload your data source if necessary
            files = files.filter({($0.name?.lowercased().contains(searchBar.text!.lowercased()))!})
            filesCollectionView.reloadData()
        }else{
            files = store.state.workgroupState.files
            filesCollectionView.reloadData()
        }
        
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText.isEmpty){
            //reload your data source if necessary
            files = store.state.workgroupState.files
            print(files.count)
            filesCollectionView.reloadData()
        }else{
            files = files.filter({($0.name?.lowercased().contains(searchBar.text!.lowercased()))!})
            filesCollectionView.reloadData()
        }
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        files = store.state.workgroupState.files
        filesCollectionView.reloadData()
    }
}
