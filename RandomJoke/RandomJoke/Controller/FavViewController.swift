//
//  FavViewController.swift
//  RandomJoke
//
//  Created by xindy.del.rosario on 11/25/22.
//

import Foundation
import UIKit


class FavViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()

    private var modals = [Jokes]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.rowHeight = 90
        getAllJokes()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modals.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let modal = modals[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for:  indexPath)
        cell.textLabel?.numberOfLines = 10
        cell.textLabel?.text = "\(modal.setup ?? "")\n\(modal.punchline ?? "")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let modal = modals[indexPath.row]
        let deleteRow = UIContextualAction(style: .normal, title: "Delete") { [weak self] ( _ , _ , completionHandler) in
        self?.delete(item: modal)
            
        }
        deleteRow.backgroundColor = UIColor.red
        let config = UISwipeActionsConfiguration(actions: [deleteRow])
        return config
    }

    func getAllJokes() {
        do {
            modals = try context.fetch(Jokes.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }

        } catch {
            print(error)
        }
    }
    func createJoke(setup: String?, punchline: String?) {
        let newJoke = Jokes(context: context)
        newJoke.punchline = punchline
        newJoke.setup = setup

        do {
            try context.save()
            getAllJokes()
        } catch {
            print(error)
        }
    }
    func delete(item: Jokes) {
        context.delete(item)

        do {
            try context.save()
            getAllJokes()
        } catch {
            print(error)
        }
    }

}
