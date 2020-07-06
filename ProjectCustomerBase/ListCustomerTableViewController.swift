//
//  ListCustomerTableViewController.swift
//  ProjectCustomerBase
//
//  Created by Rafaela Galdino on 03/07/20.
//  Copyright © 2020 Rafaela Galdino. All rights reserved.
//

import UIKit
import CoreData

class ListCustomerTableViewController: UIViewController {
    var resultsManager: NSFetchedResultsController<Client>?
    let tableView = UITableView(frame: .zero, style: .plain)

    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Clientes".uppercased()
        addBarButtonItem()
        addTableView()
        requestClient()
     }

    func addBarButtonItem() {
        let addRightButton = UIBarButtonItem(barButtonSystemItem: .add,
                                             target: self,
                                             action: #selector(actionAdd(_:)))
        navigationItem.rightBarButtonItem = addRightButton
    }
    
    @objc func actionBack(_ sender: AnyObject) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func actionAdd(_ sender: AnyObject) {
        navigationController?.pushViewController(InsertCustomerViewController(), animated: true)
    }
    
    private func addTableView() {
        tableView.register(ListCustomerCell.self, forCellReuseIdentifier: ListCustomerCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .singleLine
        
        view.addSubview(tableView)

        tableView.anchorFillSuperview()
    }
    
    func requestClient() {
        let searchClient: NSFetchRequest<Client> = Client.fetchRequest()
        let sortByName = NSSortDescriptor(key: "clientName", ascending: true)
        searchClient.sortDescriptors = [sortByName]
        
        resultsManager = NSFetchedResultsController(fetchRequest: searchClient, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        resultsManager?.delegate = self
        do {
            try resultsManager?.performFetch()
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension ListCustomerTableViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let customers = resultsManager?.fetchedObjects?.count else { return 0 }
        return customers
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListCustomerCell.reuseIdentifier, for: indexPath) as? ListCustomerCell, let client = resultsManager?.fetchedObjects?[indexPath.row] else { return UITableViewCell() }
        guard let name = client.clientName, let age = client.clientAge else { return UITableViewCell() }
        cell.clientName.text =  name + " - " + age
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedCustomer =  resultsManager?.fetchedObjects?[indexPath.row] else { return }
        let insertCustomer = InsertCustomerViewController()
        insertCustomer.client = selectedCustomer
        navigationController?.pushViewController(insertCustomer, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let selectedCustomer = resultsManager?.fetchedObjects?[indexPath.row] else { return }
            context.delete(selectedCustomer)
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

extension ListCustomerTableViewController: NSFetchedResultsControllerDelegate {
    // MARK: - FetchedResultsControllerDelegate
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .fade)
            break
        default:
            tableView.reloadData()
        }
    }
}
