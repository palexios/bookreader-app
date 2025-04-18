import UIKit

// MARK: - MainTabBarController
final class MainTabBarController: UITabBarController {
    // MARK: - GUI
    private lazy var plusButton: PlusButton = {
        let button = PlusButton(buttonTapped: { [weak self] in
            self?.plusButtonAction()
        })
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Init
    init() {
        super.init(nibName: nil, bundle: nil)
        self.delegate = self
        
        configure()
        layoutConfigurePlusButton()
        configureViewControllers()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func configure() {
        self.tabBar.layer.borderColor = Resources.Colors.border.cgColor
        self.tabBar.layer.borderWidth = 0.33
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = .systemBlue
    }
    
    private func configureViewControllers() {
        let libraryVC = LibraryViewController(viewModel: LibraryViewModel())
        libraryVC.tabBarItem = UITabBarItem(title: Tab.library.title, image: Tab.library.image, tag: Tab.library.tag)
        
        let emptyVC = UIViewController()
        emptyVC.tabBarItem = UITabBarItem(title: nil, image: nil, tag: 1)
        
        let settingsVC = SettingsViewController()
        settingsVC.tabBarItem = UITabBarItem(title: Tab.settings.title, image: Tab.settings.image, tag: Tab.settings.tag)
        
        let navVC = UINavigationController(rootViewController: libraryVC)
        
        self.viewControllers = [navVC, emptyVC, settingsVC]
    }
    
    // MARK: - OBJC Methods
    @objc private func plusButtonAction() {
        let vc = AddingViewController(viewModel: AddingViewModel())
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Layout
private extension MainTabBarController {
    private func layoutConfigurePlusButton() {
        let topInset = -self.tabBar.frame.height * 0.35
        self.view.addSubview(plusButton)
        NSLayoutConstraint.activate([
            plusButton.centerXAnchor.constraint(equalTo: self.tabBar.centerXAnchor),
            plusButton.topAnchor.constraint(equalTo: self.tabBar.topAnchor, constant: topInset)
        ])
    }
}

// MARK: - UITabBarControllerDelegate
extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return self.viewControllers?.firstIndex(of: viewController) != 1
    }
}
