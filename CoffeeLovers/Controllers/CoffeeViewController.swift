//
//  CoffeeViewController.swift
//  CoffeeLovers
//
//  Created by Valeria on 28.08.2018.
//  Copyright © 2018 Valeria. All rights reserved.
//

import UIKit
import CoreData

class CoffeeViewController: UIViewController, UIScrollViewDelegate, CoffeeAdditionsDelegate {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var imagesScrollVIew: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var sizeSegment: UISegmentedControl!
    @IBOutlet weak var sugarSegment: UISegmentedControl!
    @IBOutlet weak var additionsView: CoffeeAdditionsView!
    @IBOutlet weak var caloriesView: UILabel!
    @IBOutlet weak var saveButton: UIButton!
   
    //MARK: - Properties
    
    let appDelegate : AppDelegate = (UIApplication.shared.delegate) as! AppDelegate
    lazy var context = appDelegate.persistentContainer.viewContext
    
    var coffee : Coffee?
    var coffeeImageTitles = [String]()
    var imageSlides = [ImageSlideView]()
    
    var coffeeSize : Double = 250 {
        didSet{
           showCalories()
        }
    }
    var coffeeSugar : Double = 0 {
        didSet{
           showCalories()
        }
    }
    
    var isCreamSelected : Bool = false {
        didSet{
            showCalories()
        }
    }
    
    var isSyrupSelected : Bool = false {
        didSet{
            showCalories()
        }
    }
   
    
    //MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        additionsView.delegate = self
        
        guard let coffee = coffee else { fatalError("Coffee not found") }
        
        title = coffee.title
        showCalories()
        
        coffeeImageTitles = getImageSet(from: coffee)
        imageSlides = getImageSlides(from: coffeeImageTitles)
        setImagesScrollView(with: imageSlides)
        setPageControl()
        
        setSaveButton()
    }
    
    //MARK: - Setup Methods
    
    func getImageSet(from coffee : Coffee) -> [String] {
        var imageSet = [String]()
        imageSet.append(coffee.imageOfIngredients!)
        
        let request : NSFetchRequest<ImageSet> = ImageSet.fetchRequest()
        let predicate = NSPredicate(format: "coffee.title = %@", coffee.title!)
        request.predicate = predicate
        
        do{
            let fetchResult = try context.fetch(request)
            for (_, coffee) in fetchResult.enumerated() {
                imageSet.append(coffee.title!)
            }
            
        } catch {print("Error fetching ImageSet")}
        
        return imageSet
    }
    
    func getImageSlides(from imageSet : [String]) -> [ImageSlideView] {
        var slideArray = [ImageSlideView]()
        
        for title in imageSet {
            let slide : ImageSlideView = Bundle.main.loadNibNamed("ImageSlideView", owner: self, options: nil)?.first as! ImageSlideView
            slide.imageView.image = UIImage(named: title)
            slideArray.append(slide)
        }
        
        return slideArray
    }
    
    private func setImagesScrollView(with slides : [ImageSlideView]){
        imagesScrollVIew.delegate = self
        
        imagesScrollVIew.contentSize = CGSize(width: imagesScrollVIew.frame.width * CGFloat(slides.count), height: imagesScrollVIew.frame.height)
        imagesScrollVIew.showsHorizontalScrollIndicator = false
        imagesScrollVIew.showsVerticalScrollIndicator = false
        imagesScrollVIew.isPagingEnabled = true
        
        for index in 0..<slides.count {
            slides[index].frame = CGRect(x: imagesScrollVIew.frame.width * CGFloat(index), y: 0, width: imagesScrollVIew.frame.width , height: imagesScrollVIew.frame.height)
            
            imagesScrollVIew.addSubview(slides[index])
        }
    }
    
    private func setPageControl(){
        pageControl.numberOfPages = imageSlides.count
        pageControl.currentPage = 0
    }
    
    private func showCalories() {
        var calories = coffee!.calories/250 * coffeeSize + coffeeSugar
        calories = isCreamSelected ? calories + 2 : calories
        calories = isSyrupSelected ? calories + 1 : calories
        caloriesView.text = "\(calories)"
    }
    
    //MARK: - Actions
    
    @IBAction func savePressed(_ sender: UIButton) {
      
        coffee!.setValue(!((coffee!.isFavourite)), forKey: "isFavourite")
        setSaveButton()
        
        appDelegate.saveContext()
    }
    
    @IBAction func coffeeSizeChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: coffeeSize = 250
        case 1: coffeeSize = 300
        case 2: coffeeSize = 400
        default:
            print("Something gone wrong")
        }
    }
    
    @IBAction func coffeeSugarChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: coffeeSugar = 0
        case 1: coffeeSugar = 10
        case 2: coffeeSugar = 20
        case 3: coffeeSugar = 40
        default:
             print("Something gone wrong")
        }
    }
    
    //MARK: - UIScrollView Delegate Methods
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
    
    private func setSaveButton(){
        let isFavourite = coffee?.isFavourite
        
        if isFavourite == true {
            saveButton.backgroundColor = UIColor.espressoColor()
            saveButton.setTitle("Saved to Favourite", for: .normal)
            saveButton.setTitleColor(UIColor.white, for: .normal)
            saveButton.layer.cornerRadius = 10.0
        }else{
            saveButton.backgroundColor = UIColor.white
            saveButton.setTitle("Save to Favourite", for: .normal)
            saveButton.setTitleColor(UIColor.espressoColor(), for: .normal)
            saveButton.layer.cornerRadius = 10.0
            saveButton.layer.borderColor = UIColor.espressoColor().cgColor
            saveButton.layer.borderWidth = 1.0
        }
    }
    
    //MARK: - CoffeeAdittionsView Delegate Methods
    
    func creamPressed(isCreamSelected: Bool) {
        self.isCreamSelected = isCreamSelected
    }
    
    func syrupPressed(isSyrupSelected: Bool) {
        self.isSyrupSelected = isSyrupSelected
    }
}
