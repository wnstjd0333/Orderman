//
//  OrderDetailViewController.swift
//  Orderman
//
//  Created by kimjunseong on 2020/12/02.
//

import UIKit

class OrderDetailViewController: UIViewController {

    var menuTitle = ""
    var optionheaders = [String]()
    var optionDatas = [[String]]()
    
    let mandatoryOptionTitles = ["カレー選択 Choose Curry", "辛さ選択 Spice Choise"]
    let atLeastOneOptionTitles = ["ナン変更 Change to Cheese Naan", "ドリンク＆サラダ Drink & Salad"]
    let mandatoryDatas = [
        ["マタン Mutton","チキン Chicken","バターチキン Butter Chicken", "キーマ Keema", "ダル(ひよこ豆) Dal","シーフード Seafood", "エビ Shrimp"],
        ["甘口 Mild", "中辛 Medium", "辛口 Hot"]
    ]
    let atLeastOneOptionDatas = [
        ["チーズナン Cheese Naan"],
        ["ラッシー&サラダ Lassi & Salad", "マンゴーラッシー&サラダ Mango Lassi & Salad", "烏龍茶&サラダ Oolong Tea & Salad"]
    ]
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleLabel.text = menuTitle
        optionheaders = mandatoryOptionTitles + atLeastOneOptionTitles
        optionDatas = mandatoryDatas + atLeastOneOptionDatas
    }
    
    @IBAction func backButtonTouched(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension OrderDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        for i in stride(from: optionheaders.count - 1, through: 0, by: -1) {
            if section == i {
                return optionDatas[i].count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderDetailCell", for: indexPath) as! OrderDetailCell
        for i in 0...optionheaders.count - 1 {
            if indexPath.section == i {
                cell.titleLabel.text = optionDatas[i][indexPath.row]
            }
        }
        return cell
    }
}

extension OrderDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return optionheaders.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return optionheaders[section]
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = OrderDetailFooterView()
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
}

class OrderDetailCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
}

class OrderDetailFooterView: UIView {
    
    @IBOutlet weak var menuCountLabel: UILabel!
    
    @IBAction func numberbuttonTouched(_ sender: UIButton) {
        
    }
    
    @IBAction func OrderButtonTouched(_ sender: UIButton) {
        
    }
}
