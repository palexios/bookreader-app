import UIKit

// MARK: - AddingInputView
final class AddingInputView: UIView {
    // MARK: - GUI
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemGray6
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private lazy var coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = coverView.layer.cornerRadius
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var coverView: CoverView = {
        let view = CoverView()

        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 28
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var doneButton: UIButton = {
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
    
    
    lazy var deleteCoverButton: UIButton = {
        let button = UIButton()
        button.setTitle("удалить", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.appGray.withAlphaComponent(0.7), for: .normal)
        button.isHidden = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var nameTextField: AddingTextField = {
        AddingTextField(placeholder: "Название")
    }()
    
    lazy var authorTextField: AddingTextField = {
        AddingTextField(placeholder: "Автор")
    }()
    
    lazy var genreTextField: AddingTextField = {
        let textField = AddingTextField(placeholder: "Жанр")
        
        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 18, weight: .regular)
        let image = UIImage(systemName: "arrowtriangle.down.fill", withConfiguration: imageConfiguration)
        let button = UIButton(frame: .init(origin: .zero, size: image!.size))
        button.setImage(image, for: .normal)
        button.tintColor = .appGray
        
        let padding: CGFloat = 16
        let rightView = UIView(frame: .init(x: 0, y: 0, width: image!.size.width + padding, height: image!.size.height))
        rightView.addSubview(button)
        button.center = rightView.center

        textField.rightViewMode = .always
        textField.rightView = rightView
        
        return textField
    }()
    
    // MARK: - Methods
    func setCover(_ image: UIImage) {
        self.coverImageView.image = image
        self.coverView.button.isEnabled = false
        self.deleteCoverButton.isHidden = false
    }
    
    func removeCover() {
        self.coverImageView.image = .none
        self.coverView.button.isEnabled = true
        self.deleteCoverButton.isHidden = true
    }
    
    // MARK: - Private Methods
    func getTextField(withPlaceholder placeholder: String, tag: Int) -> UITextField {
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
    
    func configure() {
        self.backgroundColor = .white
    }
    
    func configureCoverViewLayout() {
        let topInset = UIScreen.main.bounds.height * 0.21
        self.scrollView.addSubview(coverView)
        NSLayoutConstraint.activate([
            coverView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.37),
            coverView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.25),
            coverView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            coverView.topAnchor.constraint(equalTo: self.topAnchor, constant: topInset)
        ])
    }
    

    func configureTextFieldsStackView() {
        self.scrollView.addSubview(stackView)
        
        let width = UIScreen.main.bounds.width * 0.75
        
        // constraints for stackView items
        for i in [nameTextField, authorTextField, genreTextField] {
            i.heightAnchor.constraint(equalToConstant: 40).isActive = true
            i.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        // constraints for stackView
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: deleteCoverButton.bottomAnchor, constant: 6),
            self.stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
        
        [nameTextField,authorTextField, genreTextField].forEach { [weak self] i in
            self?.stackView.addArrangedSubview(i)
        }
    }
    
    func configureDoneButtonLayout() {
        let height = UIScreen.main.bounds.height * 0.05
        let width = UIScreen.main.bounds.width * 0.65
        let bottomInset = UIScreen.main.bounds.height * 0.15
        
        self.scrollView.addSubview(doneButton)
        NSLayoutConstraint.activate([
            doneButton.heightAnchor.constraint(equalToConstant: height),
            doneButton.widthAnchor.constraint(equalToConstant: width),
            doneButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            doneButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: bottomInset),
            doneButton.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor)
        ])
    }
    
    func configureDeleteCoverButton() {
        self.scrollView.addSubview(deleteCoverButton)
        NSLayoutConstraint.activate([
            deleteCoverButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            deleteCoverButton.topAnchor.constraint(equalTo: coverView.bottomAnchor, constant: 6)
        ])
    }
    
    func configureScrollViewLayout() {
        self.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.keyboardLayoutGuide.topAnchor)
        ])
    }
    
    func configureCoverImageViewLayout() {
        self.coverView.addSubview(coverImageView)
        NSLayoutConstraint.activate([
            coverImageView.leadingAnchor.constraint(equalTo: coverView.leadingAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: coverView.trailingAnchor),
            coverImageView.topAnchor.constraint(equalTo: coverView.topAnchor),
            coverImageView.bottomAnchor.constraint(equalTo: coverView.bottomAnchor)
        ])
    }
}
