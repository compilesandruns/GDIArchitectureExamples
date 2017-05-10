//
//  ViewController.swift
//  GDIArchitectureExamples
//
//  Created by Stephanie Guevara on 5/8/17.
//  Copyright © 2017 GirlDevelopIt. All rights reserved.
//

import UIKit

/* Delegation as a means of abstraction
 - The delegate pattern can is one means of creating abstraction and modularity in code
 - With iOS and Swift, the delegation design pattern is achieved by using an abstraction layer called a protocol
 - A protocol can be thought of as a contract between two parties that outlines what tasks the delegate can provide and what information the delegator needs to give the delegate to achieve these tasks
 
 - A protocol: defines the responsibilities that will be delegated
 - A delegator: passes on information and responsibilities to delegate
 - A delegate: conforms to the protocol and implements its requirements
 */

//For delegation to occur in software, you’d have a situation where one class (a delegator class) would give control or responsibility for some behavioral logic to another class called a delegate.
class MyViewController: UIViewController {
    fileprivate(set) var presenter: MyViewControllerPresentationDelegate!
    
    let tableArray = ["Swift", "Objective-C", "Java", "C++", "Ruby", "Python", "Scala", "Rust", "Angular", "JavaScript","Lisp", "Groovy", "Haskell"]
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet var myHeaderView: UIView!
    @IBOutlet weak var myHeaderViewLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Because I am giving responsibilities to these protocols to do work for me, I must give them the information they need to perform the work
        //In this case, we see a warning from UITableViewDataSource saying that it does not have the info needed to render a TableView for me
        myTableView.delegate = self
        myTableView.dataSource = self
        
        presenter = MyViewControllerPresenter(view: self)
    }
}

extension MyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCellIdentifier = "myCell"
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: myCellIdentifier)
        cell.textLabel?.text = tableArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didTapTableViewCell(at: indexPath.row)
        
        print("Row: \(indexPath.row)")
    }
}

extension MyViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return myHeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
}

extension MyViewController: MyViewControllerViewDelegate {
    func changeHeaderBackgroundColor() {
        myHeaderView.backgroundColor = UIColor.init(colorLiteralRed: Float(drand48()), green: Float(drand48()), blue: Float(drand48()), alpha: 1.0)
    }
    
    func changeHeaderTextColor(){
        myHeaderViewLabel.textColor = UIColor.init(colorLiteralRed: Float(drand48()), green: Float(drand48()), blue: Float(drand48()), alpha: 0.5)
    }
    
    //Your view's only job is to render what it gets passes in. It is completely seperate from any logic
    func showAlert(title: String, message: String, actionTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default,handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

