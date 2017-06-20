//
//  ReviewsViewController.swift
//  CarSell
//
//  Created by Vadim on 5/28/17.
//  Copyright © 2017 Vadim Prosviryakov. All rights reserved.
//

import UIKit
import KVNProgress

class ReviewsViewController: UIViewController, ReviewsViewControllerInput {
    
 
    @IBOutlet var tableView: UITableView!
    static let cellString = String(describing: "\(ReviewsViewCell.self)")
    var reviewsViewControllerOutput: ReviewsViewControllerOutput!
    var reloadCar = false
    var markCar: [Car]?  {
        didSet {
            guard isViewLoaded else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ReviewsAssembly.sharedInstanceReviews.configure(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        self.reviewsViewControllerOutput.getCarsInteractor()
    }
    
    func setupTableView() {
        tableView.rowHeight = 90
        tableView.separatorStyle = .none
        tableView.register(ReviewsViewCell.self as AnyClass, forCellReuseIdentifier: ReviewsViewController.cellString)
    }
    
    func displayCars(_ car: [Car]) {
        self.markCar = car
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.reloadCar = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        reviewsViewControllerOutput.passDataReviewsDetail(segue)
    }
    
    @IBAction func exit(_ sender: Any) {
        markCar?.removeAll()
        self.dismiss(animated: true, completion: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // TODO - temporary solution load car
        if reloadCar == true {
            let currentOffset = scrollView.contentOffset.y
            let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
            let deltaOffset = maximumOffset - currentOffset + 40
            if deltaOffset >= 0 {
                DispatchQueue.main.async {
                    self.reviewsViewControllerOutput.getCarsInteractor()
                    self.reloadCar = false
                }
            }
        }
    }
}


// MARK: - UITableViewDataSource -
extension ReviewsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard self.markCar != nil else {
            return 0
        }
        return self.markCar!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReviewsViewController.cellString, for: indexPath) as! ReviewsViewCell
        cell.setupCell(car: markCar!, row: indexPath.row)
        return cell
    }
}


// MARK: - UITableViewDelegate -
extension ReviewsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor(red: 0.99, green: 0.99, blue: 0.99, alpha: 1.0) // very light gray
        } else {
            cell.backgroundColor = UIColor.white
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.reviewsViewControllerOutput.performSegueCarDetail()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
