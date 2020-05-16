//
//  ShowArticleRouter.swift
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

@objc protocol ShowArticleRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol ShowArticleDataPassing
{
  var dataStore: ShowArticleDataStore? { get }
}

class ShowArticleRouter: NSObject, ShowArticleRoutingLogic, ShowArticleDataPassing
{
  weak var viewController: ShowArticleViewController?
  var dataStore: ShowArticleDataStore?
  
  // MARK: Routing
  
  //func routeToSomewhere(segue: UIStoryboardSegue?)
  //{
  //  if let segue = segue {
  //    let destinationVC = segue.destination as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //  } else {
  //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
  //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //    navigateToSomewhere(source: viewController!, destination: destinationVC)
  //  }
  //}

  // MARK: Navigation
  
  //func navigateToSomewhere(source: ShowArticleViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: ShowArticleDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
