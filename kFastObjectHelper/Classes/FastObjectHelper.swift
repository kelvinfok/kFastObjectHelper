//
//  FastObjectHelper.swift
//  kFastObjectHelper
//
//  Created by Kelvin Fok on 5/12/18.
//

import UIKit

public struct FastObjectHelper {
    
    public static func createProgressView(tintColor: UIColor) -> UIProgressView {
        let bar = UIProgressView(progressViewStyle: .default)
        bar.progressTintColor = tintColor
        return bar
    }
    
    public static func createActivityIndicator(style: UIActivityIndicatorView.Style) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: style)
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }
    
    public static func createPageControl(numberOfPages: Int) -> UIPageControl {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.numberOfPages = numberOfPages
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.pageIndicatorTintColor = UIColor(white: 1, alpha: 0.5)
        return pageControl
    }
    
    public static func createSearchBar(delegate: UISearchBarDelegate, placeholder: String) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = delegate
        searchBar.backgroundImage = UIImage()
        searchBar.placeholder = placeholder
        searchBar.tintColor = .white
        searchBar.keyboardAppearance = .dark
        searchBar.showsCancelButton = true
        searchBar.sizeToFit()
        return searchBar
    }
    
    public static func createSegmentedControl(items: [Any], attributes: [NSAttributedString.Key : Any]?) -> UISegmentedControl {
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.tintColor = .white
        if let attributes = attributes {
            segmentedControl.setTitleTextAttributes(attributes, for: .normal)
        }
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }
    
    public static func createCollectionView(delegate: UICollectionViewDelegate,
                                     dataSource: UICollectionViewDataSource,
                                     cellClassesAndReuseIdentifiers: [(AnyClass, String)],
                                     sectionInsets: UIEdgeInsets?,
                                     headerViewClass: AnyClass?,
                                     headerReuseIdentifier: String?,
                                     footerViewClass: AnyClass? = nil,
                                     footerReuseIdentifier: String? = nil,
                                     isPagingEnabled: Bool = false,
                                     scrollDirection: UICollectionView.ScrollDirection = .vertical,
                                     backgroundColor: UIColor? = nil,
                                     contentInsets: UIEdgeInsets? = nil,
                                     scrollIndicatorInsets: UIEdgeInsets? = nil,
                                     minimumLineSpacing: CGFloat? = nil,
                                     minimumInteritemSpacing: CGFloat? = nil,
                                     showsHorizontalScrollIndicator: Bool? = nil,
                                     showsVerticalScrollIndicator: Bool? = nil) -> UICollectionView {
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = sectionInsets ?? .zero
        layout.minimumLineSpacing = minimumLineSpacing ?? 0
        layout.minimumInteritemSpacing = minimumInteritemSpacing ?? 0
        layout.scrollDirection = scrollDirection
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        if #available(iOS 11.0, *) {
            collectionView.insetsLayoutMarginsFromSafeArea = false
            collectionView.contentInsetAdjustmentBehavior = .never
        }
        collectionView.delegate = delegate
        collectionView.dataSource = dataSource
        collectionView.isPagingEnabled = isPagingEnabled
        collectionView.keyboardDismissMode = .onDrag
        collectionView.contentInset = contentInsets ?? .zero
        collectionView.scrollIndicatorInsets = scrollIndicatorInsets ?? .zero
        collectionView.backgroundColor = backgroundColor ?? .darkGray
        collectionView.showsVerticalScrollIndicator = showsVerticalScrollIndicator ?? true
        collectionView.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator ?? true
        if let headerViewClass = headerViewClass, let headerReuseIdentifier = headerReuseIdentifier {
            collectionView.register(headerViewClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier)
        }
        if let footerViewClass = footerViewClass, let footerReuseIdentifier = footerReuseIdentifier {
            collectionView.register(footerViewClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerReuseIdentifier)
        }
        for cellClassAndReuseIdentifier in cellClassesAndReuseIdentifiers {
            collectionView.register(cellClassAndReuseIdentifier.0, forCellWithReuseIdentifier: cellClassAndReuseIdentifier.1)
        }
        return collectionView
    }
    
    public static func createTableView(delegate: UITableViewDelegate,
                                dataSource: UITableViewDataSource,
                                cellClassesAndReuseIdentifiers: [(cellClass: AnyClass, reuseIdentifier: String)],
                                headerCellClass: AnyClass? = nil,
                                headerCellReuseIdentifier: String? = nil,
                                footerCellClass: AnyClass? = nil,
                                footerCellReuseIdentifier: String? = nil,
                                allowsSelection: Bool = true,
                                backgroundColor: UIColor? = nil,
                                rowHeight: CGFloat? = nil,
                                contentInset: UIEdgeInsets? = nil) -> UITableView {
        
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = backgroundColor != nil ? backgroundColor! : .darkGray
        tableView.allowsSelection = allowsSelection
        tableView.delegate = delegate
        tableView.dataSource = dataSource
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        }
        if let contentInset = contentInset {
            tableView.contentInset = contentInset
        }
        if let rowHeight = rowHeight {
            tableView.rowHeight = rowHeight
        }
        if let headerCellClass = headerCellClass, let headerCellReuseIdentifier = headerCellReuseIdentifier {
            tableView.register(headerCellClass, forHeaderFooterViewReuseIdentifier: headerCellReuseIdentifier)
        }
        if let footerCellClass = footerCellClass, let footerCellReuseIdentifier = footerCellReuseIdentifier {
            tableView.register(footerCellClass, forHeaderFooterViewReuseIdentifier: footerCellReuseIdentifier)
        }
        for cellClassAndReuseIdentifier in cellClassesAndReuseIdentifiers {
            tableView.register(cellClassAndReuseIdentifier.cellClass, forCellReuseIdentifier: cellClassAndReuseIdentifier.reuseIdentifier)
        }
        return tableView
    }
    
    public static func createLabel(backgroundColor: UIColor? = nil, attributedText: NSAttributedString? = nil, textAlignment: NSTextAlignment? = .left, numberOfLines: Int? = 1, adjustsFontSizeToFitWidth: Bool? = nil, isHidden: Bool = false) -> UILabel {
        let label = UILabel()
        label.backgroundColor = backgroundColor ?? .clear
        label.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth ?? false
        if let attributedText = attributedText {
            label.attributedText = attributedText
        }
        if let textAlignment = textAlignment {
            label.textAlignment = textAlignment
        }
        if let numberOfLines = numberOfLines {
            label.numberOfLines = numberOfLines
        }
        label.isHidden = isHidden
        return label
    }
    
    static func createTextView(backgroundColor: UIColor) -> UITextView {
        let textView = UITextView()
        textView.backgroundColor = backgroundColor
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.contentInset = .zero
        textView.textContainer.lineFragmentPadding = 0
        return textView
    }
    
    public static func createButton(backgroundColor: UIColor? = nil,
                             cornerRadius: CGFloat? = nil,
                             image: UIImage? = nil,
                             attributedText: NSMutableAttributedString? = nil,
                             contentAlignment: UIControl.ContentHorizontalAlignment? = .center,
                             isHidden: Bool? = false,
                             numberOfLines: Int? = 1,
                             textAlignment: NSTextAlignment? = .center) -> UIButton {
        
        let button = UIButton()
        button.backgroundColor = backgroundColor ?? .clear
        if let numberOfLines = numberOfLines {
            button.titleLabel?.numberOfLines = numberOfLines
        }
        if let textAlignment = textAlignment {
            button.titleLabel?.textAlignment = textAlignment
        }
        if let contentAlignment = contentAlignment {
            button.contentHorizontalAlignment = contentAlignment
        }
        if let cornerRadius = cornerRadius {
            button.layer.cornerRadius = cornerRadius
            button.layer.masksToBounds = true
        }
        if let image = image {
            button.setImage(image, for: .normal)
        }
        if let attributedText = attributedText {
            button.setAttributedTitle(attributedText, for: .normal)
        }
        if let isHidden = isHidden {
            button.isHidden = isHidden
        }
        return button
    }
    
    public static func createImageView(backgroundColor: UIColor? = nil, cornerRadius: CGFloat? = nil, image: UIImage? = nil, contentMode: UIView.ContentMode? = .scaleAspectFill, borderWidth: CGFloat? = nil, borderColor: UIColor? = nil) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = image
        imageView.backgroundColor = backgroundColor ?? .clear
        imageView.clipsToBounds = true
        if let contentMode = contentMode {
            imageView.contentMode = contentMode
        }
        if let borderWidth = borderWidth {
            imageView.layer.borderWidth = borderWidth
        }
        if let borderColor = borderColor {
            imageView.layer.borderColor = borderColor.cgColor
        }
        if let cornerRadius = cornerRadius {
            imageView.layer.cornerRadius = cornerRadius
            imageView.layer.masksToBounds = true
        }
        return imageView
    }
    
    public static func createView(backgroundColor: UIColor? = .clear, cornerRadius: CGFloat? = nil, alpha: CGFloat? = 1, isHidden: Bool? = nil) -> UIView {
        let view = UIView()
        view.backgroundColor = backgroundColor
        view.isHidden = isHidden ?? false
        view.alpha = alpha ?? 1
        if let cornerRadius = cornerRadius {
            view.layer.cornerRadius = cornerRadius
            view.layer.masksToBounds = true
        }
        return view
    }
    
    public static func createTextField(placeholder: String? = nil,
                                placeholderAttributes: [NSAttributedString.Key : Any]?,
                                keyboardType: UIKeyboardType,
                                textAlignment: NSTextAlignment? = nil,
                                isSecureTextEntry: Bool? = nil,
                                delegate: UITextFieldDelegate? = nil,
                                leftInset: CGFloat? = nil,
                                font: UIFont? = nil,
                                backgroundColor: UIColor? = nil,
                                cornerRadius: CGFloat? = nil,
                                returnKeyType: UIReturnKeyType? = nil) -> UITextField {
        
        let textField = UITextField()
        textField.textColor = .white
        textField.tintColor = .white
        textField.textAlignment = textAlignment != nil ? textAlignment! : .left
        if let placeholder = placeholder {
            if let attributes = placeholderAttributes {
                let text = NSAttributedString(string: placeholder, attributes: attributes)
                textField.attributedPlaceholder = text
            } else {
                textField.placeholder = placeholder
            }
        }
        textField.backgroundColor = backgroundColor ?? .darkGray
        textField.keyboardAppearance = .dark
        textField.keyboardType = keyboardType
        textField.isSecureTextEntry = isSecureTextEntry != nil ? isSecureTextEntry! : false
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.delegate = delegate != nil ? delegate! : nil
        
        if let cornerRadius = cornerRadius {
            textField.layer.cornerRadius = cornerRadius
            textField.layer.masksToBounds = true
        }
        textField.returnKeyType = returnKeyType ?? .default
        if let leftInset = leftInset {
            let frame = CGRect(x: 0, y: 0, width: leftInset, height: textField.frame.height)
            let paddingView = UIView(frame: frame)
            textField.leftView = paddingView
            textField.leftViewMode = .always
        }
        return textField
    }
    
    @available(iOS 9.0, *)
    public static func createStackView(views: [UIView], axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution, alignment: UIStackView.Alignment, spacing: CGFloat) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.distribution = distribution
        stackView.alignment = alignment
        stackView.spacing = spacing
        views.forEach { stackView.addArrangedSubview($0)}
        return stackView
    }
    
    public static func createParagraphyStyle(alignment: NSTextAlignment, lineSpacing: CGFloat? = 2) -> NSMutableParagraphStyle {
        let style = NSMutableParagraphStyle()
        style.alignment = alignment
        if let lineSpacing = lineSpacing {
            style.lineSpacing = lineSpacing
        }
        return style
    }
}
