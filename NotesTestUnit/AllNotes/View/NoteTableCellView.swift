//
//  NoteTableViewRow.swift
//  NotesTestUnit
//
//  Created by Mac on 21.12.2022.
//

import UIKit

final class NoteTableCellView: UIView {
    
    private enum Constraints {
        static let titleTopConstraint = CGFloat(10)
        static let titleLeadingConstraint = CGFloat(18)
        
    }
    
    //MARK: - Private properties
    private let noteTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(noteTitle)
        NSLayoutConstraint.activate([
            noteTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: Constraints.titleTopConstraint),
            noteTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constraints.titleLeadingConstraint),
            noteTitle.bottomAnchor.constraint(equalTo: bottomAnchor),
            noteTitle.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    //MARK: - Public methods
    func setTitle(with noteTitleText: String) {
        noteTitle.text = noteTitleText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class NoteTableCellViewDetailed: UIView {
    
    //MARK: - Private properties
    private let noteTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18, weight: .thin)
        return label
    }()
        
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private methods
    private func commonInit() {
        addSubview(noteTextLabel)
        NSLayoutConstraint.activate([
            noteTextLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            noteTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            noteTextLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            noteTextLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    //MARK: - Public methods
    func setDescription(with noteText: String) {
        noteTextLabel.text = noteText
    }
    
}
