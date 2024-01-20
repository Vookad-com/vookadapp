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

const fireUser = """mutation CreateUser {
  createORCheck {
    phone  
  }
}""";

const otpCheck = """
query Verify(\$verify: VerifyInput) {
  verifyOtp(verify: \$verify){
    token
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
    tags
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

const getAddress = """
query getAddress {
  getUser {
  addresses {
    _id
    pincode
    area
    building
    landmark
    label
    location {
      coordinates
    }
  }  
  }
}
""";

const delAddr = """
mutation Mutation(\$delAddrId: ID!) {
  delAddr(id: \$delAddrId) {
    _id
  }
}
""";

const saveAddr = """
mutation Mutation(\$addPayload: AddPayload!, \$saveAddressId: ID) {
  saveAddress(addPayload: \$addPayload, id: \$saveAddressId) {
    _id
  }
}
""";

const homequery = """
query home(\$location: [Float], \$bannerId: ID!) {
  nearby(location: \$location) {
    ChefId:_id
    displayname
    distance
    info {
      name
      tags
      gallery {
        url
      }
      category {
        _id
        name
        price
      }
      description
      _id
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

const codcheckout = """
mutation Checkout(\$items: [CheckoutItem]!, \$address: CheckoutAddress!, \$total: Float!, \$dod: String!) {
  codcheckout(items: \$items,address: \$address,total: \$total, dod: \$dod) {
  _id  
  }
}
""";

const setFCM = """
mutation setFCM(\$fcmToken: String!) {
  setFCM(fcmToken: \$fcmToken) 
}
""";

const getOrders = """
query GetOrders(\$page: Float){
  fetchOrders(page: \$page) {
    _id
    items {
      catid
      chefid
      pdtid
      quantity
    }
    status
    createdAt
    total
  }
}
""";