class URLS {
  // static const baseURL = "https://backend.zerowastecitizen.in/";
  static const baseURL = "https://api.zerowastecitizen.in/";

  // registration URL
  static const registerCustomer = "public/user/register",
      registrationOTPVerification = "public/user/verify_otp",
      registrationResendOTP = "public/user/resend_otp";

  // login URL
  static const userNameLogin = "user/login",
      loginViaOTP = "public/user/getlogin_otp",
      verifyLoginOTP = "public/user/loginOTP";

  // get Users details
  static const getUserDetails = "user/profile";

  //certificate
  static const certificate = "public/userDetail/certificate";

  //user settings
  static const updateUserProfilePicture =
      "public/userDetail/update_profile_image";

  // register User Address
  static const updateUserProfile = "public/userDetail/update_user",
      updateBranch = "public/userDetail/assign_branch",
      getBranches = "public/general/branch",
      getalldashboardbranches = "dashboard/branches",
      getallbankbranches = "bankBranch",
      getallcitizenlist = "dashboard/users",
      getallproductlist = "product",
      getallproductcategorylist = "category",
      getallwasteprocess = "wasteProcess",
      uploaduserwastedata = "transaction/accept_waste",
      uploadwasteprocessingdata = "transaction/stock_journal",
      adsegregationwaste = "transaction/addsegregate",
      addsegregatedatabyQR = "transaction/addsegregateqr",
      getuserQrdetails = "userDetail/get_user_qr",
      getallstocktransferslist = "transaction/transfers",
      getallsaleslist = "transaction/sales",
      getpurchselist = "transaction/purchases",
      getallcollectionlist = "wastePickupRequests/deposits",
      getallprocesswastelist = "transaction/sjournals",
      getsegregatedlist = "transaction/segregates",
      getstocktransferdetailsbyid = "transaction/get_transfer",
      getcollectiondetailsbyid = "wastePickupRequests/get_deposit",
      getwasteprocessingdetailsbyid = "transaction/get_sjournal",
      getsalesdetailsbyid = "transaction/get_sale",
      getpurchasedetailsbyid = "transaction/get_purchase",
      getmymodules = "userRole/get_modules",
      getotalstockreport = "report/parent_stock",
      getstockreportbycategory = "report/parent_category_stock",
      getstockreportbywastetype = "report/category_stock",

      //

      getalliecprograms = "iec/get_programs",
      getiecprogramtopics = "iec/get_topics",
      addiecprogram = "iec/add_program",
      addiecprogramtopicname = "iec/add_topic",
      //
      uploadsaleswastedata = "transaction/sale",
      uploadpurchasewastedata = "transaction/purchase",
      uploadstocktransferdata = "transaction/stock_transfer",
      //

      getallastates = "state",
      getalldistrictbystate = "district",
      getcitybydistriuct = "city",
      editdistrictdetails = "district/update_district",
      adddistrictdetails = "district/add_district",
      addcitydetails = "city/add_city",
      editcitydetails = "city/update_city",
      getallareasbycityid = "area",
      editareadetails = "area/update_area",
      getproductwastetype = "product/waste_type",
      getproductunitlist = "product/units",
      getproductgstslabs = "product/gst_slabs",
      getallbranchestypes = "branchType",
      addbranchtype = "branchType/add_branchType",
      addbankbranch = "bankBranch/add_branch",
      addwasteproduct = "product/add_product",
      addareadetails = "area/add_area",
      getallwastecategory = "category",
      addwastecategory = "category/add_category",
      addwasteprocessdetails = "wasteProcess/add_process",
      editwasteprocessdetails = "wasteProcess/update_process",
      getusercertificate = "report/certificate";

  /////

  //rewards
  static const currentBalance = "public/userPassbook/current_balance",
      transactions = "public/userPassbook/my_transactions",
      deposits = "public/wastePickupRequests/my_deposits";

  // password
  static const changePassword = "public/userDetail/update_password";

  static const forgotpassword = "user/forgotpassword";

  //pickup requests
  static const pastRequests = "wastePickupRequests/requests";

  //dashboard
  static const getDashboard = "dashboard";

  //bank details
  static const updateBank = "public/userDetail/update_user_bank_details";
  static const accept_pickup_request = "wastePickupRequests/accept_request";
  static const completed_pickup_request =
      "wastePickupRequests/complete_request";
  static const reject_pickup_request = "wastePickupRequests/reject_request";
}
