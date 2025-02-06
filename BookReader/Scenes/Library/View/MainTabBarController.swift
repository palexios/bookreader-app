import UIKit

// MARK: - MainTabBarController
final class MainTabBarController: UITabBarController {
    // MARK: - Properties
    private var plusButtonWidth: CGFloat {
        UIScreen.main.bounds.width * plusButtonProportional
    }
    private let plusButtonProportional: CGFloat = 0.139949
    
    // MARK: - GUI
    private lazy var plusButton: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.black.withAlphaComponent(0.3).cgColor
        button.layer.borderWidth = 0.33
        button.layer.cornerRadius = plusButtonWidth / 2
        button.backgroundColor = self.tabBar.backgroundColor
        button.addTarget(self, action: #selector(plusButtonAction), for: .touchUpInside)
        
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 40, weight: .regular)
        let symbolImage = UIImage(systemName: "plus", withConfiguration: symbolConfiguration)
        let imageView = UIImageView(image: symbolImage)
        imageView.tintColor = .appGray
        
        //constraints for button
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: plusButtonWidth),
            button.heightAnchor.constraint(equalTo: button.widthAnchor, multiplier: 1)
        ])
        
        //constraints for imageView
        imageView.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: button.centerYAnchor)
        ])
        
        return button
    }()
    
    // MARK: - Init
    init() {
        super.init(nibName: nil, bundle: nil)
        self.delegate = self
        
        configureTabBar()
        configurePlusButtonLayout()
        configureViewControllers()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func configureTabBar() {
        self.tabBar.layer.borderColor = UIColor.black.withAlphaComponent(0.3).cgColor
        self.tabBar.layer.borderWidth = 0.33
        self.tabBar.backgroundColor = .white
    }
    private func configureViewControllers() {
        let libraryVC = LibraryViewController()
        libraryVC.tabBarItem = UITabBarItem(title: "Моя библиотека", image: UIImage(systemName: "book"), selectedImage: UIImage(systemName: "book")?.withTintColor(.systemBlue))
        
        let emptyVC = UIViewController()
        emptyVC.tabBarItem = UITabBarItem(title: nil, image: nil, selectedImage: nil)
        
        let settingsVC = SettingsViewController()
        settingsVC.tabBarItem = UITabBarItem(title: "Настройки", image: UIImage(systemName: "gear"), selectedImage: UIImage(systemName: "gear")?.withTintColor(.systemBlue))
        
        self.viewControllers = [UINavigationController(rootViewController: libraryVC), emptyVC, settingsVC]
    }
    private func configurePlusButtonLayout() {
        let indentTop = self.plusButtonWidth * 0.363636
        self.view.addSubview(plusButton)
        NSLayoutConstraint.activate([
            plusButton.centerXAnchor.constraint(equalTo: self.tabBar.centerXAnchor),
            plusButton.topAnchor.constraint(equalTo: self.tabBar.topAnchor, constant: -indentTop)
        ])
    }
    
    // MARK: - OBJC Methods
    @objc private func plusButtonAction() {
        // TODO: add tap handler
        print("tap")
    }
}

// MARK: - UITabBarControllerDelegate
extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return self.viewControllers?.firstIndex(of: viewController) != 1
    }
}
