//
//  DetailsCell.swift
//  StayConnected
//
//  Created by Giorgi on 04.12.24.
//
import UIKit

final class DetailsCell: UICollectionViewCell {
    private let contentContainer = UIView() // Main content container
    private let actionView = UIView()      // Swipeable action view
    private let actionLabel = UILabel()    // Action label
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupPanGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        // Action View (Revealed on Swipe)
        actionView.backgroundColor = .systemBlue
        actionView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(actionView)
        
        // Add "Accept" Label
        actionLabel.text = "Accept"
        actionLabel.textColor = .white
        actionLabel.font = .boldSystemFont(ofSize: 16)
        actionLabel.textAlignment = .center
        actionLabel.translatesAutoresizingMaskIntoConstraints = false
        actionView.addSubview(actionLabel)
        
        // Main Content Container
        contentContainer.backgroundColor = .white
        contentContainer.layer.cornerRadius = 8
        contentContainer.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(contentContainer)
        
        NSLayoutConstraint.activate([
            // Action View Constraints
            actionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            actionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            actionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            actionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            actionLabel.centerXAnchor.constraint(equalTo: actionView.centerXAnchor),
            actionLabel.centerYAnchor.constraint(equalTo: actionView.centerYAnchor),
            
            // Content Container Constraints
            contentContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    private func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        contentContainer.addGestureRecognizer(panGesture)
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: contentView)
        
        switch gesture.state {
        case .changed:
            // Allow swiping left only
            if translation.x < 0 {
                contentContainer.transform = CGAffineTransform(translationX: translation.x, y: 0)
            }
        case .ended, .cancelled:
            // Check swipe threshold (e.g., -100 points)
            if translation.x < -100 {
                completeSwipeAction()
            } else {
                resetCellPosition()
            }
        default:
            break
        }
    }
    
    private func completeSwipeAction() {
        UIView.animate(withDuration: 0.3) {
            self.contentContainer.transform = CGAffineTransform(translationX: -self.contentView.bounds.width, y: 0)
        } completion: { _ in
            print("Swipe Action Triggered")
            // You can trigger a delegate or closure here to notify the view controller
        }
    }
    
    private func resetCellPosition() {
        UIView.animate(withDuration: 0.3) {
            self.contentContainer.transform = .identity
        }
    }
}



#Preview {
    DetailsCell()
}


