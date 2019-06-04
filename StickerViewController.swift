//
//  StickerViewController.swift
//  FAStickers
//
//  Created by Faris Albalawi on 6/4/19.
//


import UIKit

public protocol StickerEmojiDelegate {
    func EmojiTapped(EmojiName: String)
    func StickerTapped(StickerName: String)
    func GitTapped(GifName: String)
}



open class StickerViewController: UIViewController, UIGestureRecognizerDelegate {
    var headerView = UIView()
    var holdView = UIView()
    var scrollView = UIScrollView()
    var pageControl = UIPageControl()
    
    var stickerCollectioView: UICollectionView!
    
    
    var emojisDelegate: EmojisCVDelegate!
    var emojisCollectioView: UICollectionView!
    
    var gitCollectioView: UICollectionView!
   public var gits: [String] = []
    
    
   public var stickers: [String] = []
   public var stickerDelegate : StickerEmojiDelegate?
    
    
    let screenSize = UIScreen.main.bounds.size
    
    let fullView: CGFloat = 100 // remainder of screen height
    var partialView: CGFloat {
        return UIScreen.main.bounds.height - 380
    }
    
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionViews()
        
        
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        self.view.addSubview(scrollView)
        
        // headerView
        self.headerView.backgroundColor = .clear
        self.headerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(headerView)
        self.headerView.addSubview(holdView)
        self.headerView.addSubview(pageControl)
        self.holdView.translatesAutoresizingMaskIntoConstraints = false
        self.pageControl.translatesAutoresizingMaskIntoConstraints = false
        self.pageControl.pageIndicatorTintColor = UIColor.lightGray
        self.pageControl.currentPageIndicatorTintColor = UIColor.black
        
        pageControl.numberOfPages = 3
        holdView.layer.cornerRadius = 3
        holdView.backgroundColor = UIColor.black
        
        // *** Autolayout header View / hold View / pageControl
        NSLayoutConstraint.activate([
            
            headerView.heightAnchor.constraint(equalToConstant: 40),
            headerView.widthAnchor.constraint(equalToConstant: self.view.frame.width),
            
            holdView.heightAnchor.constraint(equalToConstant: 5),
            holdView.widthAnchor.constraint(equalToConstant: 50),
            
            holdView.topAnchor.constraint(equalTo: pageControl.topAnchor, constant: 1),
            holdView.centerXAnchor.constraint(equalTo: self.headerView.centerXAnchor),
            
            pageControl.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 5),
            pageControl.centerXAnchor.constraint(equalTo: self.headerView.centerXAnchor)
            
            ])
        
        // *** Autolayout scrollView
        NSLayoutConstraint.activate([
            self.scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            self.scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        
        
        scrollView.contentSize = CGSize(width: 3.0 * screenSize.width,
                                        height: scrollView.frame.size.height)
        
        
        
        
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(StickerViewController.panGesture))
        gesture.delegate = self
        view.addGestureRecognizer(gesture)
        
        
        
    }
    
    func configureCollectionViews() {
        
        let frame = CGRect(x: 0,
                           y: 0,
                           width: UIScreen.main.bounds.width,
                           height: view.frame.height - 40)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        let width = (CGFloat) ((screenSize.width - 30) / 3.0)
        layout.itemSize = CGSize(width: width, height: 100)
        
        stickerCollectioView = UICollectionView(frame: frame, collectionViewLayout: layout)
        stickerCollectioView.backgroundColor = .clear
        scrollView.addSubview(stickerCollectioView)
        
        stickerCollectioView.delegate = self
        stickerCollectioView.dataSource = self
        
        
        self.stickerCollectioView.register(StickerCell.self, forCellWithReuseIdentifier: "cell")
        
        //-----------------------------------
        
        let emojisFrame = CGRect(x: scrollView.frame.size.width,
                                 y: 0,
                                 width: UIScreen.main.bounds.width,
                                 height: view.frame.height - 40)
        
        let emojislayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        emojislayout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        emojislayout.itemSize = CGSize(width: 60, height: 60)
        
        emojisCollectioView = UICollectionView(frame: emojisFrame, collectionViewLayout: emojislayout)
        emojisCollectioView.backgroundColor = .clear
        scrollView.addSubview(emojisCollectioView)
        emojisDelegate = EmojisCVDelegate()
        emojisDelegate.StickerEmojiDelegate = stickerDelegate
        emojisCollectioView.delegate = emojisDelegate
        emojisCollectioView.dataSource = emojisDelegate
        
        emojisCollectioView?.register(EmojiCell.self, forCellWithReuseIdentifier: "cell")
        
        
        //-----------------------------------
        
        let gifFrame = CGRect(x: scrollView.frame.size.width * 2,
                              y: 0,
                              width: UIScreen.main.bounds.width,
                              height: view.frame.height - 40)
        
        let giflayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        giflayout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        giflayout.itemSize = CGSize(width: 100, height: 100)
        
        gitCollectioView = UICollectionView(frame: gifFrame, collectionViewLayout: giflayout)
        gitCollectioView.backgroundColor = .clear
        scrollView.addSubview(gitCollectioView)
        gitCollectioView.delegate = self
        gitCollectioView.dataSource = self
        
        gitCollectioView?.register(GifCell.self, forCellWithReuseIdentifier: "cell")
        
        
        
        
    }
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareBackgroundView()
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.6) { [weak self] in
            guard let `self` = self else { return }
            let frame = self.view.frame
            let yComponent = self.partialView
            self.view.frame = CGRect(x: 0,
                                     y: yComponent,
                                     width: frame.width,
                                     height: UIScreen.main.bounds.height - self.partialView)
        }
    }
    
    override open func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        stickerCollectioView.frame = CGRect(x: 0,
                                            y: 0,
                                            width: UIScreen.main.bounds.width,
                                            height: view.frame.height - 40)
        
        emojisCollectioView.frame = CGRect(x: scrollView.frame.size.width,
                                           y: 0,
                                           width: UIScreen.main.bounds.width,
                                           height: view.frame.height - 40)
        
        gitCollectioView.frame = CGRect(x: scrollView.frame.size.width * 2,
                                        y: 0,
                                        width: UIScreen.main.bounds.width,
                                        height: view.frame.height - 40)
        
        scrollView.contentSize = CGSize(width: 3.0 * screenSize.width,
                                        height: scrollView.frame.size.height)
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Pan Gesture
    
    @objc func panGesture(_ recognizer: UIPanGestureRecognizer) {
        
        let translation = recognizer.translation(in: self.view)
        let velocity = recognizer.velocity(in: self.view)
        
        let y = self.view.frame.minY
        if y + translation.y >= fullView {
            let newMinY = y + translation.y
            self.view.frame = CGRect(x: 0, y: newMinY, width: view.frame.width, height: UIScreen.main.bounds.height - newMinY )
            self.view.layoutIfNeeded()
            recognizer.setTranslation(CGPoint.zero, in: self.view)
        }
        
        if recognizer.state == .ended {
            var duration =  velocity.y < 0 ? Double((y - fullView) / -velocity.y) : Double((partialView - y) / velocity.y )
            duration = duration > 1.3 ? 1 : duration
            //velocity is direction of gesture
            UIView.animate(withDuration: duration, delay: 0.0, options: [.allowUserInteraction], animations: {
                if  velocity.y >= 0 {
                    if y + translation.y >= self.partialView  {
                        self.removeBottomSheetView()
                    } else {
                        self.view.frame = CGRect(x: 0, y: self.partialView, width: self.view.frame.width, height: UIScreen.main.bounds.height - self.partialView)
                        self.view.layoutIfNeeded()
                    }
                } else {
                    if y + translation.y >= self.partialView  {
                        self.view.frame = CGRect(x: 0, y: self.partialView, width: self.view.frame.width, height: UIScreen.main.bounds.height - self.partialView)
                        self.view.layoutIfNeeded()
                    } else {
                        self.view.frame = CGRect(x: 0, y: self.fullView, width: self.view.frame.width, height: UIScreen.main.bounds.height - self.fullView)
                        self.view.layoutIfNeeded()
                    }
                }
                
            }, completion: nil)
        }
    }
    
    func removeBottomSheetView() {
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: UIView.AnimationOptions.curveEaseIn,
                       animations: { () -> Void in
                        var frame = self.view.frame
                        frame.origin.y = UIScreen.main.bounds.maxY
                        self.view.frame = frame
                        
        }, completion: { (finished) -> Void in
            self.view.removeFromSuperview()
            self.removeFromParent()
        })
    }
    
    func prepareBackgroundView(){
        let blurEffect = UIBlurEffect.init(style: .prominent)
        let visualEffect = UIVisualEffectView.init(effect: blurEffect)
        let bluredView = UIVisualEffectView.init(effect: blurEffect)
        bluredView.contentView.addSubview(visualEffect)
        visualEffect.frame = UIScreen.main.bounds
        bluredView.frame = UIScreen.main.bounds
        view.insertSubview(bluredView, at: 0)
    }
    
    
    
}

extension StickerViewController: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.bounds.width
        let pageFraction = scrollView.contentOffset.x / pageWidth
        self.pageControl.currentPage = Int(round(pageFraction))
    }
}

// MARK: - UICollectionViewDataSource
extension StickerViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == stickerCollectioView {
            return stickers.count
        } else {
            return gits.count
        }
        
    }
    
    
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "cell"
        if collectionView == stickerCollectioView {
            let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! StickerCell
            cell.stickerImage.image = UIImage(named: stickers[indexPath.row])
            
            
            
            return cell
        } else {
            
            let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! GifCell
            cell.gifImage.loadGif(name: gits[indexPath.row])
            return cell
        }
        
    }
    
    
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == stickerCollectioView {
            stickerDelegate?.StickerTapped(StickerName: stickers[indexPath.row])
        } else {
            stickerDelegate?.GitTapped(GifName: gits[indexPath.row])
        }
        
        
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
