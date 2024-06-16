//
//  Resources.swift
//  TestTaskApp
//
//  Created by Никита Гладышев on 13.06.2024.
//

import UIKit

enum R {
    enum Image {
        static let mainVCBarItemImage = UIImage(named: "Plane") 
        static let hotelsVCBarItemImage = UIImage(named: "Hotels")
        static let geoVCBarItemImage = UIImage(named: "Geo")
        static let bellVCBarItemImage = UIImage(named: "Bell")
        static let profileVCBarItemImage = UIImage(named: "Profile")
        static let stubImage = UIImage(systemName: "exclamationmark.triangle.fill")
        static let collectionViewFirstImage = UIImage(named: "collectionViewFirstImage")
        static let collectionViewSecondImage = UIImage(named: "collectionViewSecondImage")
        static let collectionViewThirdImage = UIImage(named: "collectionViewThirdImage")
        static let textFieldSearchImage = UIImage(named: "Search")
        static let searchViewPlaneImage = UIImage(named: "VectorPlane")
        static let horizontalStackRoutButtonImage = UIImage(named: "Rout")
        static let horizontalStackAnywhereButtonImage = UIImage(named: "Anywhere")
        static let horizontalStackWeekendButtonImage = UIImage(named: "Weekend")
        static let horizontalStackFireButtonImage = UIImage(named: "Fire")
        static let backButtonImage = UIImage(named: "LeftChevron") ?? UIImage()
        static let filterImage = UIImage(named: "Filter")
        static let barImage = UIImage(named: "Bar")
        static let cancelButtonImage = UIImage(named: "Cancel") ?? UIImage()
        static let swapButtonImage = UIImage(named: "Swap") ?? UIImage()
        static let searchScreenFirstImage = UIImage(named: "searchScreenFirstImage") ?? UIImage()
        static let searchScreenSecondImage = UIImage(named: "searchScreenSecondImage") ?? UIImage()
        static let searchScreenThirdImage = UIImage(named: "searchScreenThirdImage") ?? UIImage()
        static let selectedCountryCollectionViewPlusImage = UIImage(named: "plusImage")
        static let selectedCountryCollectionViewProfileImage = UIImage(named: "profileImage")
        static let selectedCountryCollectionViewFilterImage = UIImage(named: "filterImage")
    }
    
    enum Color {
        static let selectedBarItenColor = UIColor(hex: "#4C95FE")
        static let unselectedBarItemColor = UIColor(hex: "#9F9F9F") ?? .white
        static let primaryTextColor = UIColor(hex: "#D9D9D9") ?? .white
        static let primaryViewColor = UIColor(hex: "#2F3035")
        static let textFieldViewColor = UIColor(hex: "#3E3F43")
        static let shadowColor: UIColor = .black
        static let searchViewControllerColor = UIColor(hex: "#242529")
        static let horizontalStackRoutButtonColor = UIColor(hex: "#3A633B")
        static let horizontalStackAnywhereButtonColor = UIColor(hex: "#2261BC")
        static let horizontalStackWeekendButtonColor = UIColor(hex: "#00427D")
        static let horizontalStackFireButtonColor = UIColor(hex: "#FF5E5E")
        static let primaryTableViewColor = UIColor(hex: "#5E5F61")
        static let selectedCountryTableViewColor = UIColor(hex: "#1D1E20")
    }
    
    enum Title {
        static let stubMainTitle = "Ничего не загрузилось"
        static let stubReasonTitle = "Скорее всего, что-то с интернетом."
        static let stubDescriptionTitle = "Проверьте подключение и попробуйте зайти еще разок. А мы пока посмотрим, не сломалось ли у нас чего."
        static let mainModuleTitle = "Поиск дешевых \nавиабилетов"
        static let mainModuleTopicalTitle = "Музыкально отлететь"
    }
    
    enum Font {
        static let SFProDisplaySemibold = "SFProDisplay-Semibold"
        static let SFProDisplayRegular = "SFProDisplay-Regular"
        static let SFProDisplayMediumItalic = "SFProDisplay-MediumItalic"
    }
}
