//
//  NoteTableCell.swift
//  NotesTestUnit
//
//  Created by Mac on 22.12.2022.
//

import UIKit

final class NoteTableCell: UITableViewCell {
    
    //MARK: - Public properties
    var note: Note? {
        didSet {
            cellView.setTitle(with: note?.noteTitle ?? "")
            detailedView.setDescription(with: note?.noteDesription ?? "")
            setNeedsLayout()
        }
    }
    
    //MARK: - Private properties
    private let container = UIStackView()
    private let cellView = NoteTableCellView()
    private let detailedView = NoteTableCellViewDetailed()
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    //MARK: - Private methods
    private func commonInit() {
        selectionStyle = .none
        detailedView.isHidden = true
        container.axis = .vertical
        
        contentView.addSubview(container)
        container.addArrangedSubview(cellView)
        container.addArrangedSubview(detailedView)
        
        container.translatesAutoresizingMaskIntoConstraints = false
        cellView.translatesAutoresizingMaskIntoConstraints = false
        detailedView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NoteTableCell {
    var isDetailViewHidden: Bool {
        return detailedView.isHidden
    }

    func showDetailView() {
        detailedView.isHidden = false
    }

    func hideDetailView() {
        detailedView.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if isDetailViewHidden, selected {
            showDetailView()
        } else {
            hideDetailView()
        }
    }
}
