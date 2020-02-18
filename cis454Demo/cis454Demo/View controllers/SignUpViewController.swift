//
//  SignUpViewController.swift
//  cis454Demo
//
//  Created by 张尧大胖子 on 2/5/20.
//  Copyright © 2020 张尧. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setUpElements()
    }
    func setUpElements(){
        //hide error label
        errorLabel.alpha = 0
        
        //style the elements
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signUpButton)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    // check the Fields and validate that data is correct, this method return nil. Otherwise, it return error message
    func validateFields() -> String?{
        // check that all feilds are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)=="" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "please fill in all fields."
        }
        //check is password is secure
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(cleanedPassword) == false{
            //password isn't secure enough
            return "Please make sure you password is a least 8 characters, contains a special character and a number."
        }
        return nil
    }
    @IBAction func signUpTapped(_ sender: Any) {
        //Validate the failds
        let error = validateFields()
        if error != nil{
            //there's somrthing wrong with the field, show error message
            showError(error!)
        }
        else {
            // create cleaned versions of the data
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        //Create the users
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                //check erro
                if err !=  nil {
                    
                    //there was an error creating the user
                    self.showError("Error  creating user")
                }
                else{
                    //user was created successfully, now store the firstname and lastname
                    let bd = Firestore.firestore()
                     
                    bd.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName,"uid": result!.user.uid ]) { (error) in
                        if error != nil{
                            //show error message
                            self.showError("error saving user date")
                        }
                    }
                     //Transition to the home screen
                    self.transitionToHome()
                }
            }
            
        }
    }
    func showError(_ message:String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    func transitionToHome(){
       let homeViewController =
        storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
}
