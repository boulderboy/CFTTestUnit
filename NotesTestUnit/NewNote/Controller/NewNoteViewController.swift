//
//  ViewController.swift
//  NotesTestUnit
//
//  Created by Mac on 22.12.2022.
//

import UIKit

class NewNoteViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: - Constants
    private enum Constants {
        static let mainTextFontSize = CGFloat(15)
        static let borderWidth = CGFloat(0.3)
        static let borderRadius = CGFloat(10)
        static let noteTitleLabelTopConstraint = CGFloat(30)
        static let noteTitleLeadingConstraint = CGFloat(15)
        static let noteTitleTrailingConstraint = CGFloat(-15)
        static let noteTitleTextFieldTopConstraint = CGFloat(10)
        static let noteTitleTextFieldTrailingConstraint = CGFloat(-15)
        static let noteTitleTextFieldHeight = CGFloat(30)
        static let noteDescriprionLabelTopConstraint = CGFloat(20)
        static let labelsTopConstraint = CGFloat(10)
        static let textFieldHeight = CGFloat(200)
        
    }
    
    //MARK: - Private properties
    
    private var navigtionTitle: String = "New note"
    
    private let realm = StorageService()

    private let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Bold", for: .normal)
        return button
    }()

    private let noteTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Enter note title"
        return label
    }()
    
    private let noteTitleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: Constants.mainTextFontSize, weight: .bold)
        textField.addTarget(self, action: #selector(titleTextFieldHandler(_:)), for: .allEditingEvents)
        return textField
    }()
    
    private let noteTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Enter note text"
        return label
    }()
    
    private let textField: UITextView = {
        let textView = UITextView()
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = Constants.borderWidth
        textView.layer.cornerRadius = Constants.borderRadius
        textView.allowsEditingTextAttributes = true
        textView.font = UIFont.systemFont(ofSize: Constants.mainTextFontSize)
        return textView
    }()
    
    private let imageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    //MARK: - ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveNote))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancelButtonHandler))
        title = navigtionTitle
        setUpSubviews()
    }
    
    //MARK: - Preivate methods
    @objc
    private func saveNote() {
        let noteTitle = noteTitleTextField.text ?? "no title"
        let noteText = textField.text ?? ""
        let note = Note(id: nil, title: noteTitle == "" ? "Empty note" : noteTitle, description: noteText)
        realm.save(note: note)
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc
    private func cancelButtonHandler() {
        navigationController?.popToRootViewController(animated: true)
    }

    @objc
    private func titleTextFieldHandler(_ textField: UITextField) {
        self.title = textField.text ?? "New note"
    }
    
    private func setUpSubviews() {
        view.addSubview(noteTitleLabel)
        view.addSubview(noteTitleTextField)
        view.addSubview(noteTextLabel)
        view.addSubview(textField)
        
        NSLayoutConstraint.activate([
            noteTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.noteTitleLabelTopConstraint),
            noteTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.noteTitleLeadingConstraint),
            noteTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.noteTitleTrailingConstraint),
        
            noteTitleTextField.topAnchor.constraint(equalTo: noteTitleLabel.bottomAnchor, constant: Constants.noteTitleTextFieldTopConstraint),
            noteTitleTextField.leadingAnchor.constraint(equalTo: noteTitleLabel.leadingAnchor),
            noteTitleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.noteTitleTextFieldTrailingConstraint),
            noteTitleTextField.heightAnchor.constraint(equalToConstant: Constants.noteTitleTextFieldHeight),
        
            noteTextLabel.topAnchor.constraint(equalTo: noteTitleTextField.bottomAnchor, constant: Constants.noteDescriprionLabelTopConstraint),
            noteTextLabel.leadingAnchor.constraint(equalTo: noteTitleLabel.leadingAnchor),
            noteTextLabel.trailingAnchor.constraint(equalTo: noteTitleLabel.trailingAnchor),
            
            textField.topAnchor.constraint(equalTo: noteTextLabel.bottomAnchor, constant: Constants.labelsTopConstraint),
            textField.trailingAnchor.constraint(equalTo: noteTitleTextField.trailingAnchor),
            textField.leadingAnchor.constraint(equalTo: noteTitleTextField.leadingAnchor),
            textField.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight),
        
        ])
    }
}
