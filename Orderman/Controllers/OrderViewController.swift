//
//  OrderViewController.swift
//  GreateKolkata
//
//  Created by kimjunseong on 2020/11/27.
//

import UIKit

protocol OrderViewControllerDelegate: class {
    func getOrderTitle() -> String
}

class OrderViewController: UIViewController {
    
    private var clickedButton = UIButton()
    
    var menuButtonArray = [UIButton]()
    weak var delegate: OrderViewControllerDelegate?
    
    let sectionTitles = ["カレーセット Curry Set", "カレー単品", "ライス Rice", "ナン Naan", "サラダ Salad", "サイド Side"]
    let array1 = ["カレーナンセット Curry & Naan Set", "ダブルカレーナンセット Double Curry Set"]
    let array2 = ["バターチキンカレー Butter Chicken Curry", "ベジタブルカレー Vegetable Curry", "タマゴカレー Egg Curry", "キーマエッグカレー Keema Egg Curry", "マトンカレー Mutton Curry", "エビカレー Shrimp Curry", "サーグマトン Saag Button", "パラクパニーる Palak Paneer", "チキンラバダ Chicken Labbadha", "マトンラバダ Mutton Labbadha", "マッシュルームパラウ Mushroom Palak", "ダルマトン, Dal Mutton"]
    let array3 = ["特製ビリヤニ Biryani", "スパイシーチャーハン Spicy Fried Rice", "ジーラライス Zeera Rice", "チキンフライドライス Chicken Fried Rice"]
    let array4 = ["ナン Naan", "ガーリックナン Garlic Naan", "カブリナン Kabuli Naan", "チーズナン Cheeze Naan"]
    let array5 = ["グリーンサラダ Green Salad", "卵サラダ Egg Salad", "トスサラダ Toss Salad"]
    let array6 = ["サモサ Samosas", "タンドリーチキン Tandoori Chicken", "タンドリーミックスグリル Tandoori Mix Grill"]
    
    @IBOutlet weak private var scrollView: UIScrollView!
    @IBOutlet weak private var menuStackView: UIStackView!
    @IBOutlet weak private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.alwaysBounceHorizontal = false
        tableView.alwaysBounceVertical = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = delegate?.getOrderTitle()
        
        for (_,title) in sectionTitles.enumerated() {
            let button = UIButton()
            button.setTitle(title, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.layer.cornerRadius = 16
            menuStackView.addArrangedSubview(button)
            menuButtonArray.append(button)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        

    }
    
    @objc func munuButtonTouched(_ sender: UIButton) {
        
    }

    @IBAction func backButtonTouched(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func menuButtonTouced(_ sender: UIButton) {
        clickedButton.backgroundColor = .white
        clickedButton.tintColor = .black
        
        sender.backgroundColor = .black
        sender.tintColor = .white
        clickedButton = sender
        
        scrollView.setContentOffset(sender.frame.origin, animated: true)
    }
}

extension OrderViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! OrderCell
        
        if indexPath.section == 0 {
            cell.titleLabel.text = array1[indexPath.row]
        }
        
        if indexPath.section == 1 {
            cell.titleLabel.text = array2[indexPath.row]
        }
        
        if indexPath.section == 2 {
            cell.titleLabel.text = array3[indexPath.row]
        }
        
        if indexPath.section == 3 {
            cell.titleLabel.text = array4[indexPath.row]
        }
        
        if indexPath.section == 4 {
            cell.titleLabel.text = array5[indexPath.row]
        }
        
        if indexPath.section == 5 {
            cell.titleLabel.text = array6[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return array1.count
        }
        else if section == 1 {
            return array2.count
        }
        else if section == 2 {
            return array3.count
        }
        else if section == 3 {
            return array4.count
        }
        else if section == 4 {
            return array5.count
        }
        else if section == 5 {
            return array6.count
        }
        return 0
    }
}

extension OrderViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height / 7
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

class OrderCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
}
