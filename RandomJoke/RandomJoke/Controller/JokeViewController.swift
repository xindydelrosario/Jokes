//
//  ViewController.swift
//  RandomJoke
//
//  Created by xindy.del.rosario on 11/25/22.
//

import Foundation
import UIKit


class JokeViewController: UIViewController {
    
    private let VM = JokeListViewModel()
    private let VC = FavViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        view.addSubview(setuplabel)
        view.addSubview(punchlinelabel)
        view.addSubview(refreshButton)
        view.addSubview(heartButton)
        view.addSubview(nextPageButton)
        title = "Joke Screen"
        
        setConstraints()
        
        loadData()
        
        Task {
            await populateJokes()
        }
    }
    
    private lazy var setuplabel: UILabel = {
        let setup = UILabel(frame: .zero)
        setup.translatesAutoresizingMaskIntoConstraints = false
        setup.numberOfLines = 10
        setup.sizeToFit()
        return setup
    }()
    
    private lazy var punchlinelabel: UILabel = {
        let punchline = UILabel(frame: .zero)
        punchline.translatesAutoresizingMaskIntoConstraints = false
        punchline.numberOfLines = 10
        punchline.sizeToFit()
        return punchline
    }()
    
    private lazy var refreshButton: CustomButton = {
        let button = CustomButton()
        let image = UIImage(systemName: "arrow.clockwise")
      //  button.setImage(image, for: .normal)
        button.configure(with: IconTextButtonViewModel(image: image))
        button.addTarget(self, action: #selector(loadData), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var heartButton: CustomButton = {
        let button = CustomButton()
        let image = UIImage(systemName: "heart")
        //button.setImage(image, for: .normal)
        button.configure(with: IconTextButtonViewModel(image: image))
        button.addTarget(self, action: #selector(saveJoke), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    private lazy var nextPageButton: CustomButton = {
        let button = CustomButton()
        let image = UIImage(systemName: "rectangle.portrait.and.arrow.right")
        //button.setImage(image, for: .normal)
        button.configure(with:  IconTextButtonViewModel(image: image))
        button.addTarget(self, action: #selector(goToNextScreen), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func loadData() {
        Task {
            await populateJokes()
        }
    }
    
    @objc func saveJoke() {
        let setup = setuplabel.text
        let punchline = punchlinelabel.text
        VC.createJoke(setup: "\(setup ?? "")", punchline: "\(punchline ?? "")")
    }
    
    
    @objc func goToNextScreen() {
        let nextScreen = FavViewController()
        nextScreen.title = "Favorite Screen"
        navigationController?.pushViewController(nextScreen, animated: true)
    }
    
    private func populateJokes() async{
        await VM.populateJokes(url: API.Urls.allJokes)
        guard let joke = VM.jokes.randomElement() else { return }
        setuplabel.text = joke.setup
        punchlinelabel.text = joke.punchline
        setuplabel.sizeToFit()
        punchlinelabel.sizeToFit()
    }
    
    private func setConstraints() {
        setuplabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        setuplabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        setuplabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        punchlinelabel.topAnchor.constraint(equalTo: setuplabel.bottomAnchor, constant: 10).isActive = true
        punchlinelabel.leadingAnchor.constraint(equalTo: setuplabel.leadingAnchor).isActive = true
        
        refreshButton.topAnchor.constraint(equalTo: punchlinelabel.bottomAnchor, constant: 30).isActive = true
        refreshButton.leadingAnchor.constraint(equalTo: punchlinelabel.leadingAnchor).isActive = true
        
        heartButton.topAnchor.constraint(equalTo: punchlinelabel.bottomAnchor,constant: 30).isActive = true
        heartButton.leadingAnchor.constraint(equalTo: refreshButton.leadingAnchor, constant: 30).isActive = true
        
        nextPageButton.topAnchor.constraint(equalTo: punchlinelabel.bottomAnchor, constant: 30).isActive = true
        nextPageButton.leadingAnchor.constraint(equalTo: heartButton.leadingAnchor, constant: 30).isActive = true
        
        
    }
    
    
    
    
}

