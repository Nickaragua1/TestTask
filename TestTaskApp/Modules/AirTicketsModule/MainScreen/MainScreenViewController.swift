//
//  ViewController.swift
//  TestTaskApp
//
//  Created by Никита Гладышев on 13.06.2024.
//

import UIKit

protocol MainScreenViewControllerProtocol: AnyObject {
    func updateView()
    func updateFromTextField(with data: String)
}

final class MainScreenViewController: UIViewController, MainScreenViewControllerProtocol {
    
    //MARK: Properties
    enum Constants {
        static var minimumLineSpacing: CGFloat = 16
        static let galleryItemWidth = (UIScreen.main.bounds.width - (minimumLineSpacing / 2.9)) / 2.9
    }
    
    //MARK: Private properties
    private let presenter: MainScreenPresenterProtocol

    private let textFieldView: UIView = {
        let view = UIView()
        view.backgroundColor = R.Color.textFieldViewColor
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowColor = R.Color.shadowColor.cgColor
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 0.25
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        return view
    }()
    
    private let mainTilte: UILabel = {
        let label = UILabel()
        label.font = UIFont(
            name: R.Font.SFProDisplaySemibold,
            size: 22
        )
        label.text = R.Title.mainModuleTitle
        label.textAlignment = .center
        label.textColor = R.Color.primaryTextColor
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let searchView: UIView = {
        let view = UIView()
        view.backgroundColor = R.Color.primaryViewColor
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let textFieldViewImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.Image.textFieldSearchImage
        imageView.tintColor = R.Color.unselectedBarItemColor
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = R.Color.unselectedBarItemColor.withAlphaComponent(0.63)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let topicalTilte: UILabel = {
        let label = UILabel()
        label.font = UIFont(
            name: R.Font.SFProDisplaySemibold,
            size: 22
        )
        label.text = R.Title.mainModuleTopicalTitle
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = Constants.minimumLineSpacing
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(
            MainScreenCell.self,
            forCellWithReuseIdentifier: MainScreenCell.reuseId
        )
        view.backgroundColor = .black
        view.contentInset = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0
        )
        view.showsHorizontalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    private lazy var fromTextField: CustomeTextField = {
        let textField = CustomeTextField(
            placeholder: "Откуда - Москва",
            insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        )
        textField.delegate = self
        textField.isUserInteractionEnabled = true
        textField.addGestureRecognizer(gesture)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var toTextField: CustomeTextField = {
        let textField = CustomeTextField(
            placeholder: "Куда - Турция",
            insets: UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 0)
        )
        textField.delegate = self
        textField.isUserInteractionEnabled = true
        textField.addGestureRecognizer(gesture)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var gesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer(
            target: self,
            action: #selector(textFieldViewDidTapped)
        )
        gesture.numberOfTapsRequired = 1
        return gesture
    }()
    
    //MARK: Initializer
    init(presenter: MainScreenPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupLayouts()
        addGestureRecognizer()
        presenter.getMainScreenData()
        presenter.loadData()
    }
    
    //MARK: Methods
    func showSearchView(with view: UIViewController) {
        let presentVC = view
        let navigationVC = UINavigationController(rootViewController: presentVC)
        let sheet = navigationVC.sheetPresentationController
        sheet?.detents = [.large()]
        navigationController?.present(navigationVC, animated: true)
    }
    
    func updateView() {
        collectionView.reloadData()
    }
    
    func updateFromTextField(with data: String) {
        fromTextField.text = data
    }
    
    //MARK: Private methods
    @objc private func textFieldViewDidTapped() {
        presenter.didTextFieldTapped()
        storeData()
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        fromTextField.resignFirstResponder()
    }
    
    private func addGestureRecognizer() {
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(self.handleTap(_:))
        )
        view.addGestureRecognizer(tap)
    }
    
    private func storeData() {
        presenter.storeData(with: fromTextField.text ?? "")
    }
    
    private func setupLayouts() {
        view.addSubview(mainTilte)
        view.addSubview(searchView)
        view.addSubview(topicalTilte)
        view.addSubview(collectionView)
        searchView.addSubview(textFieldView)
        textFieldView.addSubview(textFieldViewImage)
        textFieldView.addSubview(fromTextField)
        textFieldView.addSubview(toTextField)
        textFieldView.addSubview(separatorView)
        
        NSLayoutConstraint.activate([
            mainTilte.topAnchor.constraint(equalTo: view.topAnchor, constant: 58),
            mainTilte.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            searchView.topAnchor.constraint(equalTo: mainTilte.bottomAnchor, constant: 38),
            searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchView.heightAnchor.constraint(equalToConstant: 122),
            searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            textFieldView.topAnchor.constraint(equalTo: searchView.topAnchor, constant: 16),
            textFieldView.leadingAnchor.constraint(equalTo: searchView.leadingAnchor, constant: 16),
            textFieldView.trailingAnchor.constraint(equalTo: searchView.trailingAnchor, constant: -16),
            textFieldView.bottomAnchor.constraint(equalTo: searchView.bottomAnchor, constant: -16),
            
            textFieldViewImage.centerYAnchor.constraint(equalTo: textFieldView.centerYAnchor),
            textFieldViewImage.heightAnchor.constraint(equalToConstant: 24),
            textFieldViewImage.widthAnchor.constraint(equalToConstant: 24),
            textFieldViewImage.leadingAnchor.constraint(equalTo: textFieldView.leadingAnchor, constant: 8),
            
            fromTextField.topAnchor.constraint(equalTo: textFieldView.topAnchor, constant: 16),
            fromTextField.leadingAnchor.constraint(equalTo: textFieldViewImage.trailingAnchor, constant: 17),
            fromTextField.trailingAnchor.constraint(equalTo: textFieldView.trailingAnchor, constant: -17),
            
            separatorView.topAnchor.constraint(equalTo: fromTextField.bottomAnchor, constant: 8),
            separatorView.centerYAnchor.constraint(equalTo: textFieldViewImage.centerYAnchor),
            separatorView.leadingAnchor.constraint(equalTo: fromTextField.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: fromTextField.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            
            toTextField.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 8),
            toTextField.bottomAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: -16),
            toTextField.leadingAnchor.constraint(equalTo: textFieldViewImage.trailingAnchor, constant: 17),
            toTextField.trailingAnchor.constraint(equalTo: textFieldView.trailingAnchor, constant: -17),
            
            topicalTilte.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 32),
            topicalTilte.leadingAnchor.constraint(equalTo: searchView.leadingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: topicalTilte.bottomAnchor, constant: 26),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 213)
        ])
    }
}

//MARK: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension MainScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.mainScreenData?.offers.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainScreenCell.reuseId, for: indexPath) as? MainScreenCell else
        { return UICollectionViewCell() }
        guard let model = presenter.mainScreenData?.offers[indexPath.row],
              let image = presenter.mainScreenData?.images[indexPath.row] else
        { return UICollectionViewCell() }
        
        cell.configure(with: model, image: image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.galleryItemWidth, height: collectionView.frame.height)
    }
}

//MARK: UITextFieldDelegate
extension MainScreenViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var flag = false
        switch textField {
        case fromTextField:
            flag = fromTextField.setTextField(
               textField: fromTextField,
               validType: .enterCity,
               string: string,
               range: range
           )
        case toTextField:
            flag = toTextField.setTextField(
               textField: toTextField,
               validType: .enterCity,
               string: string,
               range: range
           )
        default:
            return true
        }
        return flag
    }
}
