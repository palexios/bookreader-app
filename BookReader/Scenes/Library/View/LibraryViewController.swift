import UIKit

// MARK: - LibraryViewController
final class LibraryViewController: UIViewController {
    // MARK: - Properties
    
    
    // MARK: - Input view
    override func loadView() {
        self.view = LibraryInputView()
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationItem()
        
        // setup mock fb2 book to Files on the simulator
        FManager.shared.writeMockFB2Book()
        
        print(FManager.shared.getMockFB2BookData())
    }
    
    // MARK: - Private Methods
    private func setupNavigationItem() {
        self.navigationItem.title = "Моя библиотека"
        self.navigationItem.largeTitleDisplayMode = .always
    }
}
