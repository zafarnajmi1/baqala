//
//  BillingAddressTableViewCell.swift
//  Baqala
//
//  Created by apple on 12/10/18.
//  Copyright © 2018 My Technology. All rights reserved.
//

import UIKit
import DLRadioButton
import GradientLoadingBar

protocol tapedPlaceOrder {
    func plceOrder(cell: BillingAddressTableViewCell)
   
}

class BillingAddressTableViewCell: UITableViewCell {
  
    //MARK:- outlets
    @IBOutlet weak var shipToCheckBtn: UIButton!
    @IBOutlet weak var shippingFormView: UIView!
    @IBOutlet weak var shippingFormViewHeight: NSLayoutConstraint! //520
    @IBOutlet weak var paypalOptionBtn: DLRadioButton!
    @IBOutlet weak var cashDeliveryOptionBtn: DLRadioButton!
    @IBOutlet weak var placeOrderBtn: UIButton!
    @IBOutlet weak var orderNotesTextView: KMPlaceholderTextView!
    @IBOutlet weak var orderNotesLabel: UILabel!
    //titles
    @IBOutlet weak var billingTitleLabel: UILabel!
    @IBOutlet weak var shippingTitleLabel: UILabel!
    @IBOutlet weak var paymentOptionLabel: UILabel!
   
    //MARK:-  Billing fields
    @IBOutlet weak var firstNameBilling: UITextField!
    @IBOutlet weak var lastNameBilling: UITextField!
    @IBOutlet weak var address1Billing: UITextField!
    @IBOutlet weak var address2Billing: UITextField!
    @IBOutlet weak var phoneBilling: UITextField!
    @IBOutlet weak var postalCodeBilling: UITextField!
    
    //MARK:-  Billing Labels
    @IBOutlet weak var firstNameBillingLabel: UILabel!
    @IBOutlet weak var lastNameBillingLabel: UILabel!
    @IBOutlet weak var address1BillingLabel: UILabel!
    @IBOutlet weak var address2BillingLabel: UILabel!
    @IBOutlet weak var phoneBillingLabel: UILabel!
    @IBOutlet weak var postalCodeBillingLabel: UILabel!
    
    //MARK:-  Shipping fields
    @IBOutlet weak var firstNameShipping: UITextField!
    @IBOutlet weak var lastNameShipping: UITextField!
    @IBOutlet weak var address1Shipping: UITextField!
    @IBOutlet weak var address2Shipping: UITextField!
    @IBOutlet weak var phoneShipping: UITextField!
    @IBOutlet weak var postalCodeShipping: UITextField!
    
    //MARK:-  Shipping fields
    @IBOutlet weak var firstNameShippingLabel: UILabel!
    @IBOutlet weak var lastNameShippingLabel: UILabel!
    @IBOutlet weak var address1ShippingLabel: UILabel!
    @IBOutlet weak var address2ShippingLabel: UILabel!
    @IBOutlet weak var phoneShippingLabel: UILabel!
    @IBOutlet weak var postalCodeShippingLabel: UILabel!
    
    
    //MARK:- properties and Structures
    private var myRootBillingModel = RootBillingAddressModel()
    private var gradientLoadingBar: GradientLoadingBar!
    
    var paymentMethod = ""
    var payPalConfig = PayPalConfiguration()
    
    var selectedOption = 1 // selected paypal  by defualt
    var myController : UIViewController!
    var orderdelegate: tapedPlaceOrder?
    var myCartRootModel = RootMyCardModel()
  
    //MARK:- lifeCycle
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
          loadLocalization()
          loadDummyData()
        
        //paypal observer
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: NSNotification.Name(rawValue: "Payment"), object: nil)
      
        self.configPayPal()
      
        // Initialization code
        self.shipToCheckBtn.isSelected = true
       
         gradientLoadingBar = BottomGradientLoadingBar(height: 4, durations: Durations.default, gradientColorList: [#colorLiteral(red: 0.7892929912, green: 0.8286149502, blue: 0.2702398896, alpha: 1), #colorLiteral(red: 0.5229000449, green: 0.6485285163, blue: 0.1439691782, alpha: 1), #colorLiteral(red: 0.7892929912, green: 0.8286149502, blue: 0.2702398896, alpha: 1)], isRelativeToSafeArea: true, onView: self.placeOrderBtn )
      
    }
   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.paypalOptionBtn.isMultipleSelectionEnabled = false
        self.paypalOptionBtn.isSelected = true;
        // Configure the view for the selected state
    }
    
    //MARK:- base configuration ( on load View)
   
    func loadLocalization()   {
        
        self.placeOrderBtn.setTitle("Place Order".localized, for: .normal)
        self.paypalOptionBtn.setTitle("Continue With Paypal".localized, for: .normal)
        self.cashDeliveryOptionBtn.setTitle("Cash On Delivery".localized,
                                            for: .normal)
        //titles
        self.paymentOptionLabel.text = "Select Payment Option".localized
        self.billingTitleLabel.text = "Billing Address".localized
        self.shippingTitleLabel.text = "Ship To Different Address?".localized
        self.orderNotesLabel.text = "Order Notes".localized
        //billing labels
        self.firstNameBillingLabel.text = "First Name".localized
        self.lastNameBillingLabel.text = "Last Name".localized
        self.address1BillingLabel.text = "Address Line 1".localized
        self.address2BillingLabel.text = "Address Line 2".localized
        self.phoneBillingLabel.text = "Phone Number".localized
        self.postalCodeBillingLabel.text = "Postcode / Zip".localized
        //shipping labels
        self.firstNameShippingLabel.text = "First Name".localized
        self.lastNameShippingLabel.text = "Last Name".localized
        self.address1ShippingLabel.text = "Address Line 1".localized
        self.address2ShippingLabel.text = "Address Line 2".localized
        self.phoneShippingLabel.text = "Phone Number".localized
        self.postalCodeShippingLabel.text = "Postcode / Zip".localized
        //billing fields
        self.firstNameBilling.placeholder = "First Name".localized
        self.lastNameBilling.placeholder = "Last Name".localized
        self.address1Billing.placeholder = "Address Line 1".localized
        self.address2Billing.placeholder = "Address Line 2".localized
        self.phoneBilling.placeholder = "Phone Number".localized
        self.postalCodeBilling.placeholder = "Postcode / Zip".localized
        //shipping fields
        self.firstNameShipping.placeholder = "First Name".localized
        self.lastNameShipping.placeholder = "Last Name".localized
        self.address1Shipping.placeholder = "Address Line 1".localized
        self.address2Shipping.placeholder = "Address Line 2".localized
        self.phoneShipping.placeholder = "Phone Number".localized
        self.postalCodeShipping.text = "Postcode / Zip".localized
       
        let tfs = [firstNameBilling,lastNameBilling,
                   address1Billing,address2Billing,
                   phoneBilling,postalCodeBilling,
                   firstNameShipping, lastNameShipping,
                   address1Shipping, address2Shipping,
                   phoneShipping, postalCodeShipping] as [UITextField]
        self.setTextFieldDirectionByLanguage(textFields: tfs)
        
        let tvs = [orderNotesTextView] as [UITextView]
        self.setTextViewDirectionByLanguage(textViews: tvs)
        self.setViewDirectionByLanguage()
    }
    
    fileprivate func loadDummyData() {
        //FixMe:- form dummy data
        self.firstNameBilling.text = "biller"
        self.lastNameBilling.text = "number 1"
        self.address1Billing.text = "address 1"
        self.postalCodeBilling.text = "9920"
        
        self.firstNameShipping.text = "shipper"
        self.lastNameShipping.text = "number 1"
        self.address1Shipping.text = "address 1"
        self.postalCodeShipping.text = "9920"
    }
    
    func configPayPal(){
        payPalConfig.acceptCreditCards = false
        payPalConfig.merchantName = "Baqala"
        payPalConfig.merchantPrivacyPolicyURL = URL(string: "https://www.paypal.com/webapps/mpp/ua/privacy-full")
        payPalConfig.merchantUserAgreementURL = URL(string: "https://www.paypal.com/webapps/mpp/ua/useragreement-full")
        payPalConfig.languageOrLocale = Locale.preferredLanguages[0]
        payPalConfig.payPalShippingAddressOption = .payPal;
        print("PayPal iOS SDK Version: \(PayPalMobile.libraryVersion())")
    }
    
    
    
    //MARK:- actions
    
    @objc func onDidReceiveData(_ notification:Notification) {
        moveToPayPal()
    }
    
    @objc @IBAction private func logSelectedButton(radioButton : DLRadioButton) {
            radioButton.deselectOtherButtons()
        for(_, button)  in radioButton.selectedButtons().enumerated() {
                print(button.tag)
                self.selectedOption = button.tag
                 if(button.tag == 1){
                    self.paymentMethod = "paypal"
                }
                 else{
                    self.paymentMethod = "onDelivery"
                 }
            
            }
        
        
    }
    
    @IBAction func shipToDifferentAddressBtnTapped(_ sender: UIButton) {
        
        if sender.isSelected == true {
            sender.isSelected = false
            self.shippingFormSelected(bool: false)
        }
        else {
            sender.isSelected = true
            self.shippingFormSelected(bool: true)
        }
        
    }
    
    func shippingFormSelected(bool: Bool) {
        self.firstNameShipping.isEnabled = bool //"shipper"
        self.lastNameShipping.isEnabled = bool //"number 1"
        self.address1Shipping.isEnabled = bool //"address 1"
        self.address2Shipping.isEnabled = bool
        self.postalCodeShipping.isEnabled = bool // "9920"
    
        if bool {
            self.firstNameShipping.text = "shipper"
            self.lastNameShipping.text = "number 1"
            self.address1Shipping.text = "address 1"
            self.postalCodeShipping.text = "9920"
        }
        else {
            self.firstNameShipping.text = ""
            self.lastNameShipping.text = ""
            self.address2Shipping.text = ""
            self.address1Shipping.text = ""
            self.postalCodeShipping.text = ""
        }
      
    }
    
    
    @IBAction func placeOrderBtnTapped(_ sender: Any) {
      
        self.contentView.endEditing(true)

        if !isValidSignupForm() {return}
        
         let addressTypeB = "billing"
         let address2 = address2Billing.text ??  ""
         let billing = ["firstName": firstNameBilling.text!,
                        "lastName": lastNameBilling.text!,
                        "address1":address1Billing.text!,
                        "address2":address2,
                        "phone": phoneBilling.text!,
                        "postCode": postalCodeBilling.text!,
                        "addressType": addressTypeB
        ]
        
        
        let addressTypeS = "shipping"
        let address2s =  address2Shipping.text ?? ""
       
        let shipping  = ["firstName": firstNameShipping.text!,
                       "lastName": lastNameShipping.text!,
                       "address1":address1Shipping.text!,
                       "address2":address2s,
                       "phone": phoneShipping.text!,
                       "postCode": postalCodeShipping.text!,
                       "addressType": addressTypeS
            ]
    
        if self.shipToCheckBtn.isSelected == true {
             self.requestToSubmitBillingForm(billing, shipping)
        }
        else{
              self.requestToSubmitBillingForm(billing, billing)
        }
       
    }
    
    //MARK:- ws: Web Services Requests
    
    fileprivate func requestToUpdateOnDeliveryForm() {
      
        // get values
       
        let billingId = self.myRootBillingModel.data?.addresses![0].id
        let shippingId = self.myRootBillingModel.data?.addresses![1].id
       
        //dictionary
        let params = [ "billingAddressId": billingId!,
                       "shippingAddressId": shippingId!,
                       "paymentMethod": "onDelivery"]
        
        //show loader
        self.gradientLoadingBar.show()
        self.myController.view.isUserInteractionEnabled = false
        
        //service call
        CheckOutManager.shared.submitCashOndeliveryForm(params: params) { (error, rootModel) in
            
            //hide loader
            self.gradientLoadingBar.hide()
            self.myController.view.isUserInteractionEnabled = true
            
            //success block
            if error == nil {
                nvMessage.showSuccess(body: (rootModel?.message?.en)!)
                //reset badge counter
                Sharedata.shareInfo.cartItemsTotal = 0

                let appDeletgate = UIApplication.shared.delegate as? AppDelegate
                appDeletgate?.moveToHome()
            }
            else{ nvMessage.showError(body: error!) }
        }
    }
    
    
    
    fileprivate func requestToSubmitBillingForm(_ billing: [String : String], _ shipping: [String : String]?) {
        
        //show loader
        gradientLoadingBar.show()
        self.myController.view.isUserInteractionEnabled = false
        
        // serivce call
        BillingAddressManager.shared.submitBillingAddressForm(billing: billing, shipping: shipping) { (error, rootModel) in
            
            if error == nil {
                self.myRootBillingModel = rootModel!
                //hide loader
                self.gradientLoadingBar.hide()
                self.myController.view.isUserInteractionEnabled = true
                
                switch self.selectedOption {
                case 2:
                    self.navigateToCreditCard()
                case 3:
                    self.requestToUpdateOnDeliveryForm()
                    
                default:
                    self.moveToPayPal()
                }
            }
            else{
                nvMessage.showError(body: error!)
            }
            
        }
    }
    
    

}


   //MARK:- helpers ( include form Validation and other Methods )
extension BillingAddressTableViewCell {
   
 
    func navigateToCreditCard() {
        
        let storyBoarad = UIStoryboard(name: "CheckOut", bundle: nil)
        let vc = storyBoarad.instantiateViewController(withIdentifier: "ContinueWithCreditCardVC") as! ContinueWithCreditCardVC
        
        self.myController.title = "Continue With Credit Card"
        self.myController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToCashOnDelivery() {
        
        let storyBoarad = UIStoryboard(name: "CheckOut", bundle: nil)
        let vc = storyBoarad.instantiateViewController(withIdentifier: "CashOnDeliveryVC") as! CashOnDeliveryVC
        vc.myRootBillingAddressModel = myRootBillingModel
        self.myController.title = "Cash On Delivery".localized
        self.myController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func isValidSignupForm() -> Bool {
      
        var title = "Billing Address".localized
       
        if  (firstNameBilling.text?.count)! < 2 {
            let error = "Please enter valid first name".localized
            nvMessage.showError(title: title, body: error)
            return false
        }
        if (lastNameBilling.text?.count)! < 2  {
            let error = "Please enter valid last name".localized
            nvMessage.showError(title: title, body: error)
            return false
        }
       
        if (address1Billing.text?.count)! < 2 {
            let error = "Please enter valid address ".localized
           nvMessage.showError(title: title, body: error)
            return false
        }
       
        if (phoneBilling.text?.count)! < 8 {
            let error = "Please enter valid phone number".localized
            nvMessage.showError(title: title, body: error)
            return false
        }
        
        if (postalCodeBilling.text?.count)! < 3 {
            let error = "Please enter valid PostCode/Zip".localized
            nvMessage.showError(title: title, body: error)
            return false
        }
        
        if (orderNotesTextView.text?.count)! < 3 {
            let error = "Please write order notes".localized
            nvMessage.showError(title: title, body: error)
            return false
        }
        
        //do not validate shipping form is ship check btn is not selected
        if   self.shipToCheckBtn.isSelected == false {
            return true
        }
        
        
         title = "Shipping Address".localized
        
        if  (firstNameShipping.text?.count)! < 2 {
            let error = "Please enter valid first name".localized
            nvMessage.showError(title: title, body: error)
            return false
        }
        if (lastNameShipping.text?.count)! < 2  {
            let error = "Please enter valid last name".localized
            nvMessage.showError(title: title, body: error)
            return false
        }
        
        if (address1Shipping.text?.count)! < 2 {
            let error = "Please enter valid address".localized
            nvMessage.showError(title: title, body: error)
            return false
        }
        
        if (phoneShipping.text?.count)! < 8 {
            let error = "Please enter valid phone number".localized
            nvMessage.showError(title: title, body: error)
            return false
        }
        
        if (postalCodeShipping.text?.count)! < 3 {
            let error = "Please enter valid PostCode/Zip".localized
             nvMessage.showError(title: title, body: error)
            return false
        }
        
        if (orderNotesTextView.text?.count)! < 3 {
            let error = "Please write order notes".localized
            nvMessage.showError(title: title, body: error)
            return false
        }
        
        
        return true
    }
    
}



//MARK: paypalDelegate
extension BillingAddressTableViewCell: PayPalPaymentDelegate, PayPalProfileSharingDelegate {
   
    func payPalPaymentDidCancel(_ paymentViewController: PayPalPaymentViewController){
        paymentViewController.dismiss(animated: true, completion: nil)
        
        let msg = "PayPal Payment Cancelled".localized
        nvMessage.showInfo(title: "PayPal".localized,body: msg)
    }
    
    func payPalPaymentViewController(_ paymentViewController: PayPalPaymentViewController, didComplete completedPayment: PayPalPayment){
        
        paymentViewController.dismiss(animated: true, completion: { () -> Void in
            print("Here is your proof of payment:\n\n\(completedPayment.confirmation)\n\nSend this to your server for confirmation and fulfillment.")
            
            let paymentResultDic = completedPayment.confirmation as NSDictionary
            let dicResponse: AnyObject? = paymentResultDic.object(forKey: "response") as AnyObject?
            let payauid:String = dicResponse!["id"] as! String
            let paystate:String = dicResponse!["state"] as! String
            
            print("id is  --->%@",payauid)
            print("paystate is ----->%@",paystate)
            
            self.sendPyamentToServer(payauid)
        })
    }
    
    func userDidCancel(_ profileSharingViewController: PayPalProfileSharingViewController){
        
       
        let msg = "PayPal profile sharing authorization canceled".localized
        nvMessage.showInfo(title: "PayPal".localized,body: msg)
        print("PayPal Profile Sharing Authorization Canceled")
    }
    
    func payPalProfileSharingViewController(_ profileSharingViewController: PayPalProfileSharingViewController, userDidLogInWithAuthorization profileSharingAuthorization: [AnyHashable : Any]){
        print("PayPal Profile Sharing Authorization Canceled")
    }

    
    
    private func sendPyamentToServer(_ paymentId:String){
        
        var billingId: String?
        var shippingId: String?
        
        if self.myRootBillingModel.data?.addresses?.count == 2 {
             billingId = self.myRootBillingModel.data?.addresses![0].id
             shippingId = self.myRootBillingModel.data?.addresses![1].id
        }
        else{
              billingId = self.myRootBillingModel.data?.addresses![0].id
        }
       

        var payementDic : [String:Any] = ["billingAddressId": billingId!,
                                          "paymentMethod": "paypal",
                                          "paymentId":paymentId,
                                          "orderNote":"hello pakistan"]
        
        if shippingId != nil {
            payementDic.updateValue(shippingId!, forKey: "shippingAddressId")
        }
        
       
        self.myController.showNvLoader()
        
        PaymentManager.shared.paymentExecute(params: payementDic) { (error, rootModel) in
        
            self.myController.hideNvloader()
            
            if error == nil {
                let message = setDefaultLanguage(body: rootModel!.message!)
                nvMessage.showSuccess(title: "Payment", body: message)
                Sharedata.shareInfo.cartItemsTotal = 0
                //self.myController.navigationController?.popToRootViewController(animated: true)
                let appDeletgate = UIApplication.shared.delegate as? AppDelegate
                appDeletgate?.moveToHome()
            }
            else {
                nvMessage.showError(body: error!)
            }
        }
       
        
    }
    
    //MARK: Providing Products Quantity And Price
    
    func moveToPayPal(){
        
        var items = [PayPalItem]()
        for obj in (self.myCartRootModel.data)!{
            let item = PayPalItem(name: obj.product?.productName?.en ?? "", withQuantity: UInt(obj.quantity ?? 0), withPrice: NSDecimalNumber(string: "\(obj.price?.usd ?? 0)"), withCurrency: "USD", withSku: "Hip-0037")
            items.append(item)
        }
        let subtotal = PayPalItem.totalPrice(forItems: items)
        let payment = PayPalPayment(amount: subtotal, currencyCode: "USD", shortDescription: "Some Description About product", intent: .sale)
        payment.items = items
        
        if(payment.processable) {
            let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: self.payPalConfig, delegate: self)
            self.myController.present(paymentViewController!, animated: true, completion: nil)
        }
        else{

            print("Payment not processalbe: \(payment)")
            let msg = "Payment not processalbe: \(payment)".localized
            nvMessage.showError(title: "PayPal".localized,body: msg)
            
        }
    }
    
    
}
