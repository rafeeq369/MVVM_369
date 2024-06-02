//  ViewController.swift
//  MVVM_Snapay
//  Created by Rabeef Rahuman on 6/1/24.
 

import UIKit

class ViewController: UIViewController {
    
    //MARK:  Properties
    
    var loginViewModel: LoginViewModel!
    
    
    //MARK:  IBOutlets
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    
    @IBOutlet weak var title_lbl: UILabel!
    @IBOutlet weak var body_lbl: UILabel!
    
    @IBOutlet weak var fetchPostButton: UIButton!
    @IBOutlet weak var fetchUserButton: UIButton!
    
    
    //MARK:  Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UISetup()
        initializeViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    
    //MARK: IBActions
    
    @IBAction func fetch_user_btn_action(_ sender: Any) {
        loadingIndicator()
        let randomId = Int.random(in: 1...10)
        loginViewModel.fetchUser(userId: "\(randomId)")
    }
    
    @IBAction func fetch_post_btn_action(_ sender: Any) {
        loadingIndicator()
        let randomId = Int.random(in: 1...100)
        loginViewModel.fetchPosts(postId: "\(randomId)")
    }
}


//  MARK: Call_Backs

extension ViewController {
    
    func initializeViewModel() {
        loginViewModel = LoginViewModel()
        loginViewModel.delegate = self
    }
    
    func UISetup() {
        fetchUserButton?.layer.cornerRadius = 10
        fetchPostButton?.layer.cornerRadius = 10
    }
    
}


//  MARK: API_Response

extension ViewController: GenericProtcol {
    
    //  MARK: Handle_Success_Response
    
    func response<T>(items: T) {
        
        DispatchQueue.main.async {
            
            // Dismiss Loading Indicator
            self.dismiss(animated: false, completion: nil)
            
            // 'User' Api Response
            
            if let myresponse = items.self as? User {
                
                if let name     = myresponse.name,
                   let username = myresponse.username,
                   let email    = myresponse.email,
                   let phone    = myresponse.phone
                {
                    self.name?.text     = "Name : " + name
                    self.userName?.text = "User Name : \(username)"
                    self.email?.text    = "Email:  \(email)"
                    self.phone?.text    = "Phone : \(phone)"
                }
                
            }
            
            // 'Post' Api Response
            
            if let myresponse = items.self as? PostModel {
                
                if let title = myresponse.title,
                   let body = myresponse.body {
                    self.title_lbl?.text = "Title:  \(title)"
                    self.body_lbl?.text  = "Body : \(body)"
                }
                
                
            }
            
        }
        
        
    }
    
    //  MARK: Handle_Failure_Response
    
    func failure(response: String) {

        DispatchQueue.main.async {
            self.dismiss(animated: false, completion: nil)
            print(response)
            self.showAlert(title: "Error", message: response)
        }
    }
    
}
