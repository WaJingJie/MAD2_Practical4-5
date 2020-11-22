//
//  ViewController.swift
//  Telegramme
//
//  Created by MAD2 on 12/11/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usrNameFld: UITextField!
    @IBOutlet weak var pwdFld: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func onclick(_ sender: Any) {
        if true{
            //if username and password is correct
            let storyboard = UIStoryboard(name:"Content", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "Content") as UIViewController
            vc.modalPresentationStyle = .fullScreen //try without fullscreen
            present(vc, animated: true, completion: nil)
        }
    }
}

