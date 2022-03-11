//
//  ProfileViewModel.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 22.02.2022.
//

import Foundation

class ProfileViewModel {
    
    let supermanBackgroundImageName = "SupermanProfileImage"
    let supergirlBackgroundImageName = "SupergirlProfileImage"
    let nameTextFieldPlaceholderText = "Enter Your Name"
    let nameTitleText = "Name"
    let rightBarButtonItemTitle = "Save"
    let profile = ProfileManager.sharedInstance.userProfile
}
