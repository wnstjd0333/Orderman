//
//  OrderStartViewController.swift
//  Orderman
//
//  Created by kimjunseong on 2020/11/30.
//

import UIKit

class OrderStartViewController: UIViewController {

    private var manNumber = 0
    private var womanNumber = 0
    
    @IBOutlet private weak var orderWayLabel: UILabel!
    @IBOutlet private weak var orderManLabel: UILabel!
    @IBOutlet private weak var orderWomanLabel: UILabel!
    @IBOutlet private weak var segmentControl: UISegmentedControl!
    @IBOutlet private weak var manMinusButton: UIButton!
    @IBOutlet private weak var manPlusButton: UIButton!
    @IBOutlet private weak var manNumberLabel: UILabel!
    @IBOutlet private weak var womenMinusButton: UIButton!
    @IBOutlet private weak var womanPlusButton: UIButton!
    @IBOutlet private weak var womanNumberLabel: UILabel!
    @IBOutlet private weak var tableNumberField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APITest().test()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func segmentTouched(_ sender: UISegmentedControl) {
        orderWayLabel.text = sender.titleForSegment(at: sender.selectedSegmentIndex)
        orderWayLabel.textColor = .black
        tableNumberField.isHidden = true
        tableNumberField.text = ""
        
        if sender.selectedSegmentIndex == 0 {
            tableNumberField.isHidden = false
        }
    }
    
    @IBAction func numberTouched(_ sender: UIButton) {
        guard let number = tableNumberField.text, number.count > 1 else {
            return
        }
        
        tableNumberField.text = number + sender.title(for: .normal)!
    }
    
    @IBAction func peopleCountButtonTouched(_ sender: UIButton) {
        if sender == manMinusButton, manNumber > 0 {
            manNumber -= 1
            manNumberLabel.text = String(manNumber)
        }
        
        if sender == womenMinusButton, womanNumber > 0 {
            womanNumber -= 1
            womanNumberLabel.text = String(womanNumber)
        }
        
        if sender == manPlusButton {
            manNumber += 1
            manNumberLabel.text = String(manNumber)
        }
        
        if sender == womanPlusButton {
            womanNumber += 1
            womanNumberLabel.text = String(womanNumber)
        }
        
        if orderWayLabel.text == "注文種類＆人数" {
            orderWayLabel.text = segmentControl.titleForSegment(at: segmentControl.selectedSegmentIndex)
            orderWayLabel.textColor = .black
        }
        
        if sender == manMinusButton || sender == manPlusButton {
            orderManLabel.text = "男 \(manNumber)"
            orderManLabel.isHidden = false
            
            if manNumber == 0 {
                orderManLabel.isHidden = true
            }
        } else {
            orderWomanLabel.text = "女 \(womanNumber)"
            orderWomanLabel.isHidden = false
            if womanNumber == 0 {
                orderWomanLabel.isHidden = true
            }
        }
    }

    @IBAction func clearButtonTouched(_ sender: UIButton) {
        orderWayLabel.text = "注文種類＆人数"
        orderWayLabel.textColor = .opaqueSeparator
        orderManLabel.isHidden = true
        orderWomanLabel.isHidden = true
        segmentControl.selectedSegmentIndex = 0
        manNumberLabel.text = "0"
        womanNumberLabel.text = "0"
        tableNumberField.isHidden = false
        manNumber = 0
        womanNumber = 0
        tableNumberField.text = ""
    }
    
    @IBAction func orderButtonTouched(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Order", bundle: nil)
        let orderVC = storyboard.instantiateViewController(withIdentifier: "OrderVC") as! OrderViewController
        orderVC.delegate = self

        navigationController?.pushViewController(orderVC, animated: true)
    }
}

extension OrderStartViewController: OrderViewControllerDelegate {
    func getOrderTitle() -> String {
        var entireLabel = ""
        if let tableField = tableNumberField.text,
           var orderLabel = orderWayLabel.text,
           var manLabel = orderManLabel.text,
           var womanLabel = orderWomanLabel.text {
            
            if tableField != "", segmentControl.selectedSegmentIndex == 0 {
                entireLabel.append("\(tableField) ")
            }
        
            if orderLabel == "注文種類＆人数" {
                orderLabel = "種類未選択"
            }
            
            if orderManLabel.isHidden == true {
                manLabel = ""
            }
            
            if orderWomanLabel.isHidden == true {
                womanLabel = ""
            }
            
            entireLabel.append(orderLabel)
            entireLabel.append(" \(manLabel)")
            entireLabel.append(" \(womanLabel)")
        }
        return entireLabel
    }
}
