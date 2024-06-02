//
//  LoginViewModel.swift
//  MVVM_Snapay
//
//  Created by Rabeef Rahuman on 6/1/24.
//

import Foundation

protocol GenericProtcol {
    func response<T>(items: T)
    func failure(response:String)
}

class LoginViewModel {
    
    var delegate: GenericProtcol!
    
    
    //MARK: Fetch 'User Details' API : -
    
    func fetchUser(userId: String) {
        
        let urlString =  AppConstants.base_URL + "users/" + userId
        
        guard let url = URL(string: urlString) else {
            delegate?.failure(response: "Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                self.delegate?.failure(response: error.localizedDescription)
                return
            }
            
            guard let data = data else {
                self.delegate?.failure(response: "No data received")
                return
            }
            
            do {
                let users = try JSONDecoder().decode(User.self, from: data)
                self.delegate?.response(items: users)
            } catch {
                self.delegate?.failure(response: error.localizedDescription)
            }
        }
        
        task.resume()
    }
    
    
    //MARK: Fetch 'Posts' API : -
    
    
    func fetchPosts(postId: String) {
        
        let urlString =  AppConstants.base_URL + "posts/" + postId
        
        guard let url = URL(string: urlString) else {
            delegate?.failure(response: "Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                self.delegate?.failure(response: error.localizedDescription)
                return
            }
            
            guard let data = data else {
                self.delegate?.failure(response: "No data received")
                return
            }
            
            do {
                let users = try JSONDecoder().decode(PostModel.self, from: data)
                self.delegate?.response(items: users)
            } catch {
                self.delegate?.failure(response: error.localizedDescription)
            }
        }
        
        task.resume()
    }
}
