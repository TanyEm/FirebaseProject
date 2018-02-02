//
//  CodeVerificationViewController.swift
//  GOSU
//
//  Created by Tanya Tomchuk on 25/01/2018.
//  Copyright © 2018 Tanya Tomchuk. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CodeVerificationViewController: UIViewController {

    var databaseRef: DatabaseReference!


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
                
                self.databaseRef = Database.database().reference()
                self.databaseRef.child("user_profiles").child(user!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                    let snapshot = snapshot.value as? NSDictionary

                    if snapshot == nil {
                        self.databaseRef.child("user_profiles").child(user!.uid).child("name").setValue("")
                        self.databaseRef.child("user_profiles").child(user!.uid).child("email").setValue("")
                        self.databaseRef.child("user_profiles").child(user!.uid).child("phone_num").setValue(user?.phoneNumber)
                    }
                    // Create Segue fore signing with phone number
                    self.performSegue(withIdentifier: "PhoneViewSegue", sender: Any?.self)
                    print("User: \(String(describing: user?.phoneNumber))")
                })
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
