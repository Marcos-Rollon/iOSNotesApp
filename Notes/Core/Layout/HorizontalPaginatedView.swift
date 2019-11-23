//
//  HorizontalPaginatedView.swift
//
//  Created by Marcos Rollón Rivas on 27/5/19.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import UIKit

class HorizontalPaginatedView : UIView, UIScrollViewDelegate {
    
    //MARK: - Views
    
    private var scrollView      : UIScrollView!
    private var stackView       : UIStackView!
    private var pageControl     : UIPageControl!
    
    //MARK: - Properties
    
    private var numOfViews       : Int   = 0
    
    //MARK: - Init
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    
    //MARK: - Public API
    
    public func addView (view : UIView){
        view.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.addArrangedSubview(view)
        view.height(equalTo: self.heightAnchor, constant: 0)
        view.width(equalTo: self.widthAnchor, constant: 0)
        numOfViews += 1
        self.pageControl.numberOfPages = numOfViews
    }
    
    public func addViews ( views : [UIView]){
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            self.stackView.addArrangedSubview(view)
            view.height(equalTo: self.heightAnchor, constant: 0)
            view.width(equalTo: self.widthAnchor, constant: 0)
            numOfViews += 1
        }
        self.pageControl.numberOfPages = numOfViews
    }
    
    public func removeViews(){
        self.stackView.removeArrangedSubviews()
        self.numOfViews = 0
        self.pageControl.numberOfPages = 0
    }
    
    public func setCurrentPage(_ page : Int){
        if page > numOfViews - 1 || page < 0{
            print("index out of bounds!")
            return
        }
        pageControl.currentPage = page
        pageControlTapped(sender: pageControl)
    }
    
    public var currentPage : ((Int)->Void)? = nil
    
    //MARK: - Selectors
    
    //Function to move the dot of the page controller when swiped
    @objc func pageControlTapped(sender : UIPageControl){
        let pageWidth = scrollView.bounds.width
        let offset = sender.currentPage * Int(pageWidth)
        UIView.animate(withDuration: 0.33) {
            self.scrollView.contentOffset.x = CGFloat(offset)
        }
    }
    
    //MARK: - Helpers
    
    private func configureViews() {
        
        scrollView                                      = UIScrollView()
        scrollView.backgroundColor                      = .clear
        scrollView.showsHorizontalScrollIndicator       = false
        scrollView.isPagingEnabled                      = true
        scrollView.delegate                             = self
        scrollView.fill(theView: self)
        
        stackView   = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution                          = .equalSpacing
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
            ])
        
        pageControl = UIPageControl()
        addSubview(pageControl)
        pageControl.centerX(inView: self)
        pageControl.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 10).isActive = true
        pageControl.numberOfPages = self.numOfViews
        pageControl.addTarget(self, action: #selector(pageControlTapped(sender:)), for: .valueChanged)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.bounds.width
        let pageFraction = scrollView.contentOffset.x / pageWidth
        pageControl.currentPage = Int((round(pageFraction)))
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentPage?(pageControl.currentPage)
    }
}
