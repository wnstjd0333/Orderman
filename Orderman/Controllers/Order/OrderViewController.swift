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
    
    private let cellHeight = CGFloat(80)
    private var clickedButton = UIButton()
    private var menuButtons = [UIButton]()
    private var isScrolling = false

    weak var delegate: OrderViewControllerDelegate?
    
    // Test
    let sectionTitles = ["カレーセット Curry Set", "カレー単品", "ライス Rice", "ナン Naan", "サラダ Salad", "サイド Side"]
    let datas = [
        ["カレーナンセット \nCurry & Naan Set", "ダブルカレーナンセット \nDouble Curry Set"],
        ["バターチキンカレー \nButter Chicken Curry", "ベジタブルカレー \nVegetable Curry", "タマゴカレー \nEgg Curry", "キーマエッグカレー \nKeema Egg Curry", "マトンカレー \nMutton Curry", "エビカレー \nShrimp Curry", "サーグマトン \nSaag Button", "パラクパニーる \nPalak Paneer", "チキンラバダ \nChicken Labbadha", "マトンラバダ \nMutton Labbadha", "マッシュルームパラウ \nMushroom Palak", "ダルマトン \nDal Mutton"],
        ["特製ビリヤニ \nBiryani", "スパイシーチャーハン \nSpicy Fried Rice", "ジーラライス \nZeera Rice", "チキンフライドライス \nChicken Fried Rice"],
        ["ナン Naan", "ガーリックナン \nGarlic Naan", "カブリナン Kabuli Naan", "チーズナン Cheeze Naan"],
        ["グリーンサラダ \nGreen Salad", "卵サラダ Egg Salad", "トスサラダ Toss Salad"],
        ["サモサ Samosas", "タンドリーチキン \nTandoori Chicken", "タンドリーミックスグリル \nTandoori Mix Grill"]
    ]
    
    @IBOutlet weak private var menuScrollView: UIScrollView!
    @IBOutlet weak private var menuStackView: UIStackView!
    @IBOutlet weak private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
        navigationItem.title = delegate?.getOrderTitle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isHidden = false
        
        for (i,title) in sectionTitles.enumerated() {
            let button = UIButton()
            button.setTitle(title, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.layer.cornerRadius = 16
            button.tag = i
            button.titleLabel?.minimumScaleFactor = 0.7
            button.titleLabel?.numberOfLines = 1
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.titleLabel?.lineBreakMode = NSLineBreakMode.byClipping
            button.addTarget(self, action: #selector(munuButtonTouched), for: .touchUpInside)
            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            menuStackView.addArrangedSubview(button)
            menuButtons.append(button)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    @objc func munuButtonTouched(_ sender: UIButton) {
        clickedButton.backgroundColor = .white
        clickedButton.setTitleColor(.black, for: .normal)
        
        sender.setTitleColor(.white, for: .normal)
        sender.backgroundColor = .black
        clickedButton = sender
        menuScrollView.setContentOffset(sender.frame.origin, animated: true)
        
        let stackViewInset = CGFloat(32)
        if menuStackView.frame.width - sender.frame.origin.x < menuScrollView.frame.width {
            menuScrollView.setContentOffset(CGPoint(x: menuStackView.frame.width -
                                                    menuScrollView.frame.width +
                                                    stackViewInset,
                                                y: sender.frame.origin.y),
                                        animated: true)
        }
        
        let indexPath = IndexPath(row: 0, section: sender.tag)
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.top)
        isScrolling = true
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension OrderViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! OrderCell
        
        for i in 0...menuButtons.count - 1 {
            if indexPath.section == i {
                cell.titleLabel.text = datas[i][indexPath.row]
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        for i in stride(from: menuButtons.count - 1, through: 0, by: -1) {
            if section == i {
                return datas[i].count
            }
        }
        return 0
    }
}

extension OrderViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "Order", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "OrderDetailVC") as! OrderDetailViewController
        
        viewController.menuTitle = datas[indexPath.section][indexPath.row]
    
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellHeight * 0.6
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        isScrolling = false
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
                
        if isScrolling {
            return
        }
        
        if scrollView == tableView {
        
            let scrollPoint = CGPoint(x: 0, y: scrollView.contentOffset.y)
            guard let section = tableView.indexPathForRow(at: scrollPoint)?.section,
                  menuButtons.count > section  else {
                return
            }

            clickedButton.backgroundColor = .white
            clickedButton.setTitleColor(.black, for: .normal)
            menuButtons[section].backgroundColor = .black
            menuButtons[section].setTitleColor(.white, for: .normal)
            clickedButton = menuButtons[section]

            self.menuScrollView.setContentOffset(menuButtons[section].frame.origin, animated: false)

            let stackViewInset = CGFloat(32)
            if menuStackView.frame.width - menuButtons[section].frame.origin.x < menuScrollView.frame.width {
                menuScrollView.setContentOffset(CGPoint(x: menuStackView.frame.width -
                                                            menuScrollView.frame.width +
                                                        stackViewInset,
                                                    y: menuButtons[section].frame.origin.y),
                                            animated: false)
            }
        }
    }
}

class OrderCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
}

