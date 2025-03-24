//
//  NavigationController.swift
//  MealNote
//
//  Created by mio on 2025/02/27.
//

import UIKit

class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
    }
    
    private func setupAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.systemTeal]
        appearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }
    
    func setSeparator() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.label]
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
        self.navigationBar.compactAppearance = appearance
    }
    
    func setScrollEdgeWithoutSeparator() {
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.backgroundColor = .systemBackground
        standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.label]
        let scrollEdgeAppearance = UINavigationBarAppearance()
        scrollEdgeAppearance.backgroundColor = .systemBackground
        scrollEdgeAppearance.titleTextAttributes = [.foregroundColor: UIColor.label]
        scrollEdgeAppearance.shadowColor = .clear
        self.navigationBar.standardAppearance = standardAppearance
        self.navigationBar.scrollEdgeAppearance = scrollEdgeAppearance
        self.navigationBar.compactAppearance = scrollEdgeAppearance
    }
}
