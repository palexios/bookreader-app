import UIKit

// MARK: - AddingInputView
final class AddingInputView: UIView {
    // MARK: - Properties
    private var didSetup = false
    
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
        view.setShadow()
        
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
        stackView.spacing = 28
        
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
    
    private lazy var genreTextField: UITextField = {
        let textField = getTextField(withPlaceholder: "Жанр", tag: 2)
        
        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 18, weight: .regular)
        let image = UIImage(systemName: "arrowtriangle.down.fill", withConfiguration: imageConfiguration)
        let button = UIButton(frame: .init(origin: .zero, size: image!.size))
        button.setImage(image, for: .normal)
        button.tintColor = .appGray

        
        let padding: CGFloat = 16
        let rightView = UIView(frame: .init(x: 0, y: 0, width: image!.size.width + padding, height: image!.size.height))
        rightView.addSubview(button)
        button.center = rightView.center
        
        button.addTarget(self, action: #selector(genreButtonAction), for: .touchUpInside)

        textField.rightViewMode = .always
        textField.rightView = rightView
        
        return textField
    }()
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if !didSetup {
            setupAddCoverView()
            setupAddCoverIconView()
            setupAddCoverTitleView()
            configureTextFieldsStackView()
            configureDoneButtonLayout()
            
            //setupGenreTextFieldRightView()
            print(genreTextField.rightView!.frame)
            
            self.didSetup = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func getTextField(withPlaceholder placeholder: String, tag: Int) -> UITextField {
        let textField = UITextField()
        textField.layer.cornerRadius = 10
        textField.backgroundColor = .white
        textField.placeholder = placeholder
        textField.tag = tag
        textField.setShadow()
        textField.textColor = UIColor.black
        
        textField.setLeftPadding(12)
        
        // setting placeholder
        let font = UIFont.systemFont(ofSize: 16, weight: .thin)
        let color = UIColor.appGray
        let attributes = [NSAttributedString.Key.font: font,
                          NSAttributedString.Key.foregroundColor: color
        ]
        let attributedString = NSAttributedString(string: placeholder, attributes: attributes)
        textField.attributedPlaceholder = attributedString
        
        return textField
    }
    private func setupView() {
        self.backgroundColor = .systemGray5
    }
    
    private func setupAddCoverView() {
        let topInset = self.frame.height * 0.21
        self.addSubview(addCoverView)
        NSLayoutConstraint.activate([
            self.addCoverView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.37),
            self.addCoverView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.25),
            self.addCoverView.topAnchor.constraint(equalTo: self.topAnchor, constant: topInset),
            self.addCoverView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
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

    private func configureTextFieldsStackView() {
        self.addSubview(stackView)
        
        let width = self.frame.width * 0.75
        
        // setting stackView items
        let nameTextField = getTextField(withPlaceholder: "Название", tag: 0)
        let authorTextField = getTextField(withPlaceholder: "Автор", tag: 1)
        
        // constraints for stackView items
        for i in [nameTextField, authorTextField, genreTextField] {
            i.heightAnchor.constraint(equalToConstant: 40).isActive = true
            i.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        // constraints for stackView
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: addCoverView.bottomAnchor, constant: 28),
            self.stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        self.stackView.addArrangedSubview(nameTextField)
        self.stackView.addArrangedSubview(authorTextField)
        self.stackView.addArrangedSubview(genreTextField)
        
        print(stackView.arrangedSubviews.count)
    }
    
    private func configureDoneButtonLayout() {
        let height = self.frame.height * 0.05
        let width = self.frame.width * 0.65
        let bottomInset = -self.frame.height * 0.07
        self.addSubview(doneButton)
        NSLayoutConstraint.activate([
            doneButton.heightAnchor.constraint(equalToConstant: height),
            doneButton.widthAnchor.constraint(equalToConstant: width),
            doneButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            doneButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bottomInset),
            
        ])
    }
    
    // MARK: - OBJC Private Methods
    @objc private func genreButtonAction() {
        print("tapped")
    }
}

private extension UITextField {
    func setLeftPadding(_ amount: CGFloat) {
        let view = UIView(frame: .init(x: 0, y: 0, width: amount, height: self.frame.height))
        self.leftView = view
        self.leftViewMode = .always
    }
}

private extension UIView {
    func setShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = .init(width: 0, height: 5)
    }
}
