//
//  OrderViewController.swift
//  GreateKolkata
//
//  Created by kimjunseong on 2020/11/27.
//

import UIKit

class OrderViewController: UIViewController {
    
    let orderStrings = ["テイクアウト","店内"]
    var clickedButton = UIButton()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    
    @IBAction func menuButtonTouced(_ sender: UIButton) {
        clickedButton.backgroundColor = .white
        clickedButton.tintColor = .black
        
        sender.backgroundColor = .black
        sender.tintColor = .white
        clickedButton = sender
    }
}

extension OrderViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderStrings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! OrderCell
        cell.titleLabel.text = orderStrings[indexPath.row]
        
        return cell
    }
}

extension OrderViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height / 7
    }
}

class OrderCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
}
