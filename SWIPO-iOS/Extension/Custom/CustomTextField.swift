//
//  CustomTextField.swift
//  SWIPO-iOS
//
//  Created by 박지윤 on 11/18/24.
//

import SwiftUI
import UIKit

struct CustomTextField: UIViewRepresentable {
    var placeholder: String
    @Binding var text: String
    var placeholderColor: UIColor
    var textColor: UIColor
    var icon: UIImage?
    var iconColor: UIColor

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.textColor = textColor

        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: placeholderColor]
        )

        if let icon = icon {
            let iconView = UIImageView(image: icon)
            iconView.contentMode = .scaleAspectFit
            iconView.tintColor = iconColor
            textField.leftView = iconView
            textField.leftViewMode = .always
        }

        textField.delegate = context.coordinator
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: CustomTextField

        init(_ parent: CustomTextField) {
            self.parent = parent
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            parent.text = textField.text ?? ""
        }
    }
}
