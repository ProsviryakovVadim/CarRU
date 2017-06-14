//
//  FillMachineFormViewController.swift
//  CarsSell
//
//  Created by Vadim on 5/19/17.
//  Copyright © 2017 Vadim Prosviryakov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import KVNProgress


enum Fields {
    static var mark     = "Марка"
    static var model    = "Модель"
    static var notFound = "Поле не найдено"
    static var close    = "Отмена"
}

class FormFillCarViewController: UIViewController, UINavigationControllerDelegate   {
    
    var tableView = UITableView()
    var fieldSelected: String?
    var formView: FormCreateCarViewController!
    
    var dataSource: [Models] = []
    var carDataManager = CarDataManager()
    let disposeBag = DisposeBag()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        getMarks()
    }
    
    
    func setupTableView() {
        navigationController?.delegate = self
        navigationController?.navigationBar.isTranslucent = false
        tableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInset = UIEdgeInsetsMake(8, 0, 0, 0)
        tableView.backgroundColor = UIColor(red: 237, green: 237, blue: 237)
        view.addSubview(tableView)
        closePage()
    }
    
    func getMarks() {
        KVNProgress.show()
        _ = carDataManager.getMarks().subscribe(onNext: {(models) in
            self.dataSource = models
            DispatchQueue.main.async {
                self.tableView.reloadData()
                KVNProgress.dismiss()
            }
        })
    }
}




//MARK: UITableViewDataSource
extension FormFillCarViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch fieldSelected {
        case Fields.mark?:
            return dataSource.count
        case Fields.model?:
            return !dataSource.isEmpty ? dataSource[formView.dataForm.indexSelected!].model!.count : 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        switch fieldSelected {
        case Fields.mark?:
            cell.textLabel?.text = dataSource[indexPath.row].title
        case Fields.model?:
            cell.textLabel?.text = dataSource[formView.dataForm.indexSelected!].model?[indexPath.row]
        default:
            cell.textLabel?.text = Fields.notFound
        }
        return cell
        
    }
}


//MARL: UITableViewDelegate
extension FormFillCarViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch fieldSelected {
        case Fields.mark?:
            formView.dataForm.mark = dataSource[indexPath.row].title!
            formView.dataForm.indexSelected = indexPath.row
            formView.dataForm.model?.removeAll()
        case Fields.model?:
            formView.dataForm.model = dataSource[formView.dataForm.indexSelected!].model?[indexPath.row]
        default: break
        }
        handleClose()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func closePage() {
        let moreButton = UIBarButtonItem(title: Fields.close, style: .plain, target: self, action: #selector(handleClose))
        navigationItem.leftBarButtonItem = moreButton
    }
    
    func handleClose() {
        self.dismiss(animated: true, completion: nil)
    }
}


final class FillMachineFormViewCell: UITableViewCell {
    @IBOutlet weak var title: UIView!
}




