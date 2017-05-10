//
//  MyViewControllerPresenter.swift
//  GDIArchitectureExamples
//
//  Created by Stephanie Guevara on 5/8/17.
//  Copyright © 2017 GirlDevelopIt. All rights reserved.
//

protocol MyViewControllerPresentationDelegate: class {
    func didTapTableViewCell(at row:Int)
}

class MyViewControllerPresenter: MyViewControllerPresentationDelegate {
    unowned let view: MyViewControllerViewDelegate
    
    init(view: MyViewControllerViewDelegate) {
        self.view = view
    }
    
    //This presenter confroms the the "MyViewControllerPresentationDelegate" which means it agrees to
    //perform logic when a table view cell is tapped
    func didTapTableViewCell(at row: Int) {
        if row % 2 == 0 {
            view.changeHeaderBackgroundColor()
        } else {
            if row == 11 {
                view.showAlert(title:"You're a winner!", message: "You're the coolest!", actionTitle: "Dismiss")
            } else {
                view.changeHeaderTextColor()
            }
        }
    }
}
