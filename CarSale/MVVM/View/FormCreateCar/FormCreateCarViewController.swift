//
//  FormCreateCarViewController.swift
//  CarSale
//
//  Created by Vadim on 5/18/17.
//  Copyright © 2017 Vadim Prosviryakov. All rights reserved.
//

import UIKit
import ImagePicker
import Lightbox
import RxCocoa
import RxCocoa

final class FormCreateCarViewController: UIViewController, ImagePickerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    let fields = ["Марка","Модель","Выбрать фотографии"]
    let send = ["Отправить данные"]
    
    var imageFromCamera = [UIImage]()
    var dataForm = Form()
    var colorForCellUnselected = UIColor(red: 237, green: 237, blue: 237)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    
    func setupTableView() {
        navigationController?.navigationBar.isTranslucent = false
        tableView.contentInset = UIEdgeInsetsMake(8, 0, 0, 0)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.separatorColor = .lightGray
        tableView.backgroundColor = UIColor(red: 237, green: 237, blue: 237)
        tableView.register(ReviewsDetailCollectionCell.self, forCellReuseIdentifier: ReviewsDetailCollectionCell.cellString)
        setupNavBarButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - ImagePicker -
    func selectImages() {
        var config = Configuration()
        config.doneButtonTitle = "Finish"
        config.noImagesTitle = "Sorry! There are no images here!"
        config.recordLocation = false
        config.allowVideoSelection = true
        
        let imagePicker = ImagePickerController()
        imagePicker.configuration = config
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - ImagePickerDelegate -
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        guard images.count > 0 else { return }
        let lightboxImages = images.map {
            return LightboxImage(image: $0)
        }
        let lightbox = LightboxController(images: lightboxImages, startIndex: 0)
        imagePicker.present(lightbox, animated: true, completion: nil)
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        imageFromCamera = images
        imagePicker.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource -
extension FormCreateCarViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return fields.count - 1
        case 1:
            return 1
        case 2:
            return send.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return ""
        case 1:
            return " "
        case 2:
            return " "
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        let row = indexPath.row
        let section = indexPath.section
        switch section {
        case 0:
            switch row {
            case 0:
                if dataForm.mark != nil {
                    cell.textLabel?.text = dataForm.mark
                    cell.textLabel?.textColor = .black
                    colorForCellUnselected = .white
                } else {
                    cell.textLabel?.text = fields[row]
                    cell.textLabel?.textColor = .lightGray
                }
            case 1:
                if dataForm.model != nil && dataForm.model != "" {
                    cell.textLabel?.text = dataForm.model
                    cell.textLabel?.textColor = .black
                } else {
                    cell.textLabel?.text = fields[row]
                    cell.textLabel?.textColor = .lightGray
                    cell.contentView.backgroundColor = colorForCellUnselected
                }
            default: break
            }
        case 1:
            switch row {
            case 0:
                if !imageFromCamera.isEmpty {
                    let cell: ReviewsDetailCollectionCell = tableView.dequeueReusableCell(withIdentifier: ReviewsDetailCollectionCell.cellString, for: indexPath) as! ReviewsDetailCollectionCell
                    cell.newFormImage = imageFromCamera
                    cell.collectionView.reloadData()
                    return cell
                } else {
                    cell.imageView?.image = UIImage(named: "camera")
                    cell.textLabel?.textColor = .lightGray
                }
            default: break
            }
        case 2:
            switch row {
            case 0:
                cell.textLabel?.text = send[row]
                cell.textLabel?.textAlignment = .center
                cell.textLabel?.textColor = UIColor(red: 85, green: 187, blue: 0)
            default: break
            }
        default: break
        }
        return cell
    }
}

// MARK: - UITableViewDelegate -
extension FormCreateCarViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                newView(indexPath: indexPath.row)
            case 1:
                dataForm.mark?.isEmpty == nil ? tableView.deselectRow(at: indexPath, animated: true) : newView(indexPath: indexPath.row)
            default: break
            }
        case 1:
            switch indexPath.row {
            case 0:
                selectImages()
            default: break
            }
        case 2:
            switch indexPath.row {
            case 0:
                prepareRequest()
            default: break
            }
        default: break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func newView(indexPath: Int) {
        let newView = self.storyboard?.instantiateViewController(withIdentifier: FormFillCarViewController.cellString) as! FormFillCarViewController
        newView.fieldSelected = fields[indexPath]
        newView.formView = self
        let nextNavi = UINavigationController(rootViewController: newView)
        self.navigationController?.showDetailViewController(nextNavi, sender: self)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 250
        }
        return 50
    }
    
    func setupNavBarButtons() {
        let moreButton = UIImage(named: "close")?.withRenderingMode(.alwaysOriginal)
        let moreBarButtonItem = UIBarButtonItem(image: moreButton, style: .plain, target: self, action: #selector(handleClose))
        navigationItem.leftBarButtonItems = [moreBarButtonItem]
    }
    
    func prepareRequest() {
        CarDataManager.instance.prepareRequest(image: imageFromCamera, mark: dataForm.mark!, model: dataForm.model!)
        imageFromCamera.removeAll()
        handleClose()
    }
    
    func handleClose() {
        dismiss(animated: true, completion: nil)
    }
}
