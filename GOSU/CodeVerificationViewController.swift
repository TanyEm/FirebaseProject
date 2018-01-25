//
//  CodeVerificationViewController.swift
//  GOSU
//
//  Created by Tanya Tomchuk on 25/01/2018.
//  Copyright © 2018 Tanya Tomchuk. All rights reserved.
//

import UIKit
import FirebaseAuth

class CodeVerificationViewController: UIViewController {

    @IBOutlet weak var codeText: UITextField!
    
    @IBAction func Login(_ sender: Any) {
        let defaults = UserDefaults.standard

        let credential = PhoneAuthProvider.provider().credential(
                                                        withVerificationID: defaults.string(forKey: "authVID")!,
                                                        verificationCode: codeText.text!)
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil {
                print("error: \(String(describing: error?.localizedDescription))")
                return
            } else {
                print("Phone number: \(String(describing: user?.phoneNumber))")
                let userInfo = user?.providerData[0]
                print("Provider ID: \(String(describing: userInfo?.providerID))")
                self.performSegue(withIdentifier: "PhoneViewSegue", sender: Any?.self)
            }
        }
    }
    
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
