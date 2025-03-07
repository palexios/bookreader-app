import UIKit

// MARK: - LibraryViewController
final class LibraryViewController: UIViewController, UISearchBarDelegate {
    // MARK: - Properties
    var viewModel: LibraryViewModel
    
    
    
    // MARK: - Input view
    override func loadView() {
        self.view = LibraryInputView()
    }
    
    func view() -> LibraryInputView {
        return self.view as! LibraryInputView
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationItem()
        
        self.view().collectionView.dataSource = self
        self.view().collectionView.delegate = self
        
        self.view().setupView()
        self.view().setupSearchBarLayout()
        self.view().setupSortButtonLayout()
        self.view().setupCollectionViewLayout()
    }
    
    override func viewDidLayoutSubviews() {
        print(self.view.safeAreaInsets.top)
    }
    
    // MARK: - Init
    init(viewModel: LibraryViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setupNavigationItem() {
        self.navigationItem.title = "Моя библиотека"
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: - UICollectionViewDataSource
extension LibraryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.viewModel.mockBooks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCollectionViewCell", for: indexPath) as? BookCollectionViewCell else { return UICollectionViewCell()}
        let cover = self.viewModel.mockBooks[indexPath.row].cover ?? UIImage.add.jpegData(compressionQuality: 1.0)!
        cell.setupUI(cover: cover, status: self.viewModel.mockBooks[indexPath.row].status)
        return cell
    }
    
    
}


// MARK: - UICollectionViewDelegate
extension LibraryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? BookCollectionViewCell {
            if self.viewModel.selectedCell != cell {
                cell.startActionMenu()
                self.viewModel.selectedCell = cell
            } else {
                cell.endActionMenu()
                self.viewModel.selectedCell = nil
            }
        }
    }
}
