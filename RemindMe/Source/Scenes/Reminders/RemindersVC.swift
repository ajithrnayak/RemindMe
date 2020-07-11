//
//  RemindersVC.swift
//  RemindMe
//
//  Created by Ajith R Nayak on 08/07/20.
//  Copyright © 2020 ajithrnayak. All rights reserved.
//

import UIKit

class RemindersVC: UIViewController {
    
    private let remindersList = RemindersListVC.newInstance()
    
    private let containerView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    private let createReminderButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = AppTheme.pinkish.color
        $0.setTitleColor(AppTheme.black.color, for: .normal)
        $0.setTitle("+", for: .normal)
        $0.titleLabel?.font = AppFonts.NunitoFamily.bold.fontWithSize(42.0)
        $0.titleLabel?.textAlignment    = .center
        $0.contentVerticalAlignment     = .center
        $0.contentHorizontalAlignment   = .center
        $0.addTarget(self, action: #selector(createReminderButtonAction), for: .touchUpInside)
        $0.fullyRounded(diameter: 60.0)
        return $0
    }(UIButton(type: .custom))
    
    lazy var searchController: UISearchController = ({
        let controller = UISearchController(searchResultsController: nil)
        controller.hidesNavigationBarDuringPresentation = true
        controller.searchResultsUpdater = self
        controller.searchBar.searchBarStyle = .minimal
        controller.obscuresBackgroundDuringPresentation = false
        controller.definesPresentationContext = true
        return controller
    })()
    
    var photoPicker: UIImagePickerController?
    
    // MARK: - Properties
    private var router: RemindersRouter!
    
    // MARK: - Initializers
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configureScene()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureScene() {
       // self.router = RemindersRouter(viewController: self)
    }
    
    // MARK: - Actions
    @objc
    func createReminderButtonAction() {
        let reminderFormVC      = ReminderFormVC.newInstance()
        reminderFormVC.image    = nil
        reminderFormVC.delegate = self
        self.navigationController?.pushViewController(reminderFormVC,
                                                       animated: true)
        //showPhotoPickerOptions()
    }
}

// MARK: - View Life Cycle

extension RemindersVC {
    
    override func loadView() {
        super.loadView()
        setupRemindersList()
        setupCreateReminderButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "RemindMe"
        view.backgroundColor = AppTheme.background.color
        configureSearchbar()
        NotificationsWorker.requestUserPermision { (_) in }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        remindersList.refreshReminders()
    }
}

// MARK: - Initial Configuration

extension RemindersVC {
    func configureSearchbar() {
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    private func setupRemindersList() {
        view.addSubview(containerView)
        let constraints = [containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                           containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                           containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                           containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)]
        constraints.forEach { $0.isActive = true }
        
        addChild(remindersList)
        remindersList.view.frame = containerView.frame
        containerView.addSubview(remindersList.view)
        remindersList.didMove(toParent: self)
        remindersList.view.addConstraintsToMatch(superView: containerView)
    }
    
    private func setupCreateReminderButton() {
        view.addSubview(createReminderButton)
        let constraints = [createReminderButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                                        constant: -8.0),
                           createReminderButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                                          constant: -16.0),
                           createReminderButton.heightAnchor.constraint(equalToConstant: 60.0),
                           createReminderButton.widthAnchor.constraint(equalToConstant: 60.0)]
        constraints.forEach { $0.isActive = true }
    }
    
    // MARK: - Image Picker
    private func showPhotoPickerOptions() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera)  else {
            self.showPhotoPicker(for: .photoLibrary)
            return
        }
        
        let photoSourcePicker = UIAlertController()
        let takePhoto = UIAlertAction(title: "Take Photo", style: .default) { [unowned self] _ in
            self.showPhotoPicker(for: .camera)
        }
        let choosePhoto = UIAlertAction(title: "Choose Photo", style: .default) { [unowned self] _ in
            self.showPhotoPicker(for: .photoLibrary)
        }
        
        photoSourcePicker.addAction(takePhoto)
        photoSourcePicker.addAction(choosePhoto)
        photoSourcePicker.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(photoSourcePicker, animated: true)
    }
    
    private func showPhotoPicker(for sourceType: UIImagePickerController.SourceType) {
        let photoPicker         = UIImagePickerController()
        photoPicker.delegate    = self
        photoPicker.sourceType  = sourceType
        self.photoPicker        = photoPicker
        
        self.present(photoPicker, animated: true, completion: nil)
    }
    
    private func resetPhotoPicker() {
        self.photoPicker?.dismiss(animated: true, completion: { [unowned self] in
            self.photoPicker = nil
        })
    }
    
    private func showNewReminderForm(using photo: UIImage?) {
        router.showNewReminderForm(using: photo)
    }
}

// MARK: - Handling Image Picker Selection
extension RemindersVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true) { [unowned self] in
            self.photoPicker = nil
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        picker.dismiss(animated: true) { [unowned self] in
            self.photoPicker = nil
            self.showNewReminderForm(using: image)
        }
    }
}

// MARK: - ReminderFormDelegate

extension RemindersVC: ReminderFormDelegate {
    func reminderFormDidRequestCancel() {
        router.popToRootViewController()
    }
    
    func reminderFormDidSaveReminder() {
        router.popToRootViewController()
    }
}

// MARK: - UISearchResultsUpdating

extension RemindersVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        remindersList.searchReminder(for: searchController.searchBar.text)
    }
}

// MARK: - Factory Initializer
extension RemindersVC {
    class func newInstance() -> RemindersVC {
        let remindersVC = RemindersVC()
        return remindersVC
    }
}
