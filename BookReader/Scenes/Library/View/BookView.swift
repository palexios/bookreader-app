import UIKit

// MARK: - BookView
final class BookView: UIView {
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        setupLayout()
        setupBorder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setupLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 100),
            self.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    private func setupBorder() {
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor.black.cgColor
    }
}
