//
//  BaseTextView.swift
//  InstagramClone
//
//  Created by Bakhrom Usmanov on 06/06/25.
//

import UIKit

final class BaseTextView: UITextView {
   
   //MARK: - Subviews
   
   private let placeholderLabel = UILabel()
   
   //MARK: - Initialization
   
   override init(frame: CGRect, textContainer: NSTextContainer?) {
      super.init(frame: frame, textContainer: textContainer)
      setupViews()
      setupPadding()
      setTextObserver()
   }

   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   deinit {
      NotificationCenter.default.removeObserver(self)
   }
   
   //MARK: - Custom Padding
   
   func setupPadding() {
      textContainerInset = UIEdgeInsets(top: Constants.verticalPadding, left: Constants.horizontalPadding, bottom: Constants.verticalPadding, right: Constants.horizontalPadding
      )
      textContainer.lineFragmentPadding = 0 // removes extra internal padding
   }
   
   //MARK: - Public Methods
   
   func setPlaceholder(text: String, font: UIFont, color: UIColor) {
      placeholderLabel.text = text
      placeholderLabel.font = font
      placeholderLabel.textColor = color
   }
   
   @objc
   func handleTextDidChange() {
      placeholderLabel.isHidden = !text.isEmpty
   }
}

//MARK: - Observers

private extension BaseTextView {
   func setTextObserver() {
      NotificationCenter.default.addObserver(self, selector: #selector(handleTextDidChange), name: UITextView.textDidChangeNotification, object: nil)
   }
}

//MARK: - Layout & Subviews

private extension BaseTextView {
   func setupViews() {
      addSubview(placeholderLabel)
      placeholderLabel.snp.makeConstraints { make in
         make.top.equalTo(Constants.verticalPadding)
         make.leading.equalTo(Constants.horizontalPadding)
      }
   }
}

//MARK: - Constants

private extension BaseTextView {
   enum Constants {
      static let verticalPadding: CGFloat = 12
      static let horizontalPadding: CGFloat = 12
   }
}
