//
//  ViewController.swift
//  NotesTestUnit
//
//  Created by Mac on 21.12.2022.
//

import UIKit
import RealmSwift



final class NoteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private enum CellsIdentifiers {
        static let noteCell = "noteCellId"
    }

    private let storageService: StorageService
    private let navigator: Navigation
    
    init(storageService: StorageService, navigator: Navigation) {
        self.storageService = storageService
        self.navigator = navigator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private properties
    private let notesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var allNotesArr: [Note] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let allNotesArr = storageService.getAllNotes()
        if self.allNotesArr != allNotesArr {
            self.allNotesArr = allNotesArr
            notesTableView.reloadData()
        }
        if allNotesArr.isEmpty {
            self.allNotesArr.append(Note.greetingsNote)
        }
    }

    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigator.navigationController = navigationController
        title = "Notes"
        allNotesArr = storageService.getAllNotes()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: self, action: #selector(newNote))
        
        notesTableView.delegate = self
        notesTableView.dataSource = self
        notesTableView.register(NoteTableCell.self, forCellReuseIdentifier: CellsIdentifiers.noteCell)
        
        setupView()

    }

    //MARK: - UITableViewDataSource, UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allNotesArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellsIdentifiers.noteCell) as? NoteTableCell else {
            return UITableViewCell() }
        cell.note = allNotesArr[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3) {
            tableView.performBatchUpdates(nil)
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = UIContextualAction(style: .normal, title: "Edit") { _, _, _ in
            
            self.navigator.openEditingViewController(note: (self.allNotesArr[indexPath.row]), storageService: self.storageService) { note in
                self.allNotesArr[indexPath.row] = note
                tableView.reloadData()
            }
        }
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            let note = self.allNotesArr[indexPath.row] 
            self.storageService.delete(object: note)
            self.allNotesArr.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        let swipeConfig = UISwipeActionsConfiguration(actions: [delete, edit])
        return swipeConfig
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? NoteTableCell {
            cell.hideDetailView()
        }
    }
    
    //MARK: - Private methods
    
    @objc
    private func newNote() {
        navigator.openNewNoteController()
    }

    private func setupView() {
        view.addSubview(notesTableView)
        NSLayoutConstraint.activate([
            notesTableView.topAnchor.constraint(equalTo: view.topAnchor),
            notesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            notesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            notesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

