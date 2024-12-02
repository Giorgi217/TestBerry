//
//  AddQuestion.swift
//  StayConnected
//
//  Created by Giorgi Amiranashvili on 01.12.24.
//

import UIKit

class AddQuestion: UIViewController {
    
    let viewModel = HomePageViewModel()
    var selectedTags: [String] = []
    
    let sunbejctView: UIView = {
        let view = UIView()
        return view
    }()
    
    let subjectTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .left
        return textField
    }()
    
    let subjectLabel: UILabel = {
        let label = UILabel()
        label.text = "Subject:"
        label.textColor = .gray
        return label
    }()
    
    let tagView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        return view
    }()
    
    let tagLabel: UILabel = {
        let label = UILabel()
        label.text = "Tag:"
        label.textColor = .gray
        return label
    }()
    
    let tagContainer: UIView = {
        let view = UIView()
        view.layer.borderWidth = 0 // Matches text field style
        view.backgroundColor = .clear
        return view
    }()
    
    let buttonContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    let questionView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        return view
    }()
    
    let questionTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .left
        textField.attributedPlaceholder = NSAttributedString(
            string: "Type your question here",
            attributes: [.foregroundColor: UIColor.defaultgrey]
        )
        
        return textField
    }()
    
    let addQuestionButton: UIButton = {
        let button = UIButton()
        button.setImage(.lightarrow, for: .normal)
        return button
    }()
    
    let buttonTitles = ["Swift", "UIKit", "Xcode", "iOS", "Objective-C", "Django", "API"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupUI()
        addButtons()
        addQuestionButton.addTarget(self, action: #selector(addingQuestion), for: .touchUpInside)
    }
    
    func setupUI() {
        view.addSubview(sunbejctView)
        sunbejctView.addSubview(subjectLabel)
        sunbejctView.addSubview(subjectTextField)
        view.addSubview(tagView)
        tagView.addSubview(tagLabel)
        tagView.addSubview(tagContainer)
        view.addSubview(buttonContainer)
        view.addSubview(questionView)
        questionView.addSubview(addQuestionButton)
        questionView.addSubview(questionTextField)
        
        
        sunbejctView.translatesAutoresizingMaskIntoConstraints = false
        subjectLabel.translatesAutoresizingMaskIntoConstraints = false
        subjectTextField.translatesAutoresizingMaskIntoConstraints = false
        tagView.translatesAutoresizingMaskIntoConstraints = false
        tagLabel.translatesAutoresizingMaskIntoConstraints = false
        tagContainer.translatesAutoresizingMaskIntoConstraints = false
        buttonContainer.translatesAutoresizingMaskIntoConstraints = false
        questionView.translatesAutoresizingMaskIntoConstraints = false
        questionTextField.translatesAutoresizingMaskIntoConstraints = false
        addQuestionButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sunbejctView.topAnchor.constraint(equalTo: view.topAnchor, constant: 77),
            sunbejctView.leftAnchor.constraint(equalTo: view.leftAnchor),
            sunbejctView.rightAnchor.constraint(equalTo: view.rightAnchor),
            sunbejctView.heightAnchor.constraint(equalToConstant: 47),
            
            subjectLabel.leftAnchor.constraint(equalTo: sunbejctView.leftAnchor, constant: 14),
            subjectLabel.topAnchor.constraint(equalTo: sunbejctView.topAnchor, constant: 14),
            subjectLabel.heightAnchor.constraint(equalToConstant: 18),
            subjectLabel.widthAnchor.constraint(equalToConstant: 63),
            
            subjectTextField.leftAnchor.constraint(equalTo: subjectLabel.rightAnchor, constant: 3),
            subjectTextField.topAnchor.constraint(equalTo: sunbejctView.topAnchor, constant: 14),
            subjectTextField.heightAnchor.constraint(equalToConstant: 18),
            subjectTextField.rightAnchor.constraint(equalTo: sunbejctView.rightAnchor),
            
            tagView.topAnchor.constraint(equalTo: sunbejctView.bottomAnchor),
            tagView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tagView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tagView.heightAnchor.constraint(equalToConstant: 47),
            
            tagLabel.leftAnchor.constraint(equalTo: tagView.leftAnchor, constant: 14),
            tagLabel.topAnchor.constraint(equalTo: tagView.topAnchor, constant: 14),
            tagLabel.heightAnchor.constraint(equalToConstant: 18),
            tagLabel.widthAnchor.constraint(equalToConstant: 37),
            
            tagContainer.leftAnchor.constraint(equalTo: tagLabel.rightAnchor, constant: 10),
            tagContainer.rightAnchor.constraint(equalTo: tagView.rightAnchor, constant: -10),
            tagContainer.topAnchor.constraint(equalTo: tagView.topAnchor, constant: 8),
            tagContainer.bottomAnchor.constraint(equalTo: tagView.bottomAnchor, constant: -8),
            
            buttonContainer.topAnchor.constraint(equalTo: tagView.bottomAnchor, constant: 10),
            buttonContainer.leftAnchor.constraint(equalTo: view.leftAnchor),
            buttonContainer.rightAnchor.constraint(equalTo: view.rightAnchor),
            buttonContainer.heightAnchor.constraint(equalToConstant: 100), // Adjust as needed
            
            questionView.topAnchor.constraint(equalTo: buttonContainer.bottomAnchor, constant: 40),
            questionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            questionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            questionView.heightAnchor.constraint(equalToConstant: 43),
            
            addQuestionButton.topAnchor.constraint(equalTo: questionView.topAnchor, constant: 12),
            addQuestionButton.rightAnchor.constraint(equalTo: questionView.rightAnchor, constant: -12),
            addQuestionButton.heightAnchor.constraint(equalToConstant: 18),
            addQuestionButton.widthAnchor.constraint(equalToConstant: 21),
            
            questionTextField.topAnchor.constraint(equalTo: questionView.topAnchor, constant: 8),
            questionTextField.bottomAnchor.constraint(equalTo: questionView.bottomAnchor, constant: -8),
            questionTextField.leftAnchor.constraint(equalTo: questionView.leftAnchor, constant: 16),
            questionTextField.rightAnchor.constraint(equalTo: addQuestionButton.rightAnchor, constant: -30),
            

        ])
    }
    
    func addButtons() {
        var xOffset: CGFloat = 10
        var yOffset: CGFloat = 10
        let spacing: CGFloat = 10

        for title in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.backgroundColor = .systemBlue
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 5
            button.sizeToFit()

            let buttonWidth = button.frame.width + 20 // Add padding
            let buttonHeight: CGFloat = 30

            if xOffset + buttonWidth > view.frame.width {
                xOffset = 10
                yOffset += buttonHeight + spacing
            }

            button.frame = CGRect(x: xOffset, y: yOffset, width: buttonWidth, height: buttonHeight)
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)

            buttonContainer.addSubview(button)
            xOffset += buttonWidth + spacing
        }
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        guard let title = sender.title(for: .normal) else { return }
        addTag(title: title)
        selectedTags.append(title)
    }
    
    func addTag(title: String) {
        let tagButton = UIButton(type: .system)
        tagButton.setTitle(title, for: .normal)
        tagButton.backgroundColor = .systemBlue
        tagButton.setTitleColor(.white, for: .normal)
        tagButton.layer.cornerRadius = 5
        tagButton.sizeToFit()

        let tagWidth = tagButton.frame.width + 20 // Padding
        let tagHeight: CGFloat = 30

        var xOffset: CGFloat = 0
        var yOffset: CGFloat = 0

        if let lastSubview = tagContainer.subviews.last {
            let lastFrame = lastSubview.frame
            xOffset = lastFrame.maxX + 10 // Add spacing
            yOffset = lastFrame.minY

            if xOffset + tagWidth > tagContainer.frame.width {
                xOffset = 0
                yOffset = lastFrame.maxY + 10 // Wrap to new line
            }
        }

        tagButton.frame = CGRect(x: xOffset, y: yOffset, width: tagWidth, height: tagHeight)
        tagButton.addTarget(self, action: #selector(removeTag(_:)), for: .touchUpInside)

        tagContainer.addSubview(tagButton)
    }
    
    @objc func removeTag(_ sender: UIButton) {
        sender.removeFromSuperview()
        reorganizeTags()
    }
    
    func reorganizeTags() {
        var xOffset: CGFloat = 0
        var yOffset: CGFloat = 0

        for subview in tagContainer.subviews {
            guard let tagButton = subview as? UIButton else { continue }
            let tagWidth = tagButton.frame.width
            let tagHeight: CGFloat = 30

            if xOffset + tagWidth > tagContainer.frame.width {
                xOffset = 0
                yOffset += tagHeight + 10
            }

            tagButton.frame = CGRect(x: xOffset, y: yOffset, width: tagWidth, height: tagHeight)
            xOffset += tagWidth + 10
        }
    }
    
    func setupNavigationBar() {
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 77))
        navigationBar.backgroundColor = .white

        let navigationItem = UINavigationItem(title: "Add Question")
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
        navigationItem.rightBarButtonItem = cancelButton

        navigationBar.items = [navigationItem]

        view.addSubview(navigationBar)
    }
    
    @objc private func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func addingQuestion() {
        let subject = subjectTextField.text ?? ""
        let questionText = questionTextField.text ?? ""
        let tags = selectedTags
        viewModel.addquestion(subject: subject, text: questionText, tags: tags)
        
        NotificationCenter.default.post(name: .didAddNewQuestion, object: nil, userInfo: [
                "subject": subject,
                "questionText": questionText,
                "tags": tags
            ])

        dismiss(animated: true, completion: nil)
        
        subjectTextField.text = ""
        questionTextField.text = ""
        selectedTags.removeAll()
        tagContainer.subviews.forEach { $0.removeFromSuperview() }
    }
}

extension Notification.Name {
    static let didAddNewQuestion = Notification.Name("didAddNewQuestion")
}
