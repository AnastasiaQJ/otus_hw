//
//  UserDetailsViewController.swift
//  NavigationControllerHW
//
//  Created by Anastasiya Orlova on 07.06.2024.
//

import UIKit

class UserDetailsViewController: UIViewController {
    
    enum Section {
        case main
    }

  var userInfo = UserInfo(name: nil, fullName: nil, position: nil) {
        didSet {
            fillUserData()
        }
    }
    
    var needFullName = true {
        didSet {
            fillUserData()
        }
    }
        
    let personView = UIView()
    let iconView = UIImageView()
    let image = UIImage(systemName: "person.crop.square")
    let userNameLabel = UILabel()
    let userPositionLabel = UILabel()
    let moreInfoButton = UIButton()
    let copyInfoButton = UIButton()
    
    func setupButton(_ button: UIButton, title: String?, action: Selector, type: UIButton.ButtonType) {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.titleLabel?.numberOfLines = 1
        button.titleLabel?.lineBreakMode = .byTruncatingTail
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.5
        button.addTarget(self.target, action: action, for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        
        setupButton(moreInfoButton, title: nil, action: #selector(didTapMoreInfoButton), type: .system)
        self.view.addSubview(moreInfoButton)
        
        setupButton(copyInfoButton, title: "Скопировать имя", action: #selector(didTapCopyButton), type: .system)
        self.view.addSubview(copyInfoButton)

        setupPersonView()
        setupPersonImageView()
        setupUserNameLabel()
        setupUserPositionLabel()
        fillUserData()
        
        NSLayoutConstraint.activate([
            moreInfoButton.topAnchor.constraint(equalTo: personView.bottomAnchor, constant: 16),
            moreInfoButton.leftAnchor.constraint(equalTo: personView.leftAnchor),
            copyInfoButton.topAnchor.constraint(equalTo: moreInfoButton.bottomAnchor, constant: 16),
            copyInfoButton.leftAnchor.constraint(equalTo: personView.leftAnchor)
        ])
    }
    
    func setupPersonView() {
        personView.translatesAutoresizingMaskIntoConstraints = false
        personView.backgroundColor = .systemMint
        personView.layer.cornerRadius = 8
        view.addSubview(personView)
        
        NSLayoutConstraint.activate([
            personView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            personView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            personView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            personView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -54)
        ])
        
    }
    
    func setupPersonImageView() {
        iconView.image = image
        iconView.translatesAutoresizingMaskIntoConstraints = false
        personView.addSubview(iconView)
        
        NSLayoutConstraint.activate([
            iconView.topAnchor.constraint(equalTo: personView.topAnchor, constant: 54),
            iconView.leadingAnchor.constraint(equalTo: personView.leadingAnchor, constant: 16),
            iconView.trailingAnchor.constraint(equalTo: personView.trailingAnchor, constant: -16),
            iconView.bottomAnchor.constraint(equalTo: personView.bottomAnchor, constant: -54)
        ])
    }
    
    func setupUserNameLabel() {
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.numberOfLines = 2
        userNameLabel.lineBreakMode = .byTruncatingTail
        view.addSubview(userNameLabel)
        
        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: personView.topAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: personView.trailingAnchor, constant: 16),
            userNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func setupUserPositionLabel() {
        userPositionLabel.translatesAutoresizingMaskIntoConstraints = false
        userPositionLabel.numberOfLines = 2
        userNameLabel.lineBreakMode = .byTruncatingTail
        view.addSubview(userPositionLabel)
        
        NSLayoutConstraint.activate([
            userPositionLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 16),
            userPositionLabel.leadingAnchor.constraint(equalTo: personView.trailingAnchor, constant: 16),
            userPositionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    @objc func didTapMoreInfoButton() {
        needFullName.toggle()
    }
    
    @objc func didTapCopyButton() -> String {
        let copyString = userNameLabel.text ?? "undefined"
        UIPasteboard.general.string = copyString
        print(copyString)
        return copyString
    }
    
    private func fillUserData() {
        userNameLabel.text = needFullName ? userInfo.fullName : userInfo.name
        UIView.performWithoutAnimation {
            moreInfoButton.setTitle(needFullName ? "Показать только имя" : "Показать имя полностью", for: .normal)
            moreInfoButton.layoutIfNeeded()
        }
        userPositionLabel.text = userInfo.position
    }
}
