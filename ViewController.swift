

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var filteredImage: UIImage?
    var sliderValue = 5
    var currentImage: UIImage?
    var colorNo=0
    //text view
    
    
    @IBOutlet var textView1: UITextView!
    
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var secondaryMenu: UIView!
    @IBOutlet var bottomMenu: UIView!
    
    @IBOutlet var filterButton: UIButton!
    
    //compare
    
    @IBOutlet var buttonCompare: UIButton!
    //slider
    
    
    @IBOutlet var sliderMenu: UIView!
    
    
    
    @IBOutlet var editButton: UIButton!
    
    @IBAction func onEditButton(sender: UIButton) {
        
        if editButton.selected {
            hideSliderMenu()
            editButton.selected = false
        } else {
            if filterButton.selected {
                filterButton.selected = false
                hideSecondaryMenu()
            }
            showSliderMenu()
            editButton.selected = true
            buttonCompare.selected = false
        }
    }
    func showSliderMenu() {
        view.addSubview(sliderMenu)
        let bottomConstraint = sliderMenu.bottomAnchor.constraintEqualToAnchor(bottomMenu.topAnchor)
        let leftConstraint = sliderMenu.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint = sliderMenu.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        let heightConstraint = sliderMenu.heightAnchor.constraintEqualToConstant(44)
        NSLayoutConstraint.activateConstraints([bottomConstraint,leftConstraint,rightConstraint,heightConstraint])
        view.layoutIfNeeded()
        self.sliderMenu.alpha = 0
        UIView.animateWithDuration(0.4) {
            self.sliderMenu.alpha = 1.0
        }
    }
    func hideSliderMenu() {
        UIView.animateWithDuration(0.4, animations: {
            self.sliderMenu.alpha = 0
        }) { completed in
            if completed == true {
                self.sliderMenu.removeFromSuperview()
            }
        }
   
        
    }
    //compare function 
    
    @IBAction func onButtonCompare(sender: UIButton) {
        
        
        
        if  buttonCompare.selected==false{
            
            textView1.hidden=true
            imageView.image=filteredImage
            buttonCompare.selected=true
            
            
            }
            
        
       else{
    
            let image = currentImage
            imageView.image=image
            buttonCompare.selected=false
            textView1.hidden=false
            
            
            
            
        }
        
        
        
        
    }
    
    
    func showImage(image : UIImage) {
    UIView.transitionWithView(imageView, duration:1, options:UIViewAnimationOptions.TransitionCrossDissolve,
                              animations: {self.imageView.image=image},completion: nil)
    
    }
    
    
    //change slider
    
    
    
    @IBOutlet var changeSlider: UISlider!
    
    
    @IBAction func onSliderChange(sender: UISlider) {
        sliderValue = lroundf(changeSlider.value)
        
        if colorNo==1{
        let rgbaImage=RGBAImage(image:currentImage!)!
        //colorNo=1
        //let avgRed=118
        for y in 0..<rgbaImage.height{
            for x in 0..<rgbaImage.width{
                let index = y*rgbaImage.width+x
                var pixel=rgbaImage.pixels[index]
                let redDelta=Int(pixel.red)-sliderValue
                var modifier=1+4*(Double(y)/Double(rgbaImage.height))
                if (Int(pixel.red)<sliderValue){
                    modifier=1
                }
                pixel.red=UInt8(max(min(225,Int(round(Double(sliderValue)+modifier*Double(redDelta)))),0))
                rgbaImage.pixels[index]=pixel
            }
        }
        
        filteredImage=rgbaImage.toUIImage()
        imageView.image = filteredImage
        
        }
        
        else if colorNo==2
        {

            buttonCompare.enabled = true
            let rgbaImage=RGBAImage(image:currentImage!)!
           // colorNo=2
            
            
            textView1.hidden=true
            
            
          //  let avgGreen=118
            for y in 0..<rgbaImage.height{
                for x in 0..<rgbaImage.width{
                    let index = y*rgbaImage.width+x
                    var pixel=rgbaImage.pixels[index]
                    let greenDelta=Int(pixel.green)-sliderValue
                    var modifier=1+4*(Double(y)/Double(rgbaImage.height))
                    if (Int(pixel.green)<sliderValue){
                        modifier=1
                    }
                    pixel.green=UInt8(max(min(225,Int(round(Double(sliderValue)+modifier*Double(greenDelta)))),0))
                    rgbaImage.pixels[index]=pixel
                }
            }
            
            filteredImage=rgbaImage.toUIImage()
            imageView.image=filteredImage

        
        }
        
        else if colorNo==3
        
        {

            buttonCompare.enabled = true
            //colorNo=3
            
            let rgbaImage=RGBAImage(image:currentImage!)!
            
            
            
            textView1.hidden=true
            
            
          //  let avgBlue=118
            for y in 0..<rgbaImage.height{
                for x in 0..<rgbaImage.width{
                    let index = y*rgbaImage.width+x
                    var pixel=rgbaImage.pixels[index]
                    let blueDelta=Int(pixel.blue)-sliderValue
                    var modifier=1+4*(Double(y)/Double(rgbaImage.height))
                    if (Int(pixel.blue)<sliderValue){
                        modifier=1
                    }
                    pixel.blue=UInt8(max(min(225,Int(round(Double(sliderValue)+modifier*Double(blueDelta)))),0))
                    rgbaImage.pixels[index]=pixel
                }
            }
            
            filteredImage=rgbaImage.toUIImage()
            imageView.image=filteredImage
            
            
        }
        
        else if colorNo==4
        {

            buttonCompare.enabled = true
            textView1.hidden=true
            
            
            // let image = UIImage(named:"scenery")!
            let rgbaImage=RGBAImage(image:currentImage!)!
            
            let avgRed=118
           // let avgGreen=118
            for y in 0..<rgbaImage.height{
                for x in 0..<rgbaImage.width{
                    let index = y*rgbaImage.width+x
                    var pixel=rgbaImage.pixels[index]
                    let redDelta=Int(pixel.red)-avgRed
                    let greenDelta=Int(pixel.green)-sliderValue
                    var modifier=1+4*(Double(y)/Double(rgbaImage.height))
                    if (Int(pixel.red)<avgRed && Int(pixel.green)<sliderValue){
                        modifier=1
                    }
                    pixel.red=UInt8(max(min(225,Int(round(Double(avgRed)+modifier*Double(redDelta)))),0))
                    
                    pixel.green=UInt8(max(min(225,Int(round(Double(sliderValue)+modifier*Double(greenDelta)))),0))
                    
                    
                    rgbaImage.pixels[index]=pixel
                    
                }
            }
            
            filteredImage=rgbaImage.toUIImage()
            imageView.image = filteredImage
            

            
        
        }
        
        else if colorNo==5
        
        {

            buttonCompare.enabled = true
            textView1.hidden=true
            //colorNo=5
            
            // let image = UIImage(named:"scenery")!
            let rgbaImage=RGBAImage(image:currentImage!)!
            
            let avgRed=118
       //     let avgBlue=118
            for y in 0..<rgbaImage.height{
                for x in 0..<rgbaImage.width{
                    let index = y*rgbaImage.width+x
                    var pixel=rgbaImage.pixels[index]
                    let redDelta=Int(pixel.red)-avgRed
                    let blueDelta=Int(pixel.blue)-sliderValue
                    var modifier=1+4*(Double(y)/Double(rgbaImage.height))
                    if (Int(pixel.red)<avgRed && Int(pixel.blue)<sliderValue){
                        modifier=1
                    }
                    pixel.red=UInt8(max(min(225,Int(round(Double(avgRed)+modifier*Double(redDelta)))),0))
                    pixel.blue=UInt8(max(min(225,Int(round(Double(sliderValue)+modifier*Double(blueDelta)))),0))
                    rgbaImage.pixels[index]=pixel
                }
            }
            
            filteredImage=rgbaImage.toUIImage()
            imageView.image = filteredImage
            
            

            
            
        }
        
        
       
    }
    
    
    //red filter
    @IBOutlet var buttonRed: UIButton!
   
    @IBAction func onRedButton(sender: UIButton) {
        buttonCompare.enabled = true
        
        
        
        textView1.hidden=true
        
        
       // let image = UIImage(named:"scenery")!
        let rgbaImage=RGBAImage(image:currentImage!)!
        colorNo=1
        let avgRed=118
        for y in 0..<rgbaImage.height{
            for x in 0..<rgbaImage.width{
                let index = y*rgbaImage.width+x
                var pixel=rgbaImage.pixels[index]
                let redDelta=Int(pixel.red)-avgRed
                var modifier=1+4*(Double(y)/Double(rgbaImage.height))
                if (Int(pixel.red)<avgRed){
                    modifier=1
                }
                pixel.red=UInt8(max(min(225,Int(round(Double(avgRed)+modifier*Double(redDelta)))),0))
                rgbaImage.pixels[index]=pixel
            }
        }
        
        filteredImage=rgbaImage.toUIImage()
        imageView.image = filteredImage

    }
    //green filter
    
    @IBOutlet var buttonGreen: UIButton!
    
    @IBAction func onGreenButton(sender: UIButton) {
        
        buttonCompare.enabled = true
        let rgbaImage=RGBAImage(image:currentImage!)!
        colorNo=2
    
        
        textView1.hidden=true

        
        let avgGreen=118
        for y in 0..<rgbaImage.height{
            for x in 0..<rgbaImage.width{
                let index = y*rgbaImage.width+x
                var pixel=rgbaImage.pixels[index]
                let greenDelta=Int(pixel.green)-avgGreen
                var modifier=1+4*(Double(y)/Double(rgbaImage.height))
                if (Int(pixel.green)<avgGreen){
                    modifier=1
                }
                pixel.green=UInt8(max(min(225,Int(round(Double(avgGreen)+modifier*Double(greenDelta)))),0))
                rgbaImage.pixels[index]=pixel
            }
        }
        
        filteredImage=rgbaImage.toUIImage()
        imageView.image=filteredImage

    }
    
    //blue filter
    
    @IBOutlet var buttonBlue: UIButton!
    
    @IBAction func onBlueButton(sender: UIButton) {
        
        buttonCompare.enabled = true
        colorNo=3
        
        let rgbaImage=RGBAImage(image:currentImage!)!
        
        
        
        textView1.hidden=true

        
        let avgBlue=118
        for y in 0..<rgbaImage.height{
            for x in 0..<rgbaImage.width{
                let index = y*rgbaImage.width+x
                var pixel=rgbaImage.pixels[index]
                let blueDelta=Int(pixel.blue)-avgBlue
                var modifier=1+4*(Double(y)/Double(rgbaImage.height))
                if (Int(pixel.blue)<avgBlue){
                    modifier=1
                }
                pixel.blue=UInt8(max(min(225,Int(round(Double(avgBlue)+modifier*Double(blueDelta)))),0))
                rgbaImage.pixels[index]=pixel
            }
        }
        
        filteredImage=rgbaImage.toUIImage()
        imageView.image=filteredImage

    }
    
    
    
    //yellow filter
    
    @IBOutlet var buttonYellow: UIButton!
    
    
    @IBAction func onButtonYellow(sender: UIButton) {
        
        colorNo=4
        
        
        buttonCompare.enabled = true
        
        
        
        textView1.hidden=true
        
        
        // let image = UIImage(named:"scenery")!
        let rgbaImage=RGBAImage(image:currentImage!)!
        
        let avgRed=118
        let avgGreen=118
        for y in 0..<rgbaImage.height{
            for x in 0..<rgbaImage.width{
                let index = y*rgbaImage.width+x
                var pixel=rgbaImage.pixels[index]
                let redDelta=Int(pixel.red)-avgRed
                let greenDelta=Int(pixel.green)-avgGreen
                var modifier=1+4*(Double(y)/Double(rgbaImage.height))
                if (Int(pixel.red)<avgRed && Int(pixel.green)<avgGreen){
                    modifier=1
                }
                pixel.red=UInt8(max(min(225,Int(round(Double(avgRed)+modifier*Double(redDelta)))),0))
                
                pixel.green=UInt8(max(min(225,Int(round(Double(avgGreen)+modifier*Double(greenDelta)))),0))
                
                
                rgbaImage.pixels[index]=pixel
                
            }
        }
        
        filteredImage=rgbaImage.toUIImage()
        imageView.image = filteredImage
        
    }
    
    
    //purple filter
    
    @IBOutlet var buttonPurple: UIButton!
    @IBAction func onButtonPurple(sender: UIButton) {
        buttonCompare.enabled = true
        textView1.hidden=true
        colorNo=5
        
        // let image = UIImage(named:"scenery")!
        let rgbaImage=RGBAImage(image:currentImage!)!
        
        let avgRed=118
        let avgBlue=118
        for y in 0..<rgbaImage.height{
            for x in 0..<rgbaImage.width{
                let index = y*rgbaImage.width+x
                var pixel=rgbaImage.pixels[index]
                let redDelta=Int(pixel.red)-avgRed
                let blueDelta=Int(pixel.blue)-avgBlue
                var modifier=1+4*(Double(y)/Double(rgbaImage.height))
                if (Int(pixel.red)<avgRed && Int(pixel.blue)<avgBlue){
                    modifier=1
                }
                pixel.red=UInt8(max(min(225,Int(round(Double(avgRed)+modifier*Double(redDelta)))),0))
                pixel.blue=UInt8(max(min(225,Int(round(Double(avgBlue)+modifier*Double(blueDelta)))),0))
                rgbaImage.pixels[index]=pixel
            }
        }
        
        filteredImage=rgbaImage.toUIImage()
        imageView.image = filteredImage

        
        
        
        
        
        
    }
    
    
    
    
    func onLongPressImage(lp: UILongPressGestureRecognizer) {
        
        if (lp.state == UIGestureRecognizerState.Began) {
            showImage(self.currentImage!)
            
        }else{
            //showImage(self.newImage!)
            imageView.image = filteredImage
        }
        
        
    }

    
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        sliderMenu.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        sliderMenu.translatesAutoresizingMaskIntoConstraints = false
        
        //editButton.enabled = false
        
        currentImage=imageView.image
        
        
        
        
        imageView.userInteractionEnabled = true
        
        
        let longPress: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "onLongPressImage:")
        
        self.imageView.addGestureRecognizer(longPress)
        
        
        
        
        
        //filterButton.hidden=true
        
        secondaryMenu.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        secondaryMenu.translatesAutoresizingMaskIntoConstraints = false

        textView1.hidden=false
        
        if filterButton.selected == true
        {
            buttonCompare.enabled = true
        }
        else
        {
            
            buttonCompare.enabled = false
        }
        
        
        
        
        
    }
    
    
    
    
    
    

    // MARK: Share
    @IBAction func onShare(sender: AnyObject) {
        let activityController = UIActivityViewController(activityItems: ["Check out our really cool app", imageView.image!], applicationActivities: nil)
        presentViewController(activityController, animated: true, completion: nil)
    }
    
    // MARK: New Photo
    @IBAction func onNewPhoto(sender: AnyObject) {
        let actionSheet = UIAlertController(title: "New Photo", message: nil, preferredStyle: .ActionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .Default, handler: { action in
            self.showCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Album", style: .Default, handler: { action in
            self.showAlbum()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func showCamera() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .Camera
        
        presentViewController(cameraPicker, animated: true, completion: nil)
    }
    
    func showAlbum() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .PhotoLibrary
        
        presentViewController(cameraPicker, animated: true, completion: nil)
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissViewControllerAnimated(true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
            currentImage = image
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Filter Menu
    @IBAction func onFilter(sender: UIButton) {
        if (sender.selected) {
            hideSecondaryMenu()
            sender.selected = false
        } else {
            showSecondaryMenu()
            sender.selected = true
        }
    }
    
    func showSecondaryMenu() {
        view.addSubview(secondaryMenu)
        
        let bottomConstraint = secondaryMenu.bottomAnchor.constraintEqualToAnchor(bottomMenu.topAnchor)
        let leftConstraint = secondaryMenu.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint = secondaryMenu.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        
        let heightConstraint = secondaryMenu.heightAnchor.constraintEqualToConstant(44)
        
        NSLayoutConstraint.activateConstraints([bottomConstraint, leftConstraint, rightConstraint, heightConstraint])
        
        view.layoutIfNeeded()
        
        self.secondaryMenu.alpha = 0
        UIView.animateWithDuration(0.4) {
            self.secondaryMenu.alpha = 1.0
        }
        
    }
    
    //////////////////
    
    
    //////////////////////
    func hideSecondaryMenu() {
        UIView.animateWithDuration(0.4, animations: {
            self.secondaryMenu.alpha = 0
            }) { completed in
                if completed == true {
                    self.secondaryMenu.removeFromSuperview()
                }
        }
    }

}

