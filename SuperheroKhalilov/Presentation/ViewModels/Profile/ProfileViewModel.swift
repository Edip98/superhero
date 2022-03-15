//
//  ProfileViewModel.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 22.02.2022.
//

import Foundation

class ProfileViewModel {
    
    let profile = ProfileManager.sharedInstance.userProfile
    let supermanBackgroundImageName = "SupermanProfileImage"
    let supergirlBackgroundImageName = "SupergirlProfileImage"
    let rightBarButtonItemTitle = "Save"
}
