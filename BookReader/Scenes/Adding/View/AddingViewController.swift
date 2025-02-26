import UIKit

// MARK: - AddingViewController
final class AddingViewController: UIViewController {
    // MARK: - Life Cycle
    override func loadView() {
        self.view = AddingInputView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
