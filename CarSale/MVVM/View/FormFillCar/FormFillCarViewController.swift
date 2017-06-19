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

    @IBOutlet weak var tableView: UITableView!
    static let cellString = String(describing: FormFillCarViewController.self)
    let disposeBag = DisposeBag()
    weak var formView: FormCreateCarViewController!
    var fieldSelected: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        getModelMarks()
        setupDelegate()
    }
    
    func setupTableView() {
        navigationController?.delegate = self
        navigationController?.navigationBar.isTranslucent = false
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.register(FormFillCarCell.self, forCellReuseIdentifier: FormFillCarViewController.cellString)
        tableView.contentInset = UIEdgeInsetsMake(8, 0, 0, 0)
        tableView.backgroundColor = UIColor(red: 237, green: 237, blue: 237)
        closePage()
    }
    
    func getModelMarks() {
        KVNProgress.show()
        _ = CarDataManager.instance.getMarks().subscribe(onNext: {(models) in
            self.setupDataSource(models: models)
            DispatchQueue.main.async {
                self.tableView.reloadData()
                KVNProgress.dismiss()
            }
        })
    }
    
    
    //MARK: UITableViewDataSource
    func setupDataSource(models: [Models]) {
        switch self.fieldSelected {
        case Fields.mark?:
            let markToCell = Observable.just(models.map {$0.title})
            markToCell.bind(to: tableView.rx.items(cellIdentifier: FormFillCarViewController.cellString, cellType: FormFillCarCell.self)) { row, mark, cell in
                
                cell.titleFormFillCar.text = mark
                }.addDisposableTo(disposeBag)
            
            
        case Fields.model?:
            let modelToCell = Observable.just(models[self.formView.dataForm.indexSelected!].model)
            modelToCell.bind(to: tableView.rx.items(cellIdentifier: FormFillCarViewController.cellString, cellType: FormFillCarCell.self)) { row, model, cell in
                
                cell.titleFormFillCar.text = model
                }.addDisposableTo(disposeBag)
            
        default: break
        }
    }
    
    ////MARL: UITableViewDelegate
    func setupDelegate() {
        tableView.rx.modelSelected(String.self)
            .subscribe(onNext: {(models) in
                
                if let selectedRowIndexPath = self.tableView.indexPathForSelectedRow {
                    self.tableView.deselectRow(at: selectedRowIndexPath, animated: true)
                    
                    switch self.fieldSelected {
                    case Fields.mark?:
                        self.formView.dataForm.mark = models
                        self.formView.dataForm.indexSelected = selectedRowIndexPath.row
                        self.formView.dataForm.model?.removeAll()
                    case Fields.model?:
                        self.formView.dataForm.model = models
                    default: break
                    }
                    self.handleClose()
                }
            }).addDisposableTo(disposeBag)
    }
    
    func closePage() {
        let moreButton = UIBarButtonItem(title: Fields.close, style: .plain, target: self, action: #selector(handleClose))
        navigationItem.leftBarButtonItem = moreButton
    }
    
    func handleClose() {
        self.dismiss(animated: true, completion: nil)
    }
}
