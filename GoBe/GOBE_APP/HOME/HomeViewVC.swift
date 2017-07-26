//
//  HomeViewVC.swift
//  Gobo_Demo
//
//  Created by rlogical-dev-11 on 24/06/17.
//  Copyright © 2017 MM. All rights reserved.
//

import UIKit

class HomeViewVC: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource, SWTableViewCellDelegate, UIScrollViewDelegate,WebApiRequestDelegate
{
    
    //MARK:- Class Reference
    
    let web = Webservice()
    let HUD = MBProgressHUD()
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var mainScrl: UIScrollView!
    @IBOutlet var view_InsideScrollView: UIView!
    
    //for Header
    @IBOutlet weak var lbl_count: UILabel!
    
    
    //For New & Trending
    @IBOutlet var CollectionviewForNewTrending: UICollectionView?
    @IBOutlet var constraintNewTrending: NSLayoutConstraint!
    let reusableIdentifierNEWTRENDING = "NEWTRENDING"
    
    
    
    //For Following
    @IBOutlet var CollectionViewForFollowing: UICollectionView?
    @IBOutlet var constraintFollowing: NSLayoutConstraint!
    let reusableIdentifierFollowing = "FOLLOWING"
    
    
    //For Friends
    @IBOutlet var CollectionViewForFriends: UICollectionView?
    @IBOutlet var constraintFriends: NSLayoutConstraint!
    let reusableIdentifierFriends = "FRIENDS"
    
    
    
    //For YourLikes
    @IBOutlet weak var viewYourLikesHeader: UIView!
    @IBOutlet weak var constraintYorLikes: NSLayoutConstraint!
    @IBOutlet weak var tblYourLikes: UITableView!
    

    
    //For YourTips
    @IBOutlet weak var viewYourTipsHeader: UIView!
    @IBOutlet weak var constraintsYourTips: NSLayoutConstraint!
    @IBOutlet weak var tblYourTips: UITableView!
    
    
    //For YourLists
    @IBOutlet weak var viewYourListHeader: UIView!
    @IBOutlet weak var constraintsYourLists: NSLayoutConstraint!
    @IBOutlet weak var tblYourLists: UITableView!
    
    
    //For List You Like
    @IBOutlet weak var constraintsListYouLike: NSLayoutConstraint!
    @IBOutlet weak var tblListYouLike: UITableView!
    @IBOutlet weak var viewListYouLikeHeader: UIView!
    @IBOutlet var tblHeaderListYouLike: UIView!
    @IBOutlet weak var txtListYouLikeHeader: UITextField!

    
    
    
    //For FriendsList
    @IBOutlet weak var constraintsFriendsList: NSLayoutConstraint!
    @IBOutlet weak var constraintsPublicList: NSLayoutConstraint!
    @IBOutlet weak var tblFriendsList: UITableView!
    @IBOutlet weak var viewFriendsListHeader: UIView!
    @IBOutlet var tblHeaderFriendsList: UIView!
    @IBOutlet weak var txtFriendsHeader: UITextField!

    
    
    //For PublicLists
    @IBOutlet weak var tblPublicList: UITableView!
    @IBOutlet weak var viewPublicListsHeader: UIView!
    @IBOutlet weak var viewPublicListDetails: UIView!
    @IBOutlet var tblHeaderPublicList: UIView!
    @IBOutlet weak var txtPublicListHeader: UITextField!

    
    
    //MARK:- Variable
    var arr_NewTrending : NSMutableArray = []
    var arr_Following : NSMutableArray = []
    var arr_Friends : NSMutableArray = []
    var arr_YourLikes : NSMutableArray = []
    var arr_YourTips : NSMutableArray = []
    var arr_YourLists : NSMutableArray = []
    var arr_ListsYouLike : NSMutableArray = []
    var arr_FriendsList : NSMutableArray = []
    var arr_PublicList : NSMutableArray = []

    //filter Array
    var arr_ListsYouLikeFilter : NSMutableArray = []
    var arr_FriendsListFilter : NSMutableArray = []
    var arr_PublicListFilter : NSMutableArray = []

    
    var scrlYPos : Float = 0;
    var isSetAnimationFirstTime = Bool()
    var isYourLikes = Bool()
    var isYourTips = Bool()
    var isYourLists = Bool()
    var isListYouLike = Bool()
    var isFriendsList = Bool()
    var ispublicList = Bool()
    
    var isSearchingListYoulikes = Bool()
    var isSearchingFriendsList = Bool()
    var isSearchingPubliclist = Bool()

    
    let headerHeight_NT = 118
    let headerHeight_Following = 91
    let headerHeight_ALL = 108
    
    let HeaderDetailsHeight = 27
    
    let viewHeightForNewTrending : CGFloat = 272
    var viewHeightForFollowing : CGFloat = 615 //Change size
    var viewHeightForFriends : CGFloat = 615 // Change size
    
    //MARK:- Cell Highlights
    
    //N & T cell var
    var selectedIndex = Int ()
    var isselcted : Bool = false
    
    //following cell var
    var selectedIndexFollowing = Int ()
    var isselctedFollowing : Bool = false

    //following cell var
    var selectedIndexFriends = Int ()
    var isselctedFriends : Bool = false

    //YourLikes Cell var
    var selectedIndexYourLikes = Int ()
    var isselctedYourLikes : Bool = false

    //YourTips Cell var
    var selectedIndexYourTips = Int ()
    var isselctedYourTips : Bool = false

    //MARK:- Viewcontroller methods
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //Webservice Methods N & T........
        web.delegate = self
        self.view.addSubview(HUD)
        
        print("User ID: \(String(describing: appDel.instanceModelLogin.UserID))")
        
        
//        arr_Following = ["Value1","Value2","Value2","Value2","Value2","Value2","Value2"]
//        
//        arr_Friends = ["Value1","Value2","Value2","Value2"]
//        
        arr_YourLikes = ["Value1","Value2","Value2","Value2"]
//
//        arr_YourTips = ["Value1","Value2","Value2","Value2"]
//
//        arr_YourLists = ["Secret benches in many parks","Pub crawl in kennington","Weekend in Glasgow for a Southerner","Secret benches in perks around the world"]
//
//        arr_ListsYouLike = ["Secret benches in many parks","Another of my Lists","Pub crawl in kennington","Weekend in Glasgow for a Southerner","Secret benches in perks around the world"]
//
//        arr_FriendsList = ["Secret benches in many parks","Another of my Lists","Pub crawl in kennington","Weekend in Glasgow for a Southerner","Secret benches in Devon"]
//
//        arr_PublicList = ["Secret benches in many parks","Another of my Lists","Pub crawl in kennington","Weekend in Glasgow for a Southerner","Secret benches in Devon"]

        
        //For New & Trending
        
        self.currentPage = 0
        
        //For Following
        CollectionViewForFollowing?.delegate = self
        CollectionViewForFollowing?.dataSource = self
        CollectionViewForFollowing?.register(UINib.init(nibName: "Cell_Following", bundle: nil), forCellWithReuseIdentifier: reusableIdentifierFollowing)
        
        //For Friends
        CollectionViewForFriends?.delegate = self
        CollectionViewForFriends?.dataSource = self
        CollectionViewForFriends?.register(UINib.init(nibName: "Cell_Following", bundle: nil), forCellWithReuseIdentifier: reusableIdentifierFriends)
        
        
        //For Your Likes
        tblYourLikes.register(UINib(nibName: "YourLikesTableViewCell", bundle: nil), forCellReuseIdentifier: "YourLikesTableViewCell")

        //For Your Tips
        tblYourTips.register(UINib(nibName: "Cell_YourTips", bundle: nil), forCellReuseIdentifier: "Cell_YourTips")

        
        //For Your Lists
        tblYourLists.register(UINib(nibName: "Cell_YourList", bundle: nil), forCellReuseIdentifier: "Cell_YourList")
        
        
        //For Lists you Like
        tblListYouLike.register(UINib(nibName: "Cell_ListYouLike", bundle: nil), forCellReuseIdentifier: "Cell_ListYouLike")

        
        //For Friends List
        tblFriendsList.register(UINib(nibName: "Cell_FriendsList", bundle: nil), forCellReuseIdentifier: "Cell_FriendsList")
        
        
        //For Public List
        tblPublicList.register(UINib(nibName: "Cell_PublicList", bundle: nil), forCellReuseIdentifier: "Cell_PublicList")
        
        
        isSetAnimationFirstTime = true
       
        self.isHideAllSection()
        
        self.setupViews()
        self.TextfieldProperitiesSet()
        
    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        perform(#selector(getNewAndTrending), with: nil, afterDelay: 0.1)
        perform(#selector(HomescreenOtherSectionAPI), with: nil, afterDelay: 0.1)
        
        
        //Cell click Highlights Reload
        
        if isselcted == true
        {
            isselcted = false
            self.CollectionviewForNewTrending?.reloadData()

        }
        if isselctedFollowing == true
        {
            //following cell var
            isselctedFollowing = false
            self.CollectionViewForFollowing?.reloadData()

        }
        if isselctedFriends == true
        {
            isselctedFriends = false
            self.CollectionViewForFriends?.reloadData()

        }
        
        if isselctedYourLikes == true
        {
            isselctedYourLikes = false
            self.tblYourLikes?.reloadData()
            
        }
        if isselctedYourTips == true
        {
            isselctedYourTips = false
            self.tblYourTips?.reloadData()
            
        }

    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)

    }
    
    //MARK:- Setup view
    func setupViews() -> Void
    {
        var CustomHeight = 0
        
        CollectionviewForNewTrending?.reloadData()
        //For New & Trending
        CustomHeight = CustomHeight + headerHeight_NT
        
        if arr_NewTrending.count == 0
        {
            CustomHeight = CustomHeight + headerHeight_NT
            constraintNewTrending.constant = 0
        }
        else
        {
            constraintNewTrending.constant = viewHeightForNewTrending
            CustomHeight = CustomHeight + headerHeight_NT + Int(viewHeightForNewTrending)
        }
        CollectionviewForNewTrending?.reloadData()
        
        
        //For Following
        CollectionViewForFollowing?.reloadData()
        if arr_Following.count == 0
        {
            CustomHeight = CustomHeight + headerHeight_Following
            constraintFollowing.constant = 0
        }
        else
        {
            if arr_Following.count >= 7
            {
                var frame : CGRect! = self.CollectionViewForFollowing?.frame
                frame.origin.x = 0;
                frame.origin.y = CGFloat(HeaderDetailsHeight)
                frame.size.width = Constants.WIDTH
                frame.size.height = viewHeightForFollowing
                
                self.CollectionViewForFollowing?.frame = frame
                
                constraintFollowing.constant = viewHeightForFollowing + CGFloat(HeaderDetailsHeight)
                CustomHeight = CustomHeight + headerHeight_Following + HeaderDetailsHeight + Int(CustomHeight)
            }
            else
            {
                //Find Content size and display
                let newHeight : CGFloat = (self.CollectionViewForFollowing?.collectionViewLayout.collectionViewContentSize.height)!
                
                var frame : CGRect! = self.CollectionViewForFollowing!.frame
                
                frame.origin.x = 0;
                frame.origin.y = CGFloat(HeaderDetailsHeight)
                frame.size.width = Constants.WIDTH
                frame.size.height = newHeight
                
                self.CollectionViewForFollowing?.frame = frame
                
                self.constraintFollowing.constant = newHeight + CGFloat(HeaderDetailsHeight)
                CustomHeight = CustomHeight + headerHeight_Following + HeaderDetailsHeight + Int(newHeight)
            }
        }
        CollectionViewForFollowing?.reloadData()
        
        
        //For Friend
        CollectionViewForFriends?.reloadData()
        if arr_Friends.count == 0
        {
            CustomHeight = CustomHeight + headerHeight_ALL
            constraintFriends.constant = 0
        }
        else
        {
            if arr_Friends.count >= 7
            {
                var frame : CGRect! = self.CollectionViewForFollowing!.frame
                frame.origin.x = 0;
                frame.origin.y = CGFloat(HeaderDetailsHeight)
                frame.size.width = Constants.WIDTH
                frame.size.height = viewHeightForFollowing
                
                self.CollectionViewForFollowing?.frame = frame
                
                constraintFriends.constant = viewHeightForFriends + CGFloat(HeaderDetailsHeight)
                CustomHeight = CustomHeight + headerHeight_ALL + HeaderDetailsHeight + Int(viewHeightForFriends)
            }
            else
            {
                //Find Friend Size and display
                let newHeight : CGFloat = self.CollectionViewForFriends!.collectionViewLayout.collectionViewContentSize.height
                
                var frame : CGRect! = self.CollectionViewForFriends!.frame
                
                frame.origin.x = 0;
                frame.origin.y = CGFloat(HeaderDetailsHeight)
                frame.size.width = Constants.WIDTH
                frame.size.height = newHeight
                
                self.CollectionViewForFriends?.frame = frame
                
                self.constraintFriends.constant = newHeight + CGFloat(HeaderDetailsHeight)
                CustomHeight = CustomHeight + headerHeight_ALL + HeaderDetailsHeight + Int(newHeight)
                
            }
        }
        CollectionViewForFriends?.reloadData()
        
        
        //For Your Likes
        if isYourLikes
        {
            if arr_YourLikes.count == 0
            {
                CustomHeight = CustomHeight + headerHeight_ALL
                constraintYorLikes.constant = 0.0
            }
            else
            {
                let tblHeight = CGFloat(arr_YourLikes.count * 120)
                
                tblYourLikes.frame = CGRect(x: 0, y: CGFloat(HeaderDetailsHeight), width:self.view.frame.size.width, height: tblHeight)
                constraintYorLikes.constant = tblHeight;
                CustomHeight = CustomHeight + headerHeight_ALL + HeaderDetailsHeight + Int(tblHeight)
            }
        }
        else
        {
            CustomHeight = CustomHeight + headerHeight_ALL
            constraintYorLikes.constant = 0.0
        }
        tblYourLikes.reloadData()
        
        
        //Your Tips
        if isYourTips
        {
            if arr_YourTips.count == 0
            {
                CustomHeight = CustomHeight + headerHeight_ALL
                constraintsYourTips.constant = 0.0
            }
            else
            {
                let tblHeight = CGFloat(arr_YourTips.count * 120)
                
                tblYourTips.frame = CGRect(x: 0, y: CGFloat(HeaderDetailsHeight), width:self.view.frame.size.width, height: tblHeight)
                constraintsYourTips.constant = tblHeight;
                CustomHeight = CustomHeight  + headerHeight_ALL + HeaderDetailsHeight +  Int(tblHeight)
            }
        }
        else
        {
            CustomHeight = CustomHeight + headerHeight_ALL
            constraintsYourTips.constant = 0.0
        }
        tblYourTips.reloadData()
        
        
        //Your Lists
        if isYourLists
        {
            if arr_YourLists.count == 0
            {
                CustomHeight = CustomHeight + headerHeight_ALL
                constraintsYourLists.constant = 0.0
            }
            else
            {
                let tblHeight = CGFloat(arr_YourLists.count * 60)
                
                tblYourLists.frame = CGRect(x: 0, y: CGFloat(HeaderDetailsHeight), width:self.view.frame.size.width, height: tblHeight)
                constraintsYourLists.constant = tblHeight;
                CustomHeight = CustomHeight  + headerHeight_ALL + HeaderDetailsHeight +  Int(tblHeight)
            }
        }
        else
        {
            CustomHeight = CustomHeight + headerHeight_ALL
            constraintsYourLists.constant = 0.0
        }
        tblYourLists.reloadData()
        
        
        //Lists You Like
        if isListYouLike
        {
            if arr_ListsYouLike.count == 0
            {
                CustomHeight = CustomHeight + headerHeight_ALL
                constraintsListYouLike.constant = 0.0
            }
            else
            {
                let tblHeight = CGFloat(arr_ListsYouLike.count * 60) + tblHeaderListYouLike.frame.size.height
                
                tblListYouLike.frame = CGRect(x: 0, y: CGFloat(HeaderDetailsHeight), width:self.view.frame.size.width, height: tblHeight)
                constraintsListYouLike.constant = tblHeight;
                CustomHeight = CustomHeight  + headerHeight_ALL + HeaderDetailsHeight +  Int(tblHeight)
            }
        }
        else
        {
            CustomHeight = CustomHeight + headerHeight_ALL
            constraintsListYouLike.constant = 0.0
        }
        tblListYouLike.reloadData()
        
        //Friends Lists
        if isFriendsList
        {
            if arr_FriendsList.count == 0
            {
                CustomHeight = CustomHeight + headerHeight_ALL
                constraintsFriendsList.constant = 0.0
            }
            else
            {
                let tblHeight = CGFloat(arr_FriendsList.count * 60) + tblHeaderFriendsList.frame.size.height
                
                tblFriendsList.frame = CGRect(x: 0, y: CGFloat(HeaderDetailsHeight), width:self.view.frame.size.width, height: tblHeight)
                constraintsFriendsList.constant = tblHeight;
                CustomHeight = CustomHeight  + headerHeight_ALL + HeaderDetailsHeight +  Int(tblHeight)
            }
        }
        else
        {
            CustomHeight = CustomHeight + headerHeight_ALL
            constraintsFriendsList.constant = 0.0
        }
        tblFriendsList.reloadData()
        
        
        //Public Lists
        if ispublicList
        {
            if arr_PublicList.count == 0
            {
                CustomHeight = CustomHeight + headerHeight_ALL
                constraintsPublicList.constant = 0.0
                viewPublicListDetails.frame = CGRect(x: 0, y: CustomHeight, width: Int(self.view.frame.size.width), height: 0)
            }
            else
            {
                let tblHeight = CGFloat(arr_PublicList.count * 60) + tblHeaderPublicList.frame.size.height
                
                tblPublicList.frame = CGRect(x: 0, y: CGFloat(HeaderDetailsHeight), width:self.view.frame.size.width, height: tblHeight)
                constraintsPublicList.constant = tblHeight;
                CustomHeight = CustomHeight  + headerHeight_ALL + HeaderDetailsHeight +  Int(tblHeight)
                
                viewPublicListDetails.frame = CGRect(x: 0, y: CustomHeight, width: Int(self.view.frame.size.width), height: Int(tblHeight))
            }
        }
        else
        {
            CustomHeight = CustomHeight + headerHeight_ALL
            constraintsPublicList.constant = 0.0
            viewPublicListDetails.frame = CGRect(x: 0, y: CustomHeight, width: Int(self.view.frame.size.width), height: 0)
        }
        
        tblPublicList.reloadData()
        
        
        //self.viewPublicListsHeader.updateConstraints()
        //self.view_InsideScrollView.updateConstraints()
        
        
        if isSetAnimationFirstTime
        {
            isSetAnimationFirstTime = false
            
            self.view_InsideScrollView.frame = CGRect(x: 0, y: self.view_InsideScrollView.frame.origin.y, width: self.view.frame.size.width, height: CGFloat(CustomHeight))
            self.mainScrl.contentSize = CGSize(width: self.view_InsideScrollView.frame.size.width, height: CGFloat(CustomHeight))
            
        }
        else
        {
            self.view_InsideScrollView.frame = CGRect(x: 0, y: self.view_InsideScrollView.frame.origin.y, width: self.view.frame.size.width, height: CGFloat(CustomHeight))
            self.mainScrl.contentSize = CGSize(width: self.view_InsideScrollView.frame.size.width, height: CGFloat(CustomHeight))
            
            //self.mainScrl.contentOffset = CGPoint(x: CGFloat(0), y: CGFloat(self.scrlYPos))
            
        }
        
    }
    
    func TextfieldProperitiesSet()
    {
        txtListYouLikeHeader.attributedPlaceholder = NSAttributedString(string: "Search for a List title",                                                                 attributes: [NSForegroundColorAttributeName: Constants.hexStringToUIColor(hex: "#636363")])
        txtPublicListHeader.attributedPlaceholder = NSAttributedString(string: "Search List title or Friend’s name", attributes: [NSForegroundColorAttributeName: Constants.hexStringToUIColor(hex: "#636363")])
        txtFriendsHeader.attributedPlaceholder = NSAttributedString(string: "Search List title or Friend’s name",                                                                 attributes: [NSForegroundColorAttributeName: Constants.hexStringToUIColor(hex: "#636363")])
    }

    //MARK:- iCarousel Delegate and Delegate
    fileprivate var items = [Character]()
    
    fileprivate var currentPage: Int = 0
    {
        didSet
        {
            //let character = self.items[self.currentPage]
        }
    }
    
    fileprivate var pageSize: CGSize
    {
        let layout = CollectionviewForNewTrending?.collectionViewLayout as! UPCarouselFlowLayout
        var pageSize = layout.itemSize
        if layout.scrollDirection == .horizontal
        {
            pageSize.width += layout.minimumLineSpacing
        }
        else
        {
            pageSize.height += layout.minimumLineSpacing
        }
        return pageSize
    }
    
    fileprivate var orientation: UIDeviceOrientation
    {
        return UIDevice.current.orientation
    }
    
    fileprivate func setupLayout()
    {
        let layout = CollectionviewForNewTrending?.collectionViewLayout as! UPCarouselFlowLayout
        layout.spacingMode = UPCarouselFlowLayoutSpacingMode.overlap(visibleOffset: 30)
    }
    
    @IBAction func friendsFollowinfTapped(_ sender: Any)
    {
        let move = self.storyboard?.instantiateViewController(withIdentifier: "Friends_FollowersViewController") as! Friends_FollowersViewController
        self.navigationController?.pushViewController(move, animated: true)
    }
    
    //MARK:- UICollectionview Delegate and Datasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        if collectionView == CollectionviewForNewTrending {
            
//            print(arr_NewTrending.count)
            return arr_NewTrending.count
            
        }else if collectionView == CollectionViewForFollowing {
//            print(arr_Following.count)
            return arr_Following.count
            
        }else {
            
            return arr_Friends.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == CollectionviewForNewTrending {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCollectionViewCell.identifier, for: indexPath) as! CarouselCollectionViewCell
            
            let dict_Cell = arr_NewTrending.object(at: indexPath.row) as? NSDictionary
            
            cell.imgActivityIndicator.stopAnimating()
            if let strImageUrl = dict_Cell?.value(forKey: "Thumb") as? String{
                
                cell.imgActivityIndicator.startAnimating()
                cell.image.sd_setImage(with: URL(string:strImageUrl), placeholderImage: UIImage(named: "placeholder.png"), options: .refreshCached, completed: { (image, error, cacheType, url) -> Void in
                    
                    cell.imgActivityIndicator.stopAnimating()
                })
            }
            
            if let strTitleName = dict_Cell?.value(forKey: "Title") as? String{
                
                cell.lbl_eventTitle.text = strTitleName
                
                cell.lbl_eventTitle.textContainerInset = UIEdgeInsets.zero
                cell.lbl_eventTitle.textContainer.lineFragmentPadding = 0
            }
            if let strDetails = dict_Cell?.value(forKey: "Description") as? String{
                
                cell.lbl_eventDetails.text = strDetails
            }
            if let strAuthorName = dict_Cell?.value(forKey: "AuthorName") as? String{
                
                cell.lbl_authorName.text = strAuthorName
            }
            if isselcted == true
            {
                if selectedIndex == indexPath.row
                {
                    cell.Cell_backgroundImge.image = UIImage(named:"NT box hit.png")
                }
                else
                {
                    cell.Cell_backgroundImge.image = UIImage(named:"NT box.png")
                }
            }
            else{
                cell.Cell_backgroundImge.image = UIImage(named:"NT box.png")
            }
            return cell
        }
        
        else if collectionView == CollectionViewForFollowing
        {
            let cell : Cell_Following? = collectionView.dequeueReusableCell(withReuseIdentifier: reusableIdentifierFollowing, for: indexPath) as? Cell_Following
            
            let dict_Following = arr_Following.object(at: indexPath.row) as? NSDictionary
            
            cell?.activity_indi.stopAnimating()
            if let strImageUrl = dict_Following?.value(forKey: "Thumb") as? String{
                
                cell?.activity_indi.startAnimating()
                cell?.img_Picture.sd_setImage(with: URL(string:strImageUrl), placeholderImage: UIImage(named: "placeholder.png"), options: .refreshCached, completed: { (image, error, cacheType, url) -> Void in
                    
                    cell?.activity_indi.stopAnimating()
                })
            }
            if let strTitleName = dict_Following?.value(forKey: "Title") as? String{
                
                cell?.lblHeader.text = strTitleName
            }
            if let strDetails = dict_Following?.value(forKey: "AuthorName") as? String{
                
                cell?.lblName.text = strDetails
            }

            if isselctedFollowing == true
            {
                if selectedIndexFollowing == indexPath.row
                {
                    cell?.img_background.image = UIImage(named:"NT box hit.png")
                }
                else
                {
                    cell?.img_background.image = UIImage(named:"NT box.png")
                }
            }
            else{
                cell?.img_background.image = UIImage(named:"NT box.png")
            }

            return cell!
        }
        else
        {
            let cell : Cell_Following? = collectionView.dequeueReusableCell(withReuseIdentifier: reusableIdentifierFriends, for: indexPath) as? Cell_Following
            
            let dict_Friends = arr_Friends.object(at: indexPath.row) as? NSDictionary
            
            cell?.activity_indi.stopAnimating()
            if let strImageUrl = dict_Friends?.value(forKey: "Thumb") as? String{
                
                cell?.activity_indi.startAnimating()
                cell?.img_Picture.sd_setImage(with: URL(string:strImageUrl), placeholderImage: UIImage(named: "placeholder.png"), options: .refreshCached, completed: { (image, error, cacheType, url) -> Void in
                    
                    cell?.activity_indi.stopAnimating()
                })
            }
            if let strTitleName = dict_Friends?.value(forKey: "Title") as? String{
                
                cell?.lblHeader.text = strTitleName
            }
            if let strDetails = dict_Friends?.value(forKey: "AuthorName") as? String{
                
                cell?.lblName.text = strDetails
            }

            if isselctedFriends == true
            {
                if selectedIndexFriends == indexPath.row
                {
                    cell?.img_background.image = UIImage(named:"NT box hit.png")
                }
                else
                {
                    cell?.img_background.image = UIImage(named:"NT box.png")
                }
            }
            else{
                cell?.img_background.image = UIImage(named:"NT box.png")
            }

            return cell!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        var height : CGFloat = 0
        var width : CGFloat = 0
        
        if collectionView == CollectionviewForNewTrending {
            width = 196
            height = 272
            
        }else if collectionView == CollectionViewForFollowing {
            //width = 138
            width = (collectionView.frame.size.width/2) - 22
            height = 195
            
        }else{
            
            //width = 138
            width = (collectionView.frame.size.width/2) - 22
            height = 195
        }
        
        let size:CGSize = CGSize(width: width, height: height)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == CollectionviewForNewTrending {
            
            let cell = collectionView.cellForItem(at: indexPath) as! CarouselCollectionViewCell
            cell.isSelected = true
            cell.Cell_backgroundImge.image = UIImage(named:"NT box hit.png")
            selectedIndex = indexPath.row
            self.CollectionviewForNewTrending?.reloadData()
            isselcted = true
            let move :NewtrendsDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "NewtrendsDetailsViewController") as! NewtrendsDetailsViewController
            move.arrTipsListData = arr_NewTrending
            move.intStartIndex = indexPath.row
            
            self.navigationController?.pushViewController(move, animated: true)
            
        }else if collectionView == CollectionViewForFollowing {
            
            let cell = collectionView.cellForItem(at: indexPath) as! Cell_Following
            cell.img_background.image = UIImage(named:"NT box hit.png")
            selectedIndexFollowing = indexPath.row
            self.CollectionViewForFollowing?.reloadData()
            isselctedFollowing = true
            let move = self.storyboard?.instantiateViewController(withIdentifier: "NewtrendsDetailsViewController") as! NewtrendsDetailsViewController
            move.arrTipsListData = arr_Following
            move.intStartIndex = indexPath.row
            
            self.navigationController?.pushViewController(move, animated: true)
            
        }else{
            
            let cell = collectionView.cellForItem(at: indexPath) as! Cell_Following
            cell.img_background.image = UIImage(named:"NT box hit.png")
            selectedIndexFriends = indexPath.row
            self.CollectionViewForFriends?.reloadData()
            isselctedFriends = true

            let move = self.storyboard?.instantiateViewController(withIdentifier: "NewtrendsDetailsViewController") as! NewtrendsDetailsViewController
            move.arrTipsListData = arr_Friends
            move.intStartIndex = indexPath.row
            self.navigationController?.pushViewController(move, animated: true)
        }
    }
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        /*
        let layout = CollectionviewForNewTrending.collectionViewLayout as! UPCarouselFlowLayout
        let pageSide = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
        let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
        currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
        */
    }
    
    // MARK: - UITableview Datasurce And Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == tblYourLikes {
            
            print(arr_YourLikes.count)
            return arr_YourLikes.count
        }else if tableView == tblYourTips {
            
            return arr_YourTips.count
        }else if tableView == tblYourLists {
            
            return arr_YourLists.count
        }else if tableView == tblListYouLike {
            
            if isSearchingListYoulikes == true {
                
                return arr_ListsYouLikeFilter.count
            }else{
                
                return arr_ListsYouLike.count
            }
            
        }else if tableView == tblFriendsList {
            
            if isSearchingFriendsList == true {
                
                return arr_FriendsListFilter.count
            }else{
                
                return arr_FriendsList.count
            }
            
        }else if tableView == tblPublicList {
            
            if isSearchingPubliclist == true {
                
                return arr_PublicListFilter.count
            }
            else{
                
                return arr_PublicList.count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if tableView == tblListYouLike {
            
            return tblHeaderListYouLike.frame.size.height
        }else if tableView == tblFriendsList {
            
            return tblHeaderFriendsList.frame.size.height
        }else if tableView == tblPublicList{
            
            return tblHeaderPublicList.frame.size.height
        }else{
            
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if tableView == tblListYouLike {
            
            return tblHeaderListYouLike
        }else if tableView == tblFriendsList {
            
            return tblHeaderFriendsList
        }else if tableView == tblPublicList {
            
            return tblHeaderPublicList
        }else{
            
            let headerVw = UIView(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(Constants.WIDTH), height: CGFloat(0)))
            headerVw.backgroundColor = UIColor.clear
         
            return headerVw
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        if tableView == tblYourLikes {
            
            var dcell: YourLikesTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "YourLikesTableViewCell", for: indexPath as IndexPath) as? YourLikesTableViewCell
            
            if (dcell == nil){
                
                if dcell == nil {
                    var topLevelObjects: [Any] = Bundle.main.loadNibNamed("YourLikesTableViewCell", owner: self, options: nil)!
                    dcell = topLevelObjects[0] as? YourLikesTableViewCell
                }
            }
            
            let dict_YourLikes = arr_YourLikes.object(at: indexPath.row) as? NSDictionary
            
            if let strImageUrl = dict_YourLikes?.value(forKey: "Thumb") as? String{
                
                dcell?.img_activityIndi.startAnimating()
                dcell?.imgPicture.sd_setImage(with: URL(string:strImageUrl), placeholderImage: UIImage(named: "placeholder.png"), options: .refreshCached, completed: { (image, error, cacheType, url) -> Void in
                    
                    dcell?.img_activityIndi.stopAnimating()
                })
            }
            
            if let strTitleName = dict_YourLikes?.value(forKey: "Title") as? String{
                
                dcell?.lblHeader.text = strTitleName
            }
            if let strDescription = dict_YourLikes?.value(forKey: "Description") as? String{
                
                dcell?.lblDescription.text = strDescription
            }
            
            if let strAutherID = dict_YourLikes?.value(forKey: "AuthorID") as? String{
                
                //If this Tips is created by me OR not
                if strAutherID == appDel.instanceModelLogin.UserID {
                    
                    dcell?.lblName.text = "by You"
                }else{
                    if let strlblName = dict_YourLikes?.value(forKey: "AuthorName") as? String{
                        dcell?.lblName.text = strlblName
                    }
                }
            }
            

            if isselctedYourLikes == true
            {
                if selectedIndexYourLikes == indexPath.row
                {
                    dcell?.backgroungImgView.image = UIImage(named:"NT box hit")
                }
                else
                {
                    dcell?.backgroungImgView.image = UIImage(named:"NT box")
                }
            }
            else
            {
                dcell?.backgroungImgView.image = UIImage(named:"NT box")
            }
            // Load the top-level objects from the custom cell XIB.
            dcell?.setLeftUtilityButtons(leftButtons(tableView,indexpath: indexPath), withButtonWidth: 40.0)
            dcell?.setRightUtilityButtons(rightbuttons(tableView,indexpath: indexPath), withButtonWidth: 40.0)
            dcell?.delegate = self
            dcell?.selectionStyle = .none
            
            return dcell!
            
        }else if tableView == tblYourTips{
            
            var dcell: Cell_YourTips? = tableView.dequeueReusableCell(withIdentifier: "Cell_YourTips", for: indexPath as IndexPath) as? Cell_YourTips
            
            if (dcell == nil)
            {
                if dcell == nil {
                    // Load the top-level objects from the custom cell XIB.
                    var topLevelObjects: [Any] = Bundle.main.loadNibNamed("Cell_YourTips", owner: self, options: nil)!
                    // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
                    dcell = topLevelObjects[0] as? Cell_YourTips
                }
            }
            
            let dict_YourTips = arr_YourTips.object(at: indexPath.row) as? NSDictionary
            
            if let strImageUrl = dict_YourTips?.value(forKey: "Thumb") as? String{
                
                dcell?.img_activityIndi.startAnimating()
                
                dcell?.imgPicture.sd_setImage(with: URL(string:strImageUrl), placeholderImage: UIImage(named: "placeholder.png"), options: .refreshCached, completed: { (image, error, cacheType, url) -> Void in
                    
                    dcell?.img_activityIndi.stopAnimating()
                })
            }
            if let strTitleName = dict_YourTips?.value(forKey: "Title") as? String{
                dcell?.lblHeader.text = strTitleName
            }
            if let strDescription = dict_YourTips?.value(forKey: "Description") as? String{
                dcell?.lblDescription.text = strDescription
            }
            if let strlblName = dict_YourTips?.value(forKey: "AuthorName") as? String{
                dcell?.lblName.text = strlblName
            }

            if isselctedYourTips == true{
                if selectedIndexYourTips == indexPath.row{
                    
                    dcell?.backgroundImg.image = UIImage(named:"NT box hit")
                }else{
                    dcell?.backgroundImg.image = UIImage(named:"NT box")
                }
                
            }else{
                
                dcell?.backgroundImg.image = UIImage(named:"NT box")
            }
            
            // Load the top-level objects from the custom cell XIB.
            dcell?.setLeftUtilityButtons(leftButtons(tableView,indexpath: indexPath), withButtonWidth: 40.0)
            dcell?.setRightUtilityButtons(rightbuttons(tableView,indexpath: indexPath), withButtonWidth: 40.0)
            dcell?.delegate = self
            dcell?.selectionStyle = .none
            dcell?.tag = indexPath.row
            
           // dcell?.view_LeftMenu.isHidden = true
           // dcell?.view_RightMenu.isHidden = true

            return dcell!
        }
        else if tableView == tblYourLists
        {
            var dcell: Cell_YourList? = tableView.dequeueReusableCell(withIdentifier: "Cell_YourList", for: indexPath as IndexPath) as? Cell_YourList
            
            if (dcell == nil)
            {
                if dcell == nil {
                    // Load the top-level objects from the custom cell XIB.
                    var topLevelObjects: [Any] = Bundle.main.loadNibNamed("Cell_YourList", owner: self, options: nil)!
                    // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
                    dcell = topLevelObjects[0] as? Cell_YourList
                }
            }
            dcell?.setLeftUtilityButtons(leftButtons(tableView,indexpath: indexPath), withButtonWidth: 40.0)
            dcell?.setRightUtilityButtons(rightbuttons(tableView,indexpath: indexPath), withButtonWidth: 40.0)
            dcell?.delegate = self
            dcell?.selectionStyle = .none
            
            let dict_YourLists = arr_YourLists.object(at: indexPath.row) as? NSDictionary
            
            if let strTitleName = dict_YourLists?.value(forKey: "ListName") as? String{
                
                dcell?.lblTitle.text = strTitleName
            }
            if let permissionStatus = dict_YourLists?.value(forKey: "PermissionStatus") as? String{
                
                if permissionStatus == "public"
                {
                    dcell?.img_permissionStatus.isHidden = true
                }
                else if permissionStatus == "private"{
                    
                    dcell?.img_permissionStatus.isHidden = false

                    dcell?.img_permissionStatus.image = UIImage(named:"public can")
                }
                else{
                    dcell?.img_permissionStatus.isHidden = false

                    dcell?.img_permissionStatus.image = UIImage(named:"friends can")
                }
            }

            return dcell!
        }
        else if tableView == tblListYouLike
        {
            var dcell: Cell_ListYouLike? = tableView.dequeueReusableCell(withIdentifier: "Cell_ListYouLike", for: indexPath as IndexPath) as? Cell_ListYouLike
            
            if (dcell == nil)
            {
                if dcell == nil {
                    // Load the top-level objects from the custom cell XIB.
                    var topLevelObjects: [Any] = Bundle.main.loadNibNamed("Cell_ListYouLike", owner: self, options: nil)!
                    // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
                    dcell = topLevelObjects[0] as? Cell_ListYouLike
                }
            }
            dcell?.setLeftUtilityButtons(leftButtons(tableView,indexpath: indexPath), withButtonWidth: 40.0)
            dcell?.setRightUtilityButtons(rightbuttons(tableView,indexpath: indexPath), withButtonWidth: 40.0)
            dcell?.delegate = self
            dcell?.selectionStyle = .none
            
            let dict_ListsYouLike : NSDictionary?
            
            if isSearchingListYoulikes == true
            {
                dict_ListsYouLike = arr_ListsYouLikeFilter.object(at: indexPath.row) as? NSDictionary
            }else{
                dict_ListsYouLike = arr_ListsYouLike.object(at: indexPath.row) as? NSDictionary
            }
                
            if let strTitleName = dict_ListsYouLike?.value(forKey: "ListName") as? String{
                
                dcell?.lblTitle.text = strTitleName
            }
            if let strTitleName = dict_ListsYouLike?.value(forKey: "AuthorName") as? String{
                
                dcell?.lbl_byYou.text = strTitleName
            }
            if let permissionStatus = dict_ListsYouLike?.value(forKey: "PermissionStatus") as? String{
                
                if permissionStatus == "public"
                {
                    dcell?.img_permissionStatus.isHidden = true
                }
                else if permissionStatus == "private"{
                    
                    dcell?.img_permissionStatus.isHidden = false
                    
                    dcell?.img_permissionStatus.image = UIImage(named:"public can")
                }
                else{
                    dcell?.img_permissionStatus.isHidden = false
                    
                    dcell?.img_permissionStatus.image = UIImage(named:"friends can")
                }
            }

            return dcell!
        }
        else if tableView == tblFriendsList
        {
            var dcell: Cell_FriendsList? = tableView.dequeueReusableCell(withIdentifier: "Cell_FriendsList", for: indexPath as IndexPath) as? Cell_FriendsList
            
            if (dcell == nil)
            {
                if dcell == nil {
                    // Load the top-level objects from the custom cell XIB.
                    var topLevelObjects: [Any] = Bundle.main.loadNibNamed("Cell_FriendsList", owner: self, options: nil)!
                    // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
                    dcell = topLevelObjects[0] as? Cell_FriendsList
                }
            }
            dcell?.setLeftUtilityButtons(leftButtons(tableView,indexpath: indexPath), withButtonWidth: 40.0)
            dcell?.setRightUtilityButtons(rightbuttons(tableView,indexpath: indexPath), withButtonWidth: 40.0)
            dcell?.delegate = self
            dcell?.selectionStyle = .none
            
            let dict_FriendsList : NSDictionary?
            
            if isSearchingFriendsList == true
            {
                dict_FriendsList = arr_FriendsListFilter.object(at: indexPath.row) as? NSDictionary
            }else{
                dict_FriendsList = arr_FriendsList.object(at: indexPath.row) as? NSDictionary
            }
            
            
            if let strTitleName = dict_FriendsList?.value(forKey: "ListName") as? String{
                
                dcell?.lblTitle.text = strTitleName
            }
            if let strAuthorName = dict_FriendsList?.value(forKey: "AuthorName") as? String{
                
                dcell?.lbl_authorName.text = strAuthorName
            }
            
            if let permissionStatus = dict_FriendsList?.value(forKey: "PermissionStatus") as? String{
                
                if permissionStatus == "public"
                {
                    dcell?.img_permissionStatus.isHidden = true
                }
                else if permissionStatus == "private"{
                    
                    dcell?.img_permissionStatus.isHidden = false
                    dcell?.img_permissionStatus.image = UIImage(named:"public can")
                    
                }else{
                    
                    dcell?.img_permissionStatus.isHidden = false
                    dcell?.img_permissionStatus.image = UIImage(named:"friends can")
                }
            }
            
            return dcell!
        }
        else if tableView == tblPublicList
        {
            var dcell: Cell_PublicList? = tableView.dequeueReusableCell(withIdentifier: "Cell_PublicList", for: indexPath as IndexPath) as? Cell_PublicList
            
            if (dcell == nil)
            {
                if dcell == nil {
                    // Load the top-level objects from the custom cell XIB.
                    var topLevelObjects: [Any] = Bundle.main.loadNibNamed("Cell_PublicList", owner: self, options: nil)!
                    // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
                    dcell = topLevelObjects[0] as? Cell_PublicList
                }
            }
            dcell?.setLeftUtilityButtons(leftButtons(tableView, indexpath: indexPath), withButtonWidth: 40.0)
            dcell?.setRightUtilityButtons(rightbuttons(tableView,indexpath: indexPath), withButtonWidth: 40.0)
            dcell?.delegate = self
            dcell?.selectionStyle = .none
            
            let dict_PublicList : NSDictionary?
            
            
            if isSearchingPubliclist == true
            {
                dict_PublicList = arr_PublicListFilter.object(at: indexPath.row) as? NSDictionary
                
            }else{
                
                dict_PublicList = arr_PublicList.object(at: indexPath.row) as? NSDictionary
            }
                
            if let strTitleName = dict_PublicList?.value(forKey: "ListName") as? String{
                
                dcell?.lblTitle.text = strTitleName
            }
            if let strAuthorName = dict_PublicList?.value(forKey: "AuthorName") as? String{
                
                dcell?.lbl_authorName.text = strAuthorName
            }
            
            if let permissionStatus = dict_PublicList?.value(forKey: "PermissionStatus") as? String{
                
                if permissionStatus == "public"
                {
                    dcell?.img_permissionStatus.isHidden = true
                }
                else if permissionStatus == "private"{
                    
                    dcell?.img_permissionStatus.isHidden = false
                    dcell?.img_permissionStatus.image = UIImage(named:"public can")
                    
                }
                else{
                    
                    dcell?.img_permissionStatus.isHidden = false
                    dcell?.img_permissionStatus.image = UIImage(named:"friends can")
                }
            }
            
            return dcell!
        }
        else
        {
            let dcell: YourLikesTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "YourLikesTableViewCell", for: indexPath as IndexPath) as? YourLikesTableViewCell
            
            dcell?.selectionStyle = .none
            return dcell!
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if tableView == tblYourLikes{
            return 120
        }else if tableView == tblYourTips{
            return 120
        }else if tableView == tblYourLists{
            return 60
        }else if tableView == tblListYouLike{
            return 60
        }else if tableView == tblFriendsList{
            return 60
        }else if tableView == tblPublicList{
            return 60
        }
        return 0
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if tableView == tblYourLikes{
            
            let cell = tableView.cellForRow(at:indexPath) as! YourLikesTableViewCell

            cell.backgroungImgView.image = UIImage(named:"NT box hit.png")
            selectedIndexYourLikes = indexPath.row
            isselctedYourLikes = true
            self.tblYourLikes.reloadData()

            let move = self.storyboard?.instantiateViewController(withIdentifier: "NewtrendsDetailsViewController") as! NewtrendsDetailsViewController
            move.arrTipsListData = arr_YourLikes
            move.intStartIndex = indexPath.row
            
            self.navigationController?.pushViewController(move, animated: true)
            
        }else if tableView == tblYourTips{
            
            let cell = tableView.cellForRow(at:indexPath) as! Cell_YourTips
            
            cell.backgroundImg.image = UIImage(named:"NT box hit.png")
            selectedIndexYourTips = indexPath.row
            isselctedYourTips=true
            self.tblYourTips.reloadData()

            let move = self.storyboard?.instantiateViewController(withIdentifier: "NewtrendsDetailsViewController") as! NewtrendsDetailsViewController
                
            move.arrTipsListData = arr_YourTips
            move.intStartIndex = indexPath.row
                
            self.navigationController?.pushViewController(move, animated: true)
            
        }else if tableView == tblYourLists{
            
            let dict_YourLists = arr_YourLists.object(at: indexPath.row) as? NSDictionary
            
            let move = self.storyboard?.instantiateViewController(withIdentifier: kVIew_YOURLISTS) as! YOURLISTSVC
            move.dict_CurrentListFromHome = dict_YourLists!
            move.str_ScreenTitle = "YOUR LISTS"
            self.navigationController?.pushViewController(move, animated: true)
            
        }else if tableView == tblListYouLike{
            
            var dict_YourLists : NSDictionary?
            
            if isSearchingListYoulikes == true{
                
                dict_YourLists = arr_ListsYouLikeFilter.object(at: indexPath.row) as? NSDictionary
            }else{
                dict_YourLists = arr_ListsYouLike.object(at: indexPath.row) as? NSDictionary
            }
            
            let move = self.storyboard?.instantiateViewController(withIdentifier: kVIew_YOURLISTS) as! YOURLISTSVC
            move.dict_CurrentListFromHome = dict_YourLists!
            move.str_ScreenTitle = "LISTS YOU LIKE"
            self.navigationController?.pushViewController(move, animated: true)
            
        }else if tableView == tblFriendsList{
            
            var dict_YourLists : NSDictionary?
            if isSearchingFriendsList == true{
                dict_YourLists = arr_FriendsListFilter.object(at: indexPath.row) as? NSDictionary
                
            }else{
                dict_YourLists = arr_FriendsList.object(at: indexPath.row) as? NSDictionary
            }
            
            let move = self.storyboard?.instantiateViewController(withIdentifier: kVIew_YOURLISTS) as! YOURLISTSVC
            move.dict_CurrentListFromHome = dict_YourLists!
            move.str_ScreenTitle = "FRIENDS’ LISTS"
            self.navigationController?.pushViewController(move, animated: true)
            
        } else if tableView == tblPublicList{
            
            var dict_YourLists : NSDictionary?
            
            if isSearchingPubliclist == true{
                
                dict_YourLists = arr_PublicListFilter.object(at: indexPath.row) as? NSDictionary
            }else{
                dict_YourLists = arr_PublicList.object(at: indexPath.row) as? NSDictionary
            }
            

            let move = self.storyboard?.instantiateViewController(withIdentifier: kVIew_YOURLISTS) as! YOURLISTSVC
            move.dict_CurrentListFromHome = dict_YourLists!
            move.str_ScreenTitle = "PUBLIC LISTS"
            self.navigationController?.pushViewController(move, animated: true)
        }
    }
    
    func leftButtons(_ tableview : UITableView,indexpath:IndexPath) -> [Any]{
        
        if tableview == tblYourLikes {
            
            //IF Public Tips then Share
            
//            let dict_YourLikes = arr_YourLikes.object(at: indexpath.row) as? NSDictionary
//            
//            if let strAutherID = dict_YourLikes?.value(forKey: "AuthorID") as? String{
//                
//                //If this Tips is created by me OR not
//                if strAutherID == appDel.instanceModelLogin.UserID {
//                    
//                    
//                }else{
//                    
//                    
//                }
//            }
            
            
            let leftUtilityButtons = NSMutableArray()
            leftUtilityButtons .sw_addUtilityButton(with: UIColor.clear, icon: UIImage(named: "aarchive.png"))
            leftUtilityButtons .sw_addUtilityButton(with: UIColor.clear, icon: UIImage(named: "archive.png"))
            leftUtilityButtons .sw_addUtilityButton(with: UIColor.clear, icon: UIImage(named: "FB.png"))
            
            return leftUtilityButtons as! [Any]
            
        }else if tableview == tblYourTips{
            
            let leftUtilityButtons = NSMutableArray()
            leftUtilityButtons .sw_addUtilityButton(with: UIColor.clear, icon: UIImage(named: "archive.png"))
            leftUtilityButtons .sw_addUtilityButton(with: UIColor.clear, icon: UIImage(named: "FB.png"))
            return leftUtilityButtons as! [Any]
            
        }else if tableview == tblYourLists{
            
            let leftUtilityButtons = NSMutableArray()
            return leftUtilityButtons as! [Any]
            
        }else if tableview == tblListYouLike{
            
            let leftUtilityButtons = NSMutableArray()
            return leftUtilityButtons as! [Any]
            
        }else if tableview == tblFriendsList{
            
            let leftUtilityButtons = NSMutableArray()
            return leftUtilityButtons as! [Any]
            
        }else if tableview == tblPublicList{
            
            let leftUtilityButtons = NSMutableArray()
            return leftUtilityButtons as! [Any]
            
        }else{
            
            let leftUtilityButtons = NSMutableArray()
            return leftUtilityButtons as! [Any]
        }
    }
    
    func rightbuttons(_ tableview : UITableView,indexpath:IndexPath) -> [Any]{
        
        if tableview == tblYourLikes {
            
            let rightUtilityButtons = NSMutableArray()
            
            let dict_YourLikes = arr_YourLikes.object(at: indexpath.row) as? NSDictionary
            if let strAutherID = dict_YourLikes?.value(forKey: "AuthorID") as? String{
                
                //If this Tips is created by me OR not
                if strAutherID == appDel.instanceModelLogin.UserID {
                    rightUtilityButtons .sw_addUtilityButton(with: UIColor.clear, icon: UIImage(named: "edit"))
                    rightUtilityButtons .sw_addUtilityButton(with: UIColor.clear, icon: UIImage(named: "remove from"))
                    
                }else{
                    
                    rightUtilityButtons .sw_addUtilityButton(with: UIColor.clear, icon: UIImage(named: "remove from"))
                }
            }
            
            //This Button is for Space Only
            rightUtilityButtons .sw_addUtilityButton(with: UIColor.clear, icon: UIImage(named: "deletee"))
            return rightUtilityButtons as! [Any]
            
        }else if tableview == tblYourTips {
            
            let rightUtilityButtons = NSMutableArray()
            
            rightUtilityButtons .sw_addUtilityButton(with: UIColor.clear, icon: UIImage(named: "edit.png"))
            rightUtilityButtons .sw_addUtilityButton(with: UIColor.clear, icon: UIImage(named: "Cross"))
            return rightUtilityButtons as! [Any]
            
        }else if tableview == tblYourLists{
            
            let rightUtilityButtons = NSMutableArray()
            rightUtilityButtons .sw_addUtilityButton(with: UIColor.clear, icon: UIImage(named: "like.png"))
            rightUtilityButtons .sw_addUtilityButton(with: UIColor.clear, icon: UIImage(named: "visib small.png"))
            rightUtilityButtons .sw_addUtilityButton(with: UIColor.clear, icon: UIImage(named: "Cross"))
            return rightUtilityButtons as! [Any]
            
        }else if tableview == tblListYouLike{
            
            let rightUtilityButtons = NSMutableArray()
            rightUtilityButtons .sw_addUtilityButton(with: UIColor.clear, icon: UIImage(named: "remove from"))
            return rightUtilityButtons as! [Any]
            
        }else if tableview == tblFriendsList{
            
            let rightUtilityButtons = NSMutableArray()
            rightUtilityButtons .sw_addUtilityButton(with: UIColor.clear, icon: UIImage(named: "like.png"))
            return rightUtilityButtons as! [Any]
            
        }else if tableview == tblPublicList{
            let rightUtilityButtons = NSMutableArray()
            rightUtilityButtons .sw_addUtilityButton(with: UIColor.clear, icon: UIImage(named: "like.png"))
            return rightUtilityButtons as! [Any]
            
        }else{
            
            let rightUtilityButtons = NSMutableArray()
            return rightUtilityButtons as! [Any]
        }
    }
    
    func swipeableTableViewCell(_ cell: SWTableViewCell, scrollingTo state: SWCellState){
        
        
        //bhavesh Work on it
//        let indexpath = NSIndexPath(row: cell.tag, section: 0)
//        let currentCell = tblYourTips.cellForRow(at: indexpath as IndexPath) as! Cell_YourTips

        switch state
        {
        case .cellStateRight:
            print("Right utility buttons open")
           // currentCell.view_RightMenu.isHidden = false
          //  currentCell.view_LeftMenu.isHidden = true

            
        case .cellStateCenter:
            print("close")
          //  currentCell.view_RightMenu.isHidden = true
           // currentCell.view_LeftMenu.isHidden = true

            
        case .cellStateLeft:
            print("left utility buttons open")
           // currentCell.view_RightMenu.isHidden = true
           // currentCell.view_LeftMenu.isHidden = false
        }
    }
    
    func swipeableTableViewCell(_ cell: SWTableViewCell, didTriggerLeftUtilityButtonWith index: Int)
    {
        if cell is YourLikesTableViewCell {
            print("This Left Cell is from tblYourLikes and Index = \(index)")
        }else if cell is Cell_YourTips{
            print("This Left Cell is from tblYourTips and Index = \(index)")
        }else if cell is Cell_YourList{
            print("This Left  Cell is from tblYourList and Index = \(index)")
        }else if cell is Cell_ListYouLike{
            print("This Right Cell is from tblListYouLike and Index = \(index)")
        }else if cell is Cell_FriendsList{
            print("This Right Cell is from tblFriendsList and Index = \(index)")
        }else if cell is Cell_PublicList{
            print("This Right Cell is from tblPublicList and Index = \(index)")
        }

        
//        switch index
//        {
//        case 0:
//            print("left button 0 was pressed")
//            
//        case 1:
//            print("left button 1 was pressed")
//            
//        case 2:
//            print("left button 2 was pressed")
//            
//        default:
//            break
//        }
    }
  
    func swipeableTableViewCell(_ cell: SWTableViewCell, didTriggerRightUtilityButtonWith index: Int)
    {
        if cell is YourLikesTableViewCell {
            print("This Right Cell is from tblYourLikes and Index = \(index)")
        }else if cell is Cell_YourTips{
            print("This Right Cell is from tblYourTips and Index = \(index)")
        }else if cell is Cell_YourList{
            print("ThisRight  Cell is from tblYourList and Index = \(index)")
        }else if cell is Cell_ListYouLike{
            print("This Right Cell is from tblListYouLike and Index = \(index)")
        }else if cell is Cell_FriendsList{
            print("This Right Cell is from tblFriendsList and Index = \(index)")
        }else if cell is Cell_PublicList{
            print("This Right Cell is from tblPublicList and Index = \(index)")
        }
        
//        let indexPath: IndexPath? = tblYourLikes.indexPath(for: cell)
//        print("Index path: \(String(describing: indexPath))")
        
//        switch index
//        {
//        case 0: break
//        // [cell hideUtilityButtonsAnimated:YES];
//        case 1:
//            break
//        case 2: break
//        // Delete button was pressed
//        default:
//            break
//        }
        
    }
    
    func swipeableTableViewCellShouldHideUtilityButtons(onSwipe cell: SWTableViewCell!) -> Bool {
        return true
    }
    

    //MARK:- Textfield search Event

    @IBAction func handleValueChange(_ sender: UITextField)
    {
        if let txt = sender.text, txt != ""
        {
            isSearchingListYoulikes = true
            let predicate = NSPredicate(format: "%K CONTAINS[cd] %@", "ListName", txt)
            arr_ListsYouLikeFilter = arr_ListsYouLike.filter {predicate.evaluate(with: $0)} as! NSMutableArray
            
        }
        else
        {
            isSearchingListYoulikes = false
            arr_ListsYouLikeFilter = []
        }
        tblListYouLike.reloadData()
    }
    
    @IBAction func handleValueChangeFriendsList(_ sender: UITextField)
    {
        if let txt = sender.text, txt != ""
        {
            isSearchingFriendsList = true
            let predicate = NSPredicate(format: "%K CONTAINS[cd] %@", "AuthorName", txt)
            arr_FriendsListFilter = arr_Friends.filter {predicate.evaluate(with: $0)} as! NSMutableArray
            
            
        }
        else
        {
            isSearchingFriendsList = false
            arr_FriendsListFilter = []
        }
        tblFriendsList.reloadData()
    }
    @IBAction func handleValueChangePublicList(_ sender: UITextField)
    {
        if let txt = sender.text, txt != ""
        {
            isSearchingPubliclist = true
            let predicate = NSPredicate(format: "%K CONTAINS[cd] %@", "AuthorName", txt)
            arr_PublicListFilter = arr_PublicList.filter {predicate.evaluate(with: $0)} as! NSMutableArray
            
        }
        else
        {
            isSearchingPubliclist = false
            arr_ListsYouLikeFilter = []
        }
        tblPublicList.reloadData()
    }

    //MARK:- Hide-Show Section
    func isHideAllSection()
    {
        isYourLikes = false
        isYourTips = false
        isYourLists = false
        isListYouLike = false
        isFriendsList = false
        ispublicList = false
    }
    
    //MARK:- UIButton Action
    @IBAction func YourLikesTapped(_ sender: Any)
    {
        //let myButton: UIButton = sender as! UIButton
        
        //print(NSStringFromCGRect(mainScrl.convert(myButton.frame, from: myButton.superview)))
        
        scrlYPos = Float(viewYourLikesHeader.frame.origin.y);
        
        isYourTips = false
        isYourLists = false
        isListYouLike = false
        isFriendsList = false
        ispublicList = false
        
        if isYourLikes
        {
            isYourLikes = false
        }
        else
        {
            isYourLikes = true
        }
        self.setupViews()
    }
    
    @IBAction func YourTipsTapped(_ sender: Any)
    {
        scrlYPos = Float(viewYourTipsHeader.frame.origin.y);
        
        isYourLikes = false
        isYourLists = false
        isListYouLike = false
        isFriendsList = false
        ispublicList = false
        
        if isYourTips
        {
            isYourTips = false
        }
        else
        {
            isYourTips = true
        }
        self.setupViews()
    }
    
    @IBAction func YourListsTapped(_ sender: Any)
    {
        scrlYPos = Float(viewYourListHeader.frame.origin.y);
        
        isYourLikes = false
        isYourTips = false
        isListYouLike = false
        isFriendsList = false
        ispublicList = false
        
        if isYourLists
        {
            isYourLists = false
        }
        else
        {
            isYourLists = true
        }
        self.setupViews()
    }
    
    @IBAction func crossListYouLikeTapped(_ sender: Any)
    {
        txtListYouLikeHeader.resignFirstResponder()
    }
    @IBAction func ListYouLikeTapped(_ sender: Any)
    {
        isYourLikes = false
        isYourTips = false
        isYourLists = false
        isFriendsList = false
        ispublicList = false
        
        scrlYPos = Float(viewListYouLikeHeader.frame.origin.y);
        
        if isListYouLike
        {
            isListYouLike = false
        }
        else
        {
            isListYouLike = true
        }
        self.setupViews()
    }
    
    @IBAction func crossFriendsTapped(_ sender: Any)
    {
        txtFriendsHeader.resignFirstResponder()
    }
    @IBAction func FriendsListTapped(_ sender: Any)
    {
        scrlYPos = Float(viewFriendsListHeader.frame.origin.y);
        
        isYourLikes = false
        isYourTips = false
        isYourLists = false
        isListYouLike = false
        ispublicList = false
        
        if isFriendsList
        {
            isFriendsList = false
        }
        else
        {
            isFriendsList = true
        }
        self.setupViews()
    }
    
    @IBAction func crossPublicListTapped(_ sender: Any)
    {
        txtPublicListHeader.resignFirstResponder()
    }
    @IBAction func publicListTapped(_ sender: Any)
    {
        scrlYPos = Float(viewPublicListDetails.frame.origin.y);
        
        isYourLikes = false
        isYourTips = false
        isYourLists = false
        isListYouLike = false
        isFriendsList = false
        
        if ispublicList
        {
            ispublicList = false
        }
        else
        {
            ispublicList = true
        }
        self.setupViews()
    }
    
    @IBAction func btnAction_YourProfile(_ sender: Any){
        
        let objView = self.storyboard?.instantiateViewController(withIdentifier: kView_ProfileVC)
        self.navigationController?.pushViewController(objView!, animated: true)
        
    }

    @IBAction func btnAction_GoExplore(_ sender: Any) {
    }
    
    @IBAction func btnAction_BeTracker(_ sender: Any) {
    }
    
    @IBAction func btnAction_SharePostaTip(_ sender: Any) {
        
        //This is only for testing
//        let view = self.storyboard?.instantiateViewController(withIdentifier: kVIew_YOURLISTS)
//        self.navigationController?.pushViewController(view!, animated: true)
    }
    
    
    //MARK:- Webservice Methods
    
//N&T data API
    func getNewAndTrending() {
        
        HUD.show(true)
        web.getNewAndTendingTips()
        
    }
    
    func getNewAndTendingTipsResponse(responseObj: NSDictionary) -> Void{
        
        HUD.hide(true)
        let responseAllKey : NSArray = responseObj.allKeys as NSArray
        print("Print Array Keys : \(responseAllKey)")
        
        if responseAllKey.contains(kAPI_Status) {
            
            if let statusCode : Int = responseObj.value(forKey: kAPI_Status) as? Int {
                if statusCode == 200
                {
                    if ISDebug
                    {
                        print("Simple Login True response \(responseObj)")
                        
                        let jsonArray = responseObj.value(forKey: "NewnTrending") as! NSArray
                        arr_NewTrending = jsonArray.mutableCopy() as! NSMutableArray
                        print(arr_NewTrending)
                        self.setupViews()
                    }
                    
                }
                else{
                    
                    if ISDebug{
                        print("Tips like & Unlike False")
                    }
                    
                    if responseAllKey.contains(kAPI_Msg) {
                        
                        if let strMessage = responseObj.value(forKey: kAPI_Msg) as? String {
                            Constants.showAlertTitle(kAlertAppName, messageStr: strMessage, viewController: self)
                        }
                    }
                }
            }
        }
    }
    
//Homescreen Other section API
    
    func HomescreenOtherSectionAPI(){
        
        HUD.show(true)
        web.getHome_alllist(strUserID: "31") //We have to change this Id to Login User ID.
//        web.getHome_alllist(strUserID: appDel.instanceModelLogin.UserID)
    }
    
    func getHomescreenAllsectionResponse(responseObj: NSDictionary) -> Void
    {
        HUD.hide(true)
        let responseAllKey : NSArray = responseObj.allKeys as NSArray
        print("Print Array Keys : \(responseAllKey)")
        
        if responseAllKey.contains(kAPI_Status) {
            
            if let statusCode : Int = responseObj.value(forKey: kAPI_Status) as? Int {
                if statusCode == 200
                {
                    if ISDebug{
                        print("Simple Login True response \(responseObj)")
                    }
                    
                    let JsonFollowers = responseObj.value(forKey: "Followers") as! NSArray
                    arr_Following = JsonFollowers.mutableCopy() as! NSMutableArray
                    
                    let JsonFriends = responseObj.value(forKey: "Friends") as! NSArray
                    arr_Friends = JsonFriends.mutableCopy() as! NSMutableArray
                    
                    let JsonFriendsLists = responseObj.value(forKey: "FriendsLists") as! NSArray
                    arr_FriendsList = JsonFriendsLists.mutableCopy() as! NSMutableArray
                    
                    let JsonListYouLike = responseObj.value(forKey: "ListYouLike") as! NSArray
                    arr_ListsYouLike = JsonListYouLike.mutableCopy() as! NSMutableArray
                    
                    let JsonPublicList = responseObj.value(forKey: "PublicList") as! NSArray
                    arr_PublicList = JsonPublicList.mutableCopy() as! NSMutableArray
                    
                    let JsonYourLikes = responseObj.value(forKey: "YourLikes") as! NSArray
                    arr_YourLikes = JsonYourLikes.mutableCopy() as! NSMutableArray
                    
                    let JsonYourList = responseObj.value(forKey: "YourList") as! NSArray
                    arr_YourLists = JsonYourList.mutableCopy() as! NSMutableArray
                    
                    let JsonYourTips = responseObj.value(forKey: "YourTips") as! NSArray
                    arr_YourTips = JsonYourTips.mutableCopy() as! NSMutableArray
                    
                    perform(#selector(setupViews), with: nil, afterDelay: 0.2)
                    
                }
                else{
                    if ISDebug{
                        print("Tips like & Unlike False")
                    }
                    
                    if responseAllKey.contains(kAPI_Msg) {
                        
                        if let strMessage = responseObj.value(forKey: kAPI_Msg) as? String {
                            Constants.showAlertTitle(kAlertAppName, messageStr: strMessage, viewController: self)
                        }
                    }
                }
            }
        }
    }
}
