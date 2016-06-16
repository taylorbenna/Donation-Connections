//
//  SignUpProtocol.swift
//  Donation Connections
//
//  Created by Taylor Benna on 2016-06-15.
//  Copyright © 2016 Taylor Benna. All rights reserved.
//

import UIKit

protocol SignUpProtocol {
    
    func xibCancelButton()
    func imagePickerPresent(imagePicker: UIImagePickerController)
    func sendInfoForAlert(title: String, desc: String)
}
