import UIKit
import Foundation

// MARK: - BookProgress
enum BookProgress {
    case value(Int)
    case done
}

// MARK: - BookView
final class BookView: UIView {
    // MARK: - Properties
    private let progressImageViewWidthPercent = 6.1068
    private let progressImageViewHeightPercent = 2.8196
    
    private let coverImageViewWidthPercent = 38.1679
    private let coverImageViewHeightPercent = 24.9433
    
    // MARK: - GUI
    private lazy var coverImageView: UIImageView = {
        let imageView = UIImageView()
        
        //constraints
        let width = CGFloat(round(UIScreen.main.bounds.width * coverImageViewWidthPercent / 100))
        let height = CGFloat(round(UIScreen.main.bounds.width * coverImageViewHeightPercent / 100))
        
        return imageView
    }()
    
    private lazy var progressImageView: UIImageView = {
        let imageView = UIImageView()
        
        //constraints
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let width = CGFloat(round(UIScreen.main.bounds.width * progressImageViewWidthPercent / 100))
        let height = width
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: width),
            imageView.heightAnchor.constraint(equalToConstant: height)
        ])
        
        return imageView
    }()
    
    // MARK: - LifeCycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.progressImageView.layer.cornerRadius = self.progressImageView.frame.width / 2
    }
    
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
