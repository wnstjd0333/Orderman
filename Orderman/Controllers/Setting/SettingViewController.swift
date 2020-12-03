//
//  SettingViewController.swift
//  Orderman
//
//  Created by jaeeun on 2020/12/02.
//

import UIKit

class SettingViewController: UIViewController {

    enum SettingMenu: Int {
        case category
        case menu
        case option
        case print
        case logout
        
        case _count
        static let count = _count.rawValue
    }
    
    @IBOutlet weak private var settingTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "設定"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SettingViewController: UITableViewDelegate {
    
}

extension SettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingDefaultCell", for:indexPath)
        cell.accessoryType = .detailButton
        
        cell.textLabel?.text = "aaaa"
        return cell
    }
}
