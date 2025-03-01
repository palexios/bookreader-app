import UIKit

// MARK: - AddingInputView
final class AddingInputView: UIView {
    // MARK: - GUI
    private lazy var addCoverIconView: UIView = {
        let view = UIView()
        view.backgroundColor = .appGray.withAlphaComponent(0.15)
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular)
        let image = UIImage(systemName: "arrow.down.to.line", withConfiguration: imageConfiguration)
        let imageView = UIImageView(image: image)
        imageView.tintColor = .appGray
        
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        return view
    }()
    
    private lazy var addCoverView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = .init(width: 0, height: 8)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var addCoverTitleView: UIView = {
        let label = UILabel()
        label.text = "Обложка"
        label.font = UIFont.systemFont(ofSize: 16, weight: .thin)
        label.textColor = .appGray
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Добавить", for: .normal)
        button.setTitleColor(.appGray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .white
        button.setShadow()
        button.layer.cornerRadius = 15
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        
        setupView()
        setupAddCoverView()
        setupAddCoverIconView()
        setupAddCoverTitleView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setupView() {
        self.backgroundColor = .systemGray5
    }
    
    private func setupAddCoverView() {
        self.addSubview(addCoverView)
        NSLayoutConstraint.activate([
            self.addCoverView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.37),
            self.addCoverView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.25),
            self.addCoverView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.addCoverView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    private func setupAddCoverIconView() {
        self.addCoverView.addSubview(addCoverIconView)
        NSLayoutConstraint.activate([
            addCoverIconView.heightAnchor.constraint(equalTo: self.addCoverView.heightAnchor, multiplier: 0.27),
            addCoverIconView.widthAnchor.constraint(equalTo: self.addCoverView.widthAnchor, multiplier: 0.4),
            addCoverIconView.centerXAnchor.constraint(equalTo: self.addCoverView.centerXAnchor),
            addCoverIconView.centerYAnchor.constraint(equalTo: self.addCoverView.centerYAnchor)
        ])
    }
    
    private func setupAddCoverTitleView() {
        self.addCoverView.addSubview(addCoverTitleView)
        NSLayoutConstraint.activate([
            addCoverTitleView.topAnchor.constraint(equalTo: self.addCoverIconView.bottomAnchor, constant: 12),
            addCoverTitleView.centerXAnchor.constraint(equalTo: self.addCoverView.centerXAnchor)
        ])
    }

}
