import UIKit

// MARK: - LibraryInputView
final class LibraryInputView: UIView {
    // MARK: - GUI
    lazy var addFileButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = .darkGray
        
        //constraints
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 100),
            button.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        return button
    }()
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupAddFileButtonLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setupView() {
        self.backgroundColor = .white
    }
    
    private func setupAddFileButtonLayout() {
        self.addSubview(addFileButton)
        NSLayoutConstraint.activate([
            addFileButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            addFileButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
