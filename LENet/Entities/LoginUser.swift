//
//  User.swift
//  LENet
//
//  Created by Muhammad Zeeshan on 10/04/2020.
//  Copyright © 2020 LanguageEmpire. All rights reserved.
//

import Foundation
import UIKit

public class LoginUser  {
    static var userID : Int!
    static var isEmail : Int!
    static var idCardNo  = ""
    static var password  = ""
    static var firstName  = ""
    static var lastName  = ""
    static var fullName  = ""
    static var profileImage  = ""
    static var email  = ""
    static var mobile  = ""
    static var gender  = ""
    static var lEContactNo  = ""
    static var lEContactEmail  = ""
    static var noticeBoard  = ""
    static var noticeBoardTitle  = ""
    static var noticeBoardLink  = ""
    static var showSystemUpdates  = false
    static var showJobSheet  = false
    static var isFullTime  = false
    static var deviceId  = ""
    static var deviceType  = ""
    static var emptyMessage  = ""
    static var twoFACode  = ""
    static var version  = ""
    static var penaltyText  = ""
    static var themeColor  = ""
    static var qualification  = ""
    static var touchID  = false
    static var faceID  = false
    static var ratingsDetails  = ""
    static var addressLine1  = ""
    static var addressLine2  = ""
    static var addressLine3  = ""
    static var addressLine4  = ""
    static var postcode  = ""
    static var county  = ""
    static var country  = ""
    
    class var getRatingsDetails : String {
        return ratingsDetails
    }
    class var getAddressLine1 : String {
        return addressLine1
    }
    class var getAddressLine2 : String {
        return addressLine2
    }
    class var getAddressLine3 : String {
        return addressLine3
    }
    class var getAddressLine4 : String {
        return addressLine4
    }
    class var getPostcode : String {
        return postcode
    }
    class var getCounty : String {
        return county
    }
    class var getCountry : String {
        return country
    }
    
    
    class var getGender : String {
        return gender
    }
    class var getFaceID : Bool {
        return faceID
    }
    class var getTouchID : Bool {
        return touchID
    }
    class var getQualification : String {
        return qualification
    }
    class var getPenaltyText : String {
        return penaltyText
    }
    class var getVersion : String {
        return version
    }
    class var getThemeColor : String {
        return themeColor
    }
    class var getUserID : Int {
        return userID
    }
    class var getIsEmail : Int {
        return isEmail
    }
    class var getPassword : String {
        return password
    }
    class var getIdCardNo : String {
        return idCardNo
    }
    class var getFirstName : String {
        return firstName
    }
    class var getLastName : String {
        return lastName
    }
    class var getFullName : String {
        return fullName
    }
    class var getProfileImage : String {
        return profileImage
    }
    class var getEmail : String {
        return email
    }
    class var getMobile : String {
        return mobile
    }
    class var getLEContactNo : String {
        return lEContactNo
    }
    class var getLEContactEmail : String {
        return lEContactEmail
    }
    class var getNoticeBoard : String {
        return noticeBoard
    }
    class var getNoticeBoardTitle : String {
        return noticeBoardTitle
    }
    class var getNoticeBoardLink : String {
        return noticeBoardLink
    }
    class var getShowSystemUpdates : Bool {
        return showSystemUpdates
    }
    class var getShowJobSheet : Bool {
        return showJobSheet
    }
    class var getIsFullTime : Bool {
        return isFullTime
    }
    class var getDeviceId : String {
        return deviceId
    }
    class var getDeviceType : String {
        return deviceType
    }
    class var getEmptyMessage : String {
        return emptyMessage
    }
    class var getTwoFACode : String {
        return twoFACode
    }
}
