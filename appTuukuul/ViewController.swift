//
//  ViewController.swift
//  appTuukuul
//
//  Created by miguel reina on 18/08/17.
//  Copyright © 2017 tuukuul. All rights reserved.
//

import UIKit
import ReSwift
import KDLoadingView
import Whisper
class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var loading: KDLoadingView!
    //@IBOutlet weak var loading: KDLoadingView!
    //@IBOutlet weak var emailLbl: UITextField!
    //@IBOutlet weak var passwordLbl: UITextField!
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.1098039216, green: 0.137254902, blue: 0.1921568627, alpha: 1)
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        loading.hidesWhenStopped = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func handleLogin(_ sender: UIButton) {
        
        guard let email = emailTextField.text, !email.isEmpty else {
            return
        }
        guard let pass = passTextField.text, !pass.isEmpty else {
            return
        }
        
        store.dispatch(LogInAction(password: pass, email: email))
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    
}
extension ViewController : StoreSubscriber {
    typealias StoreSubscriberStateType = UserState
    override func viewWillAppear(_ animated: Bool) {
        
        store.subscribe(self) {
            state in
            state.userState
        }
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        store.unsubscribe(self)
    }
    func newState(state: UserState) {
        loading.stopAnimating()
        
        switch state.status {
        case .loading:
            loading.isHidden = false
            loading.startAnimating()
            break
        case .Finished(let u as User):
            self.performSegue(withIdentifier: "preSegue", sender: u)
            break
        case .Failed(let m as Murmur):
            // Show and hide a message after delay
            Whisper.show(whistle: m, action: .show(0.5))
            
            break
        default:
            break
        }
    }
}

