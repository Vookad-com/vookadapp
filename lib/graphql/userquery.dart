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

const home = """
query GetItems(\$family: String!, \$bannerId: ID!) {
  inventoryItems(family: \$family) {
    name
    _id
    description
    category {
      _id
      price
      name
    }
    gallery {
      url
    }
  }
  banner(id: \$bannerId) {
    gallery {
      url
      route
    }
  }
}

""";

const monthly = """
query InventoryItems(\$family: String!) {
  inventoryItems(family: \$family) {
    name
    _id
    description
    gallery {
      url
    }
    category {
      _id
      price
      name
  }}
}
""";