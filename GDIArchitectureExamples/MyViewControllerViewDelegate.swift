//
//  MyViewControllerViewDelegate.swift
//  GDIArchitectureExamples
//
//  Created by Stephanie Guevara on 5/8/17.
//  Copyright © 2017 GirlDevelopIt. All rights reserved.
//

protocol MyViewControllerViewDelegate: class {
    var presenter: MyViewControllerPresentationDelegate! { get }
    
    func changeHeaderBackgroundColor()
    func changeHeaderTextColor()
    func showAlert(title: String, message: String, actionTitle: String)
}
