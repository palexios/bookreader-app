import UIKit
import Foundation

// MARK: - BookView
final class BookCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    private let progressViewWidthPercent = 6.1068
    private let progressViewHeightPercent = 2.8196
    
    private let coverImageViewWidthPercent = 38.1679
    private let coverImageViewHeightPercent = 24.9433
    
    // MARK: - GUI
    private lazy var coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var progressView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        
        //constraints
        view.translatesAutoresizingMaskIntoConstraints = false
        let width = CGFloat(round(UIScreen.main.bounds.width * progressViewWidthPercent / 100))
        let height = width
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: width),
            view.heightAnchor.constraint(equalToConstant: height)
        ])
        view.layer.cornerRadius = width / 2
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
    
    private lazy var actionMenuBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .appBookActionMenuBackground.withAlphaComponent(0.95)
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var actionMenuStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var actionMenuReadButton: UIButton = {
        let button = self.createButtonForActionMenu()
        button.setTitle("Читать", for: .normal)
        button.addTarget(self, action: #selector(actionMenuReadButtonAction), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var actionMenuQuotesButton: UIButton = {
        let button = self.createButtonForActionMenu()
        button.setTitle("Цитаты", for: .normal)
        
        return button
    }()
    
    private lazy var actionMenuEditButton: UIButton = {
        let button = self.createButtonForActionMenu()
        button.setTitle("Редактировать", for: .normal)
        
        return button
    }()
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureCell()
        configureCoverImageViewLayout()
        configureProgressViewLayout()
        configureProgressTitleLabelLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    // MARK: - Methods
    func setupUI(cover: Data, status: UInt) {
        let image = UIImage(data: cover)
        self.coverImageView.image = image
        
        if status == 100 {
            self.replaceView(progressTitleLabel, with: progressDoneImageView, in: progressView)
        } else {
            self.progressTitleLabel.text = "\(status)%"
        }
    }
    
    // MARK: - Private Methods
    private func createButtonForActionMenu() -> UIButton {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        button.setTitleColor(.appGray, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 15
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }
    private func configureCell() {
        self.layer.cornerRadius = 15
        self.setShadow()
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
    
    // MARK: - Action Menu Methods
    private var actionMenuBackgroundViewConstraints: [NSLayoutConstraint] = []
    private var actionMenuStackViewConstraints: [NSLayoutConstraint] = []
    
    func startActionMenu() {
        DispatchQueue.main.async {
            self.activateActionMenuBackgroundViewLayout()
            self.activateActionMenuStackViewLayout()
            self.layoutIfNeeded()
        }
    }
    
    func endActionMenu() {
        DispatchQueue.main.async {
            self.deactivateActionMenuBackgroundViewLayout()
            self.deactivateActionMenuStackViewLayout()
            
            self.layoutIfNeeded()
        }
    }
    
    private func activateActionMenuBackgroundViewLayout() {
        self.addSubview(actionMenuBackgroundView)
        
        actionMenuBackgroundViewConstraints = [
            self.actionMenuBackgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.actionMenuBackgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.actionMenuBackgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            self.actionMenuBackgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(actionMenuBackgroundViewConstraints)
    }
    
    private func activateActionMenuStackViewLayout() {
        let topInset = self.frame.height * 0.427272
        self.actionMenuBackgroundView.addSubview(actionMenuStackView)
        
        actionMenuStackViewConstraints = [
            self.actionMenuStackView.topAnchor.constraint(equalTo: self.actionMenuBackgroundView.topAnchor, constant: topInset),
            self.actionMenuStackView.leadingAnchor.constraint(equalTo: self.actionMenuBackgroundView.leadingAnchor, constant: 11),
            self.actionMenuStackView.trailingAnchor.constraint(equalTo: self.actionMenuBackgroundView.trailingAnchor, constant: -10),
            self.actionMenuStackView.bottomAnchor.constraint(equalTo: self.actionMenuBackgroundView.bottomAnchor, constant: -10),
        ]
        
        NSLayoutConstraint.activate(actionMenuStackViewConstraints)
        
        self.actionMenuStackView.addArrangedSubview(actionMenuReadButton)
        self.actionMenuStackView.addArrangedSubview(actionMenuQuotesButton)
        self.actionMenuStackView.addArrangedSubview(actionMenuEditButton)
    }
    
    private func deactivateActionMenuBackgroundViewLayout() {
        NSLayoutConstraint.deactivate(actionMenuBackgroundViewConstraints)
        actionMenuBackgroundViewConstraints = []
    }
    
    private func deactivateActionMenuStackViewLayout() {
        NSLayoutConstraint.deactivate(actionMenuStackViewConstraints)
        self.actionMenuStackView.removeFromSuperview()
        actionMenuStackViewConstraints = []
    }
    
    // MARK: - Ojbc Private Methods
    @objc private func actionMenuReadButtonAction() {
        print("read")
    }

}
