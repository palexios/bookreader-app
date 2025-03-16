import UIKit

// MARK: - LibraryInputView
final class LibraryInputView: UIView {
    // MARK: - Properties
    let trailingInset: CGFloat = -20
    private let coverImageViewWidthPercent = 0.381679
    private let coverImageViewHeightPercent = 0.249433
    
    // MARK: - GUI
    private lazy var sortButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 28, weight: .regular)
        let image = UIImage(systemName: "line.3.horizontal.decrease.circle", withConfiguration: imageConfiguration)
        
        button.setImage(image, for: .normal)
        button.tintColor = .appGray
        return button
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Поиск"
        searchBar.showsBookmarkButton = true
        searchBar.setImage(UIImage(systemName: "mic.fill"), for: .bookmark, state: [])
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        
        // constraints for searchBar
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        return searchBar
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width * self.coverImageViewWidthPercent
        let height = UIScreen.main.bounds.height * self.coverImageViewHeightPercent
        layout.itemSize = CGSize.init(width: width, height: height)
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: "BookCollectionViewCell")
        
        return collectionView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func setupView() {
        self.backgroundColor = .white
    }
    
    func setupSearchBarLayout() {
        self.addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 11),
            searchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -63),
            searchBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    func setupSortButtonLayout() {
        self.addSubview(sortButton)
        NSLayoutConstraint.activate([
            sortButton.topAnchor.constraint(equalTo: self.searchBar.searchTextField.topAnchor),
            sortButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: trailingInset)
        ])
    }
    
    func setupCollectionViewLayout() {
        self.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo:self.safeAreaLayoutGuide.leadingAnchor, constant: 19),
            collectionView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor, constant: 26),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
