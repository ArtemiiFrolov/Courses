//
//  CitiesViewController.swift
//  City Guide
//
//  Created by Paul Schmiedmayer on 10/8/17.
//  Copyright © 2017 TUM LS1. All rights reserved.
//

import UIKit

class CitiesViewController: UIPageViewController {
    var cityViewController: [CityViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.dataSource = self
        
        self.view.backgroundColor = .white
        
        reloadData()
    }
    
    @IBAction func prepareFor(unwindSegue segue: UIStoryboardSegue) {
        reloadData()
    }
    
    func reloadData() {
        for city in DataHandler.cities where cityViewController.filter({ $0.city == city }).isEmpty {
            if let viewController = storyboard?.instantiateViewController(withIdentifier: "cityViewController") as? CityViewController {
                viewController.city = city
                cityViewController.append(viewController)
            }
        }
        
        guard let lastViewController = cityViewController.last else {
            return
        }
        
        setViewControllers([lastViewController], direction: .forward, animated: true)
    }
}

extension CitiesViewController: UIPageViewControllerDelegate {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return cityViewController.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return cityViewController.count - 1
    }
}

extension CitiesViewController: UIPageViewControllerDataSource {
    enum ViewControllerPosition: Int {
        case before = -1
        case after = 1
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return getViewController(.before, viewController: viewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return getViewController(.after, viewController: viewController)
    }
    
    private func getViewController(_ position: ViewControllerPosition, viewController: UIViewController) -> UIViewController? {
        guard let currentCityViewController = viewController as? CityViewController,
            let currentIndex = cityViewController.index(of: currentCityViewController) else {
                return nil
        }
        
        let nextIndex = currentIndex + position.rawValue
        guard 0..<cityViewController.count ~= nextIndex else {
            return nil
        }
        return cityViewController[nextIndex]
    }
}
