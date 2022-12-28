//
//  EdittingView.swift
//  NotesTestUnit
//
//  Created by Mac on 24.12.2022.
//

import UIKit

class EditingViewController: UIViewController {
    
    //MARK: - Constraints
    private enum Constraints {
        static let noteTitleLabelTopConstraint = CGFloat(30)
        static let noteTitleLabelLeadingConstraint = CGFloat(15)
        static let noteTitleLabelTrailingConstraint = CGFloat(-15)
        static let textFieldsTopConstraint = CGFloat(10)
        static let noteTitleTextFieldHeight = CGFloat(30)
        static let noteTextLabelTopConstraint = CGFloat(20)
        static let textFieldHeight = CGFloat(200)
        
    }
    
    //MARK: - Private properties
    private var note: Note
    private var onDismiss: ((Note) -> Void)?
    
    private let storageService: StorageService
    
    private let noteTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title"
        return label
    }()
    
    private let noteTitleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        textField.addTarget(self, action: #selector(titleTextFieldHandler(_:)), for: .allEditingEvents)
        return textField
    }()
    
    private let noteTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Description"
        return label
    }()
    
    private let textField: UITextView = {
        let textView = UITextView()
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 0.3
        textView.layer.cornerRadius = 10
        textView.allowsEditingTextAttributes = true
        textView.font = UIFont.systemFont(ofSize: 15)
        return textView
    }()
    
    //MARK: - init
    init(note: Note, storageService: StorageService, onDismiss: ((Note) -> ())?) {
        self.note = note
        self.storageService = storageService
        self.onDismiss = onDismiss
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveEdittedNote))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancelButtonHandler))
        title = note.noteTitle
        textField.text = note.noteDesription
        noteTitleTextField.text = note.noteTitle
        setUpSubviews()
    }
    
    //MARK: - Private methods
    @objc
    private func saveEdittedNote() {
        print(note)
        let noteTitle = noteTitleTextField.text ?? ""
        let noteDescription = textField.text ?? ""
        note.noteTitle = noteTitle
        note.noteDesription = noteDescription
        storageService.update(object: note, title: noteTitle, description: noteDescription)
        onDismiss!(note)
        dismiss(animated: true)
    }
    
    @objc
    private func cancelButtonHandler() {
        dismiss(animated: true)
    }

    @objc
    private func titleTextFieldHandler(_ textField: UITextField) {
        self.title = textField.text ?? ""
    }
    
    private func setUpSubviews() {
        
        view.addSubview(noteTitleLabel)
        view.addSubview(noteTitleTextField)
        view.addSubview(noteTextLabel)
        view.addSubview(textField)
        
        NSLayoutConstraint.activate([
            noteTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constraints.noteTitleLabelTopConstraint),
            noteTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constraints.noteTitleLabelLeadingConstraint),
            noteTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constraints.noteTitleLabelTrailingConstraint),
        
            noteTitleTextField.topAnchor.constraint(equalTo: noteTitleLabel.bottomAnchor, constant: Constraints.textFieldsTopConstraint),
            noteTitleTextField.leadingAnchor.constraint(equalTo: noteTitleLabel.leadingAnchor),
            noteTitleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constraints.noteTitleLabelTrailingConstraint),
            noteTitleTextField.heightAnchor.constraint(equalToConstant: Constraints.noteTitleTextFieldHeight),
        
            noteTextLabel.topAnchor.constraint(equalTo: noteTitleTextField.bottomAnchor, constant: Constraints.noteTextLabelTopConstraint),
            noteTextLabel.leadingAnchor.constraint(equalTo: noteTitleLabel.leadingAnchor),
            noteTextLabel.trailingAnchor.constraint(equalTo: noteTitleLabel.trailingAnchor),
            
            textField.topAnchor.constraint(equalTo: noteTextLabel.bottomAnchor, constant: Constraints.textFieldsTopConstraint),
            textField.trailingAnchor.constraint(equalTo: noteTitleTextField.trailingAnchor),
            textField.leadingAnchor.constraint(equalTo: noteTitleTextField.leadingAnchor),
            textField.heightAnchor.constraint(equalToConstant: Constraints.textFieldHeight)
        ])
    }
    
 
}
