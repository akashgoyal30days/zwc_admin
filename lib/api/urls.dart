class URLS {
  static const baseURL = "https://backend.zerowastecitizen.in/";
    // static const baseURL = "https://api.zerowastecitizen.in/";


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
  static const getStates = "public/general/states",
      getDistricts = "public/general/districts",
      getCities = "public/general/cities",
      getAreas = "public/general/areas",
      updateUserProfile = "public/userDetail/update_user",
      updateBranch = "public/userDetail/assign_branch",
      getBranches = "public/general/branch",
      getalldashboardbranches = "dashboard/branches",
      getallcitizenlist = "dashboard/users",
      getallproductlist = "product",
      getallwasteprocess = "wasteProcess",
      uploaduserwastedata = "transaction/accept_waste",
      uploadwasteprocessingdata  = "transaction/stock_journal",
      adsegregationwaste = "transaction/addsegregate",
      addsegregatedatabyQR = "transaction/addsegregateqr",
      getallstocktransferslist = "transaction/transfers",
      getallsaleslist = "transaction/sales",
      getpurchselist = "transaction/purchases",
      getallcollectionlist = "wastePickupRequests/deposits",
      getallprocesswastelist = "transaction/sjournals",
      getsegregatedlist = "transaction/segregates",
      getstocktransferdetailsbyid = "transaction/get_transfer",
      getmymodules = "userRole/get_modules",
      uploadsaleswastedata  = "transaction/sale",
      uploadpurchasewastedata = "transaction/purchase",
      uploadstocktransferdata = "transaction/stock_transfer";

  //rewards
  static const currentBalance = "public/userPassbook/current_balance",
      transactions = "public/userPassbook/my_transactions",
      deposits = "public/wastePickupRequests/my_deposits";

  // password
  static const changePassword = "public/userDetail/update_password";

  //pickup requests
  static const pastRequests = "public/wastePickupRequests/my_requests",
      newRequests = "public/wastePickupRequests/request";

  //dashboard
  static const getDashboard = "dashboard";

  //bank details
  static const updateBank = "public/userDetail/update_user_bank_details";
}
