//
//  CreateCatModel.swift
//  FitCat2
//
//  Created by Austin Astorga on 1/3/17.
//  Copyright © 2017 Ming Yang. All rights reserved.

import Foundation

class CreateCatModel: NSObject {
    
     var catName: String
     var catBirthday: Date
     var catBreed: String
     var catInitialWeight: Double
     var catNeutered: Int
     var catGender: Int
     var catInitialBCS: Int
     var catPictureData: Data
     var catPlan: PlanModel
     var catFeeding: CatFeedingModel

    /// Init to create a new cat
    ///
    /// - Parameters:
    ///   - user_id: id of the user
    ///   - name: name of the cat
    ///   - birthday: birthday of the cat
    ///   - breed_id: breed id of the cat
    ///   - initial_weight: initial weight of the cat
    ///   - neutered: if cat is neutered/spayed
    ///   - gender: gender of cat
    ///   - initial_bcs: initial bcs of cat
    ///   - image_id: image id of cat picture
    ///   - cat_id: id of the cat
    
    init(catName: String, catBirthday: Date, catBreed: String, catInitialWeight: Double, catNeutered: Int, catGender: Int, catInitialBCS: Int, catPictureData: Data, catPlan: PlanModel, catFeeding: CatFeedingModel) {
        self.catName = catName
        self.catBirthday = catBirthday
        self.catBreed = catBreed
        self.catInitialWeight = catInitialWeight
        self.catNeutered = catNeutered
        self.catGender = catGender
        self.catInitialBCS = catInitialBCS
        self.catPictureData = catPictureData
        self.catPlan = catPlan
        self.catFeeding = catFeeding
    }    
}
