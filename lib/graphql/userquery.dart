const checkUser = """
mutation CheckPhonenSend(\$phone: String!) {
  checkPhonenSend(phone: \$phone) {
    user {
      _id
    }
    otp
  }
}
""";

const otpCheck = """
query Verify(\$verify: VerifyInput) {
  verifyOtp(verify: \$verify){
    token
  }
}
""";

const getAddress = """
query GetAddresses {
  getAddresses {
    phone
    _id
  }
}
""";