//
//  MainNotesTableView.swift
//  Notes
//
//  Created by Marcos Rollón Rivas on 16/11/2019.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import UIKit

protocol NotesTableViewDelegate : AnyObject {
    func didSelectNote(note : Note)
    func didTapCreateNote()
    func didSwipeNote( at indexPath : IndexPath)
}

class NotesTableView : UIViewController{
    
    // MARK: - Views
    private var headerView : NotesTableHeader!
    private var tableView : UITableView!
    
    // MARK: - Parameters
    private var headerHeightConstraint : NSLayoutConstraint!
    private var headerTitle : String
    private var backgroundImage : UIImage
    private var maxHeight : CGFloat
    private var minHeight : CGFloat
    private var notes : [Note] = []
    
    // MARK: - Public API
    
    
    public weak var delegate : NotesTableViewDelegate? = nil
    
    public func setNotes(_ notes : [Note]){
        self.notes = notes
        tableView.reloadData()
    }
    
    public func deleteNotes(at indexPath : IndexPath){
        self.notes.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    init(headerTitle : String, backgroundImage : UIImage, maxHeaderHeight : CGFloat, minHeaderHeight : CGFloat){
        self.headerTitle = headerTitle
        self.backgroundImage = backgroundImage
        self.maxHeight = maxHeaderHeight
        self.minHeight = minHeaderHeight
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("[NotesTableView] Deinit")
    }
    
    // MARK: - Helpers
    private func configureViews(){
        // Setup
        setupTableView()
        headerView = NotesTableHeader(title: self.headerTitle, backgroundImage: .chillNatureWallpaper)
        headerView.addButtonAction = {
            [weak self] in
            self?.delegate?.didTapCreateNote()
        }
        // Layout
        headerView.pinToTopAndSides(of: self.view, sidesPadding: 0, verticalPadding: 0)
        headerHeightConstraint = headerView.heightAnchor.constraint(equalToConstant: maxHeight)
        headerHeightConstraint.isActive = true
        
        self.view.addSubview(tableView)
        tableView.anchor(top: headerView.bottomAnchor, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    private func setupTableView(){
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 120
        tableView.allowsSelection = true
        tableView.backgroundColor   = .clear
        tableView.separatorStyle    = .none
        tableView.register(NoteCell.self, forCellReuseIdentifier: NoteCell.reuseIdentifier)
    }
    
    private func animateHeader() {
        self.headerHeightConstraint.constant = maxHeight
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    private func deleteAction(at indexPath : IndexPath) -> UIContextualAction{
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            self.delegate?.didSwipeNote(at: indexPath)
            completion(true)
        }
        action.image = .trashIcon
        action.backgroundColor = .googleRed()
        return action
    }
}

// MARK: - Table View Delegate
extension NotesTableView : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if notes.count == 0 {
            tableView.setEmptyView(message: "You don't have any notes")
        }else {
            tableView.restore()
        }
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let note = notes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: NoteCell.reuseIdentifier, for: indexPath) as! NoteCell
        cell.configure(note)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = notes[indexPath.row]
        delegate?.didSelectNote(note: note)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction( at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

// MARK: - Scroll View Delegate
extension NotesTableView : UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            self.headerHeightConstraint.constant += abs(scrollView.contentOffset.y)
            headerView.incrementColorAlpha(self.headerHeightConstraint.constant)
        } else if scrollView.contentOffset.y > 0 && self.headerHeightConstraint.constant >= 65 {
            self.headerHeightConstraint.constant -= scrollView.contentOffset.y/100
            headerView.decrementColorAlpha(scrollView.contentOffset.y)
            
            if self.headerHeightConstraint.constant < minHeight {
                self.headerHeightConstraint.constant = minHeight
            }
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if self.headerHeightConstraint.constant > maxHeight {
            animateHeader()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if self.headerHeightConstraint.constant > maxHeight {
            animateHeader()
        }
    }
}
