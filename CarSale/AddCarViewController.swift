//
//  AddCarViewController.swift
//  CarSale
//
//  Created Vadim on 5/30/17.
//  Copyright © 2017 Vadim Prosviryakov. All rights reserved.
//
//

import UIKit

class AddCarViewController: UIViewController, AddCarViewProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    var presenter: AddCarPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        tableView.register(AddCarTableViewCell.self as AnyClass, forCellReuseIdentifier: "AddCell")
        tableView.rowHeight = 120
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.backgroundColor = UIColor(red: 237, green: 237, blue: 237)
        tableView.separatorColor = UIColor(red: 237, green: 237, blue: 237)
        setupMenuBar()
        setupNavBarButtons()
    }
    
    //MARK: - Setup Menu Bar -
    internal func setupMenuBar() {
        let menuBar: AddMenuBar = {
            let mb = AddMenuBar()
            return mb
        }()
        view.addSubview(menuBar)
        view.addConstraintsWithFormat("H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat("V:|[v0(50)]", views: menuBar)
    }
}

//MARK: - UITableViewDataSource -

extension AddCarViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AddCarTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "AddCell")
        
        switch indexPath.row {
        case 0:
            cell.addTextCar.text = "Сейчас возможно добавить только обьявление о продаже автомобиля"
            cell.addButton.addTarget(self, action: #selector(buttonTouched(button:)), for: .touchUpInside)
            cell.backgroundColor = UIColor(red: 255, green: 255, blue: 255)
        case 1:
            cell.addTextCar.text = "Нет добавленных объявлений"
            cell.addTextCar.textColor = .darkGray
            cell.addTextCar.backgroundColor = UIColor(red: 237, green: 237, blue: 237)
            cell.addButton.isHidden = true
            cell.backgroundColor = UIColor(red: 237, green: 237, blue: 237)
        default:
            print("")
            
        }
        return cell
    }
    
    //MARK: - Setup NavBarButtons -
    
    func setupNavBarButtons() {
        let gearButton = UIImage(named: "gear")?.withRenderingMode(.alwaysOriginal)
        let gearBarButtonItem = UIBarButtonItem(image: gearButton, style: .plain, target: self, action: #selector(handleMore))
        let userButton = UIImage(named: "user")?.withRenderingMode(.alwaysOriginal)
        let userBarButtonItem = UIBarButtonItem(image: userButton, style: .plain, target: self, action: #selector(handleMore))
        navigationItem.leftBarButtonItems = [gearBarButtonItem]
        navigationItem.rightBarButtonItems = [userBarButtonItem]
    }
    
    func handleMore() {
        
    }
    
    //MARK: - ??? -
    
    func buttonTouched(button: UIButton) {
        let nextView = self.storyboard?.instantiateViewController(withIdentifier: "AddCar")
        self.present(nextView!, animated: true, completion: nil)
    }
}

//MARK: - UITableViewDelegate -

extension AddCarViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: CGRect.zero)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
