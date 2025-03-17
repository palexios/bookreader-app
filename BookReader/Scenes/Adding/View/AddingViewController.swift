import UIKit
import MobileCoreServices

// MARK: - AddingViewController
final class AddingViewController: UIViewController {
    // MARK: - Properties
    private let viewModel: AddingViewModel
    private var contentView: AddingInputView {
        return view as! AddingInputView
    }
    
    // MARK: - Init
    init(viewModel: AddingViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func loadView() {
        self.view = AddingInputView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationItem()
        
        self.contentView.configure()
        self.contentView.configureScrollViewLayout()
        self.contentView.configureCoverViewLayout()
        
        self.contentView.coverView.configure()
        self.contentView.coverView.configureButtonLayout()
        self.contentView.coverView.configureTitleLayout()
        
        self.contentView.configureCoverImageViewLayout()
        self.contentView.configureDeleteCoverButton()
        self.contentView.configureTextFieldsStackView()
        self.contentView.configureDoneButtonLayout()
        
        self.contentView.coverView.button.addTarget(self, action: #selector(coverViewButtonAction), for: .touchUpInside)
        self.contentView.deleteCoverButton.addTarget(self, action: #selector(deleteCoverButtonAction), for: .touchUpInside)
        
        setNotificationsToTextFields()
        setGestureRecognizerToHideKeyboard()
        setPickerViewToGenreTextField()
        setDocumentPickerViewToDoneButton()
    }
    
    // MARK: - Private Methods
    private func configureNavigationItem() {
        self.navigationItem.title = "Новая книга"
        let backBarButton = UIBarButtonItem(title: "Назад", style: .done, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backBarButton
    }
    
    private func setNotificationsToTextFields() {
        guard let textFields = self.contentView.stackView.arrangedSubviews as? [UITextField] else { return }
        textFields.forEach { i in
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowAction), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideAction), name: UIResponder.keyboardWillHideNotification, object: nil)
        }
    }
    
    private func setGestureRecognizerToHideKeyboard() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(keyboardWillHideAction))
        self.contentView.addGestureRecognizer(gestureRecognizer)
    }
    
    private func setPickerViewToGenreTextField() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(pickerViewDoneButtonAction))
        doneButton.tintColor = .appGray
        toolBar.setItems([doneButton], animated: true)
        
        self.contentView.genreTextField.inputView = pickerView
        self.contentView.genreTextField.inputAccessoryView = toolBar
    }
    
    private func setDocumentPickerViewToDoneButton() {
        self.contentView.doneButton.addTarget(self, action: #selector(documentPickerViewAddButtonAction), for: .touchUpInside)
    }
    
    // MARK: - OBJC Private Methods
    @objc private func coverViewButtonAction() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        self.present(imagePicker, animated: true)
    }
    
    @objc private func deleteCoverButtonAction() {
        self.contentView.removeCover()
    }
    
    @objc private func keyboardWillShowAction(_ sender: NSNotification) {
        UIView.animate(withDuration: 0.2, animations: {
            self.contentView.frame.origin.y = -self.contentView.nameTextField.bounds.height * 3.5
        })
    }
    
    @objc private func keyboardWillHideAction() {
        UIView.animate(withDuration: 0.2, animations: {
            self.contentView.frame.origin.y = 0
        })
        self.contentView.endEditing(true)
    }
    
    @objc private func pickerViewDoneButtonAction() {
        self.contentView.endEditing(true)
    }
    
    @objc private func documentPickerViewAddButtonAction() {
        let documentPicker = UIDocumentPickerViewController(documentTypes: [String(kUTTypeData)], in: .open)
        self.present(documentPicker, animated: true)
    }
}

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension AddingViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        self.contentView.setCover(image)
        
        self.dismiss(animated: true)
    }
}

// MARK: - UIPickerViewDelegate
extension AddingViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.contentView.genreTextField.text = self.viewModel.genres[row].rawValue
    }
}

// MARK: - UIPickerViewDataSource
extension AddingViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        self.viewModel.genres.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.viewModel.genres[row].rawValue
    }
    
}
