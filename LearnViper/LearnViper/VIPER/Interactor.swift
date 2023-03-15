//
//  Interactor.swift
//  LearnViper
//
//  Created by Jeff Umandap on 3/15/23.
//

import Foundation

// object
// protocol
// ref to presenter

// https://jsonplaceholder.typicode.com/users

protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
    
    func getUsers()
}

class UserInteractor: AnyInteractor {
    var presenter: AnyPresenter?
    
    func getUsers() {
        print("starting fetch")
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        let tasks = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidFetchUsers(with: .failure(FetchError.failed))
                return
            }
            
            do {
                let entities = try JSONDecoder().decode([User].self, from: data)
                self?.presenter?.interactorDidFetchUsers(with: .success(entities))
            } catch {
                self?.presenter?.interactorDidFetchUsers(with: .failure(error))
            }
        }
        tasks.resume()
    }
}
