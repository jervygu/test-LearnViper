//
//  Router.swift
//  LearnViper
//
//  Created by Jeff Umandap on 3/15/23.
//

import Foundation
import UIKit

// object
// entry point

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    var entry: EntryPoint? { get }
    static func start() -> AnyRouter
    
}

class UserRouter: AnyRouter {
    var entry: EntryPoint?
    
    static func start() -> AnyRouter {
        let router = UserRouter()
        
        // assign VIP
        var view: AnyView = UserViewController()
        var interactor: AnyInteractor = UserInteractor()
        var presenter: AnyPresenter = UserPresenter()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = view
        
        router.entry = view as? EntryPoint
        
        return router
    }
}

