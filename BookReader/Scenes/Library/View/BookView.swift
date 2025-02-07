import UIKit
import Foundation

// MARK: - BookView
final class BookView: UICollectionViewCell {
    // MARK: - Properties
    private let progressViewWidthPercent = 6.1068
    private let progressViewHeightPercent = 2.8196
    
    private let coverImageViewWidthPercent = 38.1679
    private let coverImageViewHeightPercent = 24.9433
    
    // MARK: - GUI
    private lazy var coverImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var progressView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        //constraints
        view.translatesAutoresizingMaskIntoConstraints = false
        let width = CGFloat(round(UIScreen.main.bounds.width * progressViewWidthPercent / 100))
        let height = width
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: width),
            view.heightAnchor.constraint(equalToConstant: height)
        ])
        
        return view
    }()
    
    private lazy var progressTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 9, weight: .semibold)
        label.textColor = .black
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var progressDoneImageView: UIImageView = {
        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold)
        let image = UIImage(systemName: "checkmark", withConfiguration: imageConfiguration)
        let imageView = UIImageView(image: image)
        imageView.tintColor = .appGreen
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    // MARK: - LifeCycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.progressView.layer.cornerRadius = self.progressView.frame.width / 2
        
    }
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        configureCell()
        configureCoverImageViewLayout()
        configureProgressViewLayout()
        configureProgressTitleLabelLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func setupUI(cover: UIImage, percent: Int) {
        self.coverImageView.image = cover
        
        if percent == 100 {
            self.replaceView(progressTitleLabel, with: progressDoneImageView, in: progressView)
        } else {
            self.progressTitleLabel.text = "\(percent)%"
        }
        
    }
    
    // MARK: - Private Methods
    private func configureCell() {
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
    }
    
    private func configureCoverImageViewLayout() {
        self.contentView.addSubview(coverImageView)
        NSLayoutConstraint.activate([
            coverImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            coverImageView.topAnchor.constraint(equalTo: self.topAnchor),
            coverImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func configureProgressViewLayout() {
        self.contentView.addSubview(progressView)
        NSLayoutConstraint.activate([
            progressView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 4),
            progressView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 4)
        ])
    }
    
    private func configureProgressTitleLabelLayout() {
        self.progressView.addSubview(progressTitleLabel)
        NSLayoutConstraint.activate([
            progressTitleLabel.centerXAnchor.constraint(equalTo: self.progressView.centerXAnchor),
            progressTitleLabel.centerYAnchor.constraint(equalTo: self.progressView.centerYAnchor)
        ])
    }
    
    private func replaceView(_ oldView: UIView, with newView: UIView, in parentView: UIView) {
        UIView.transition(with: parentView, duration: 0.3, options: .transitionCrossDissolve, animations: {
            oldView.removeFromSuperview()
        }, completion: { [weak self] _ in
            guard let self = self else { return }
            parentView.addSubview(newView)
            
            NSLayoutConstraint.activate([
                newView.centerXAnchor.constraint(equalTo: self.progressView.centerXAnchor),
                newView.centerYAnchor.constraint(equalTo: self.progressView.centerYAnchor)
            ])
        })
    }

}
