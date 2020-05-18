//
//  ShowArticleViewController.swift
//  NewsCap
//
//  Created by Chris on 14/05/2020.
//  Copyright (c) 2020 Chris78. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ShowArticleDisplayLogic: class
{
    func displayArticle(viewModel: ShowArticle.GetArticle.ViewModel)
    func displayArticleImage(viewModel: ShowArticle.FetchImage.ViewModel)
}

class ShowArticleViewController: UIViewController, ShowArticleDisplayLogic
{
    var interactor: ShowArticleBusinessLogic?
    var router: (NSObjectProtocol & ShowArticleRoutingLogic & ShowArticleDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = ShowArticleInteractor()
        let presenter = ShowArticlePresenter()
        let router = ShowArticleRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var titleText: UITextView!
    @IBOutlet weak var publishText: UILabel!
    @IBOutlet weak var authorText: UILabel!
    @IBOutlet weak var contentText: UILabel!
    @IBOutlet weak var sourceText: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupUI()
        fetchArticle()
    }
    
    // MARK: Show Article
    
    func setupUI() {
        titleText.layer.shadowOpacity = 1.0
        titleText.layer.shadowOffset = CGSize(width: 0, height: 0)
        titleText.layer.shadowRadius = 10
        titleText.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        publishText.layer.shadowOpacity = 1.0
        publishText.layer.shadowOffset = CGSize(width: 0, height: 0)
        publishText.layer.shadowRadius = 3
        publishText.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    func fetchArticle()
    {
        let request = ShowArticle.GetArticle.Request()
        interactor?.getArticle(request: request)
    }
    
    func displayArticle(viewModel: ShowArticle.GetArticle.ViewModel)
    {
        titleText.text = viewModel.title
        publishText.text = viewModel.publish
        authorText.text = viewModel.author
        contentText.text = viewModel.content
        sourceText.text = viewModel.source
    }
    
    func displayArticleImage(viewModel: ShowArticle.FetchImage.ViewModel)
    {
        articleImage.image = viewModel.image
    }
}
