//
//  HomeViewModel.swift
//  SuperheroKhalilov
//
//  Created by Эдип on 19.02.2022.
//

import Foundation

class HomeViewModel {
    
    var profile = ProfileManager.sharedInstance.userProfile
    
    let supermanBackgroundImageName = "SupermanHomeImage"
    let supergirlBackgroundImageName = "SupergirlHomeImage"
}
