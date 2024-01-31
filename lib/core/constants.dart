import 'package:flutter/material.dart';

const Widget kWidth = SizedBox(width: 10);
const Widget kHeight = SizedBox(height: 10);
const Widget kProfileScreenGap = SizedBox(height: 20);

enum LoginWith {
  google,
  apple,
  facebook,
}

const List<String> statesList = [
  "N1 2LL",
  "state2",
  "state3",
  "state4",
];

const List avatarImage = [
  {
    'label': "Plain",
    'imagePath': "lib/core/assets/images/product_images/Plain Cashew/Plain Cashew (F) bgwhite.png",
  },
  {
    'label': "Roast",
    'imagePath': "lib/core/assets/images/get_started_bg_image.png",
  },
  {
    'label': "Jam",
    'imagePath': "lib/core/assets/images/product_images/Cashew Pine Jam/Cashew pine jam.jpg",
  },
  {
    'label': "Shakes",
    'imagePath': "lib/core/assets/images/product_images/Cashew Vanilla MilkShake/Cashew Vanilla Milk Shake Powder.jpg",
  },
  {
    'label': "Powder",
    'imagePath': "lib/core/assets/images/product_images/Cashew Powder/Cashew Powder 1.jpg",
  },
  {
    'label': "Soda",
    'imagePath': "lib/core/assets/images/product_images/Cashew Soda/Cashew soda.jpg",
  },
  {
    'label': "Squash",
    'imagePath': "lib/core/assets/images/product_images/Cashew Apple Squash/Cashew apple squash.jpg",
  },
];

const List bestSellersList = [
  {
    'imagePath': [
      "lib/core/assets/images/product_images/Cashew Powder/Cashew Powder 1.jpg",
      "lib/core/assets/images/product_images/Cashew Powder/Cashew Powder 2.jpg",
      "lib/core/assets/images/product_images/Cashew Powder/Cashew Powder 3.jpg",
      "lib/core/assets/images/product_images/Cashew Powder/Cashew Powder 4.jpg",
    ],
    'name': "PLAIN CASHEW KERNELS W320",
    'category': [
      {
        'weight': "100GM",
        'description':
            "Plain W320 (250 gram), Price Rs.581 (GST Inclusive), Product available only in India, Shipping and other Charges:- Kerala 8% ,South India 13%, Other States 18% will be added with the price for completing the ordering procedure.",
        'offerPrice': "289",
        'originalPrice': "433",
        'rating': "56890",
        'haveStock': true,
      },
    ]
  },
  {
    'imagePath': [
      "lib/core/assets/images/product_images/Cashew Vita/Cashew Vita.jpg",
    ],
    'name': "PLAIN CASHEW KERNELS W320",
    'category': [
      {
        'weight': "250GM",
        'description':
            "Plain W320 (250 gram), Price Rs.581 (GST Inclusive), Product available only in India, Shipping and other Charges:- Kerala 8% ,South India 13%, Other States 18% will be added with the price for completing the ordering procedure.",
        'offerPrice': "238",
        'originalPrice': "357",
        'rating': "56890",
        'haveStock': true,
      },
    ]
  },
  {
    'imagePath': [
      "lib/core/assets/images/product_images/Cashew Soup/Cashew Soup.jpg",
      "lib/core/assets/images/product_images/Cashew Soup/Cashew Soup-mix.jpg",
    ],
    'name': "CASHEW SOUP MIX",
    'category': [
      {
        'weight': "65GM",
        'description':
            "Plain W320 (250 gram), Price Rs.581 (GST Inclusive), Product available only in India, Shipping and other Charges:- Kerala 8% ,South India 13%, Other States 18% will be added with the price for completing the ordering procedure.",
        'offerPrice': "215",
        'originalPrice': "323",
        'rating': "56890",
        'haveStock': true,
      },
    ]
  },
];

// const List plainCashewsList = [
//   {
//     'imagePath': [
//       "lib/core/assets/images/product_images/Cashew Plain2-600x600.jpg",
//     ],
//     'name': "PLAIN CASHEW KERNELS W320",
//     'description':
//         "Plain W320 (500 gram), Price Rs.581 (GST Inclusive), Product available only in India, Shipping and other Charges:- Kerala 8% ,South India 13%, Other States 18% will be added with the price for completing the ordering procedure.",
//     'offerPrice': "581",
//     'originalPrice': "610",
//     'offerPercentage': "10%Off",
//     'rating': "56890
// 'haveStock':true,",
//   },
//   {
//     'imagePath': [
//       "lib/core/assets/images/product_images/Cashew Plain2-600x600.jpg",
//     ],
//     'name': "PLAIN CASHEW KERNELS W320",
//     'description': "Neque porro quisquam est qui dolorem ipsum quia",
//     'offerPrice': "1500",
//     'originalPrice': "2499",
//     'offerPercentage': "40%Off",
//     'rating': "56890
// 'haveStock':true,",
//   },
//   {
//     'imagePath': ["lib/core/assets/images/product_images/Cashew Plain2-600x600.jpg"],
//     'name': "PLAIN CASHEW KERNELS W240",
//     'description': "Neque porro quisquam est qui dolorem ipsum quia",
//     'offerPrice': "1500",
//     'originalPrice': "2499",
//     'offerPercentage': "40%Off",
//     'rating': "56890
// 'haveStock':true,",
//   },
//   {
//     'imagePath': ["lib/core/assets/images/product_images/Cashew Plain2-600x600.jpg"],
//     'name': "PLAIN CASHEW KERNELS W320",
//     'description': "Neque porro quisquam est qui dolorem ipsum quia",
//     'offerPrice': "1500",
//     'originalPrice': "2499",
//     'offerPercentage': "40%Off",
//     'rating': "56890
// 'haveStock':true,",
//   },
// ];

const List cashewsPlaneList = [
  {
    'imagePath': [
      "lib/core/assets/images/product_images/Plain Cashew/Plain Cashew (F) bgwhite.png",
      "lib/core/assets/images/product_images/Plain Cashew/Plain cashew (B) bgwhite.png",
    ],
    'name': "PLAIN CASHEW KERNELS W180",
    'category': [
      {
        'weight': "250GM",
        'description':
            "Plain W320 (250 gram), Price Rs.581 (GST Inclusive), Product available only in India, Shipping and other Charges:- Kerala 8% ,South India 13%, Other States 18% will be added with the price for completing the ordering procedure.",
        'offerPrice': "289",
        'originalPrice': "433",
        'rating': "568",
        'haveStock': true,
      },
      {
        'weight': "500GM",
        'description':
            "Plain W320 (500 gram), Price Rs.581 (GST Inclusive), Product available only in India, Shipping and other Charges:- Kerala 8% ,South India 13%, Other States 18% will be added with the price for completing the ordering procedure.",
        'offerPrice': "571",
        'originalPrice': "856",
        'rating': "90",
        'haveStock': true,
      },
      {
        'weight': "1KG",
        'description':
            "Plain W320 (1 kilo gram), Price Rs.581 (GST Inclusive), Product available only in India, Shipping and other Charges:- Kerala 8% ,South India 13%, Other States 18% will be added with the price for completing the ordering procedure.",
        'offerPrice': "1133",
        'originalPrice': "1699",
        'rating': "5",
        'haveStock': true,
      },
    ]
  },
  {
    'imagePath': [
      "lib/core/assets/images/product_images/Plain Cashew/Plain Cashew (F) bgwhite.png",
      "lib/core/assets/images/product_images/Plain Cashew/Plain cashew (B) bgwhite.png",
    ],
    'name': "PLAIN CASHEW KERNELS W210",
    'category': [
      {
        'weight': "250GM",
        'description':
            "Plain W320 (250 gram), Price Rs.581 (GST Inclusive), Product available only in India, Shipping and other Charges:- Kerala 8% ,South India 13%, Other States 18% will be added with the price for completing the ordering procedure.",
        'offerPrice': "238",
        'originalPrice': "357",
        'rating': "56",
        'haveStock': true,
      },
      {
        'weight': "500GM",
        'description':
            "Plain W320 (500 gram), Price Rs.581 (GST Inclusive), Product available only in India, Shipping and other Charges:- Kerala 8% ,South India 13%, Other States 18% will be added with the price for completing the ordering procedure.",
        'offerPrice': "469",
        'originalPrice': "704",
        'rating': "560",
        'haveStock': true,
      },
      {
        'weight': "1KG",
        'description':
            "Plain W320 (1 kilo gram), Price Rs.581 (GST Inclusive), Product available only in India, Shipping and other Charges:- Kerala 8% ,South India 13%, Other States 18% will be added with the price for completing the ordering procedure.",
        'offerPrice': "930",
        'originalPrice': "1395",
        'rating': "890",
        'haveStock': true,
      },
    ]
  },
  {
    'imagePath': [
      "lib/core/assets/images/product_images/Plain Cashew/Plain Cashew (F) bgwhite.png",
      "lib/core/assets/images/product_images/Plain Cashew/Plain cashew (B) bgwhite.png",
    ],
    'name': "PLAIN CASHEW KERNELS W240",
    'category': [
      {
        'weight': "250GM",
        'description':
            "Plain W320 (250 gram), Price Rs.581 (GST Inclusive), Product available only in India, Shipping and other Charges:- Kerala 8% ,South India 13%, Other States 18% will be added with the price for completing the ordering procedure.",
        'offerPrice': "215",
        'originalPrice': "323",
        'rating': "56890",
        'haveStock': true,
      },
      {
        'weight': "500GM",
        'description':
            "Plain W320 (500 gram), Price Rs.581 (GST Inclusive), Product available only in India, Shipping and other Charges:- Kerala 8% ,South India 13%, Other States 18% will be added with the price for completing the ordering procedure.",
        'offerPrice': "636",
        'originalPrice': "424",
        'rating': "590",
        'haveStock': true,
      },
      {
        'weight': "1KG",
        'description':
            "Plain W320 (1 kilo gram), Price Rs.581 (GST Inclusive), Product available only in India, Shipping and other Charges:- Kerala 8% ,South India 13%, Other States 18% will be added with the price for completing the ordering procedure.",
        'offerPrice': "840",
        'originalPrice': "1260",
        'rating': "560",
        'haveStock': true,
      },
    ]
  },
  {
    'imagePath': [
      "lib/core/assets/images/product_images/Plain Cashew/Plain Cashew (F) bgwhite.png",
      "lib/core/assets/images/product_images/Plain Cashew/Plain cashew (B) bgwhite.png",
    ],
    'name': "PLAIN CASHEW KERNELS W320",
    'category': [
      {
        'weight': "250GM",
        'description':
            "Plain W320 (250 gram), Price Rs.581 (GST Inclusive), Product available only in India, Shipping and other Charges:- Kerala 8% ,South India 13%, Other States 18% will be added with the price for completing the ordering procedure.",
        'offerPrice': "197",
        'originalPrice': "296",
        'rating': "5",
        'haveStock': true,
      },
      {
        'weight': "500GM",
        'description':
            "Plain W320 (500 gram), Price Rs.581 (GST Inclusive), Product available only in India, Shipping and other Charges:- Kerala 8% ,South India 13%, Other States 18% will be added with the price for completing the ordering procedure.",
        'offerPrice': "387",
        'originalPrice': "581",
        'rating': "50",
        'haveStock': true,
      },
      {
        'weight': "1KG",
        'description':
            "Plain W320 (1 kilo gram), Price Rs.581 (GST Inclusive), Product available only in India, Shipping and other Charges:- Kerala 8% ,South India 13%, Other States 18% will be added with the price for completing the ordering procedure.",
        'offerPrice': "767",
        'originalPrice': "1150",
        'rating': "530",
        'haveStock': true,
      },
    ]
  },
  {
    'imagePath': [
      "lib/core/assets/images/product_images/Plain Cashew/Plain Cashew (F) bgwhite.png",
      "lib/core/assets/images/product_images/Plain Cashew/Plain cashew (B) bgwhite.png",
    ],
    'name': "PLAIN CASHEW KERNELS W450",
    'category': [
      {
        'weight': "250GM",
        'description':
            "Plain W320 (250 gram), Price Rs.581 (GST Inclusive), Product available only in India, Shipping and other Charges:- Kerala 8% ,South India 13%, Other States 18% will be added with the price for completing the ordering procedure.",
        'offerPrice': "180.67",
        'originalPrice': "271",
        'rating': "590",
        'haveStock': true,
      },
      {
        'weight': "500GM",
        'description':
            "Plain W320 (500 gram), Price Rs.581 (GST Inclusive), Product available only in India, Shipping and other Charges:- Kerala 8% ,South India 13%, Other States 18% will be added with the price for completing the ordering procedure.",
        'offerPrice': "354",
        'originalPrice': "531",
        'rating': "560",
        'haveStock': true,
      },
      {
        'weight': "1KG",
        'description':
            "Plain W320 (1 kilo gram), Price Rs.581 (GST Inclusive), Product available only in India, Shipping and other Charges:- Kerala 8% ,South India 13%, Other States 18% will be added with the price for completing the ordering procedure.",
        'offerPrice': "700",
        'originalPrice': "1050",
        'rating': "510",
        'haveStock': true,
      },
    ]
  },
];

const List roastedCashewsList = [
  {
    'imagePath': [
      "lib/core/assets/images/product_images/Roasted and Salted Cashew/Roasted and salted Cashew bgwhite.png",
    ],
    'name': "ROASTED & SALTED CASHEW W180",
    'category': [
      {
        'weight': "250GM",
        'description':
            "Plain W320 (250 gram), Price Rs.581 (GST Inclusive), Product available only in India, Shipping and other Charges:- Kerala 8% ,South India 13%, Other States 18% will be added with the price for completing the ordering procedure.",
        'offerPrice': "315.63",
        'originalPrice': "505",
        'rating': "890",
        'haveStock': false,
      },
      {
        'weight': "500GM",
        'description':
            "Plain W320 (500 gram), Price Rs.581 (GST Inclusive), Product available only in India, Shipping and other Charges:- Kerala 8% ,South India 13%, Other States 18% will be added with the price for completing the ordering procedure.",
        'offerPrice': "625",
        'originalPrice': "1000",
        'rating': "560",
        'haveStock': true,
      },
    ]
  },
  {
    'imagePath': [
      "lib/core/assets/images/product_images/Roasted and Salted Cashew/Roasted and salted Cashew bgwhite.png",
    ],
    'name': "ROASTED & SALTED CASHEW W240",
    'category': [
      {
        'weight': "250GM",
        'description':
            "Plain W320 (250 gram), Price Rs.581 (GST Inclusive), Product available only in India, Shipping and other Charges:- Kerala 8% ,South India 13%, Other States 18% will be added with the price for completing the ordering procedure.",
        'offerPrice': "235.63",
        'originalPrice': "377",
        'rating': "890",
        'haveStock': true,
      },
      {
        'weight': "500GM",
        'description':
            "Plain W320 (500 gram), Price Rs.581 (GST Inclusive), Product available only in India, Shipping and other Charges:- Kerala 8% ,South India 13%, Other States 18% will be added with the price for completing the ordering procedure.",
        'offerPrice': "464.38",
        'originalPrice': "743",
        'rating': "560",
        'haveStock': true,
      },
    ]
  },
  {
    'imagePath': [
      "lib/core/assets/images/product_images/Roasted and Salted Cashew/Roasted and salted Cashew bgwhite.png",
    ],
    'name': "ROASTED & SALTED CASHEW W320",
    'category': [
      {
        'weight': "250GM",
        'description':
            "Plain W320 (250 gram), Price Rs.581 (GST Inclusive), Product available only in India, Shipping and other Charges:- Kerala 8% ,South India 13%, Other States 18% will be added with the price for completing the ordering procedure.",
        'offerPrice': "215.63",
        'originalPrice': "345",
        'rating': "890",
        'haveStock': true,
      },
      {
        'weight': "500GM",
        'description':
            "Plain W320 (500 gram), Price Rs.581 (GST Inclusive), Product available only in India, Shipping and other Charges:- Kerala 8% ,South India 13%, Other States 18% will be added with the price for completing the ordering procedure.",
        'offerPrice': "424.38",
        'originalPrice': "679",
        'rating': "560",
        'haveStock': true,
      },
    ]
  },
];

List allFeaturedProductsList = cashewsPlaneList + roastedCashewsList + valueAddedProducts;

const List productDetailsList1 = [
  {
    'imagePath': [
      "lib/core/assets/images/product_images/Cashew Apple Squash/Cashew apple squash.jpg",
    ],
    'name': "Cashew apple squash",
    'description': "Neque porro quisquam est qui dolorem ipsum quia",
    'offerPrice': "1500",
    'originalPrice': "2499",
    'offerPercentage': "40%Off",
    'rating': "890",
    'haveStock': true,
  },
  {
    'imagePath': [
      "lib/core/assets/images/product_images/Cashew Pine Jam/Cashew pine jam.jpg",
    ],
    'name': "Cashew pine jam",
    'description': "Neque porro quisquam est qui dolorem ipsum quia",
    'offerPrice': "1500",
    'originalPrice': "2499",
    'offerPercentage': "40%Off",
    'rating': "560",
    'haveStock': true,
  },
  {
    'imagePath': [
      "lib/core/assets/images/product_images/Cashew Powder/Cashew Powder 1.jpg",
      "lib/core/assets/images/product_images/Cashew Powder/Cashew Powder 2.jpg",
      "lib/core/assets/images/product_images/Cashew Powder/Cashew Powder 3.jpg",
      "lib/core/assets/images/product_images/Cashew Powder/Cashew Powder 4.jpg",
    ],
    'name': "Cashew Powdre",
    'description': "Neque porro quisquam est qui dolorem ipsum quia",
    'offerPrice': "1500",
    'originalPrice': "2499",
    'offerPercentage': "40%Off",
    'rating': "890",
    'haveStock': true,
  },
  {
    'imagePath': [
      "lib/core/assets/images/product_images/Cashew Soda/Cashew soda.jpg",
    ],
    'name': "Cashew soda",
    'description': "Neque porro quisquam est qui dolorem ipsum quia",
    'offerPrice': "1500",
    'originalPrice': "2499",
    'offerPercentage': "40%Off",
    'rating': "560",
    'haveStock': true,
  },
  {
    'imagePath': [
      "lib/core/assets/images/product_images/Cashew Soup/Cashew Soup-mix .jpg",
      "lib/core/assets/images/product_images/Cashew Soup/Cashew Soup.jpg",
    ],
    'name': "Cashew Soup",
    'description': "Neque porro quisquam est qui dolorem ipsum quia",
    'offerPrice': "1500",
    'originalPrice': "2499",
    'offerPercentage': "40%Off",
    'rating': "890",
    'haveStock': true,
  },
  {
    'imagePath': [
      "lib/core/assets/images/product_images/Cashew Vanilla MilkShake/Cashew Vanilla Milk Shake Powder.jpg",
    ],
    'name': "Cashew Vanilla Milk Shake Powder",
    'description': "Neque porro quisquam est qui dolorem ipsum quia",
    'offerPrice': "1500",
    'originalPrice': "2499",
    'offerPercentage': "40%Off",
    'rating': "560",
    'haveStock': true,
  },
  {
    'imagePath': [
      "lib/core/assets/images/product_images/Cashew Vita/Cashew Vita.jpg",
    ],
    'name': "Cashew Vita",
    'description': "Neque porro quisquam est qui dolorem ipsum quia",
    'offerPrice': "1500",
    'originalPrice': "2499",
    'offerPercentage': "40%Off",
    'rating': "56890",
    'haveStock': true,
  },
  {
    'imagePath': [
      "lib/core/assets/images/product_images/Cashew Vita Cardamom flavoured/Cashew vita cardamom flavoured.jpg",
    ],
    'name': "Cashew vita cardamom flavoured",
    'description': "Neque porro quisquam est qui dolorem ipsum quia",
    'offerPrice': "1500",
    'originalPrice': "2499",
    'offerPercentage': "40%Off",
    'rating': "56890",
    'haveStock': true,
  },
  {
    'imagePath': [
      "lib/core/assets/images/product_images/Cashew Vita Chocolate Flavoured/Cashew Vita Chocolate Flavoured 1.jpg",
      "lib/core/assets/images/product_images/Cashew Vita Chocolate Flavoured/Cashew vita chocolate flavoured.jpg",
    ],
    'name': "Cashew Vita Chocolate Flavoured",
    'description': "Neque porro quisquam est qui dolorem ipsum quia",
    'offerPrice': "1500",
    'originalPrice': "2499",
    'offerPercentage': "40%Off",
    'rating': "56890",
    'haveStock': true,
  },
  {
    'imagePath': [
      "lib/core/assets/images/product_images/Cashew Vita Pistachio flavoured/Cashew vita Pistachio flavoured.jpg",
    ],
    'name': "Cashew Vita Pistachio flavoured",
    'description': "Neque porro quisquam est qui dolorem ipsum quia",
    'offerPrice': "1500",
    'originalPrice': "2499",
    'offerPercentage': "40%Off",
    'rating': "56890",
    'haveStock': true,
  },
  {
    'imagePath': [
      "lib/core/assets/images/product_images/Chilli Garlic/Chilly Garlic.jpg",
    ],
    'name': "Chilly Garlic.",
    'description': "Neque porro quisquam est qui dolorem ipsum quia",
    'offerPrice': "1500",
    'originalPrice': "2499",
    'offerPercentage': "40%Off",
    'rating': "56890",
    'haveStock': true,
  },
];

const List valueAddedProducts = [
  {
    'imagePath': [
      "lib/core/assets/images/product_images/Cashew Powder/Cashew Powder 1.jpg",
      "lib/core/assets/images/product_images/Cashew Powder/Cashew Powder 2.jpg",
      "lib/core/assets/images/product_images/Cashew Powder/Cashew Powder 3.jpg",
      "lib/core/assets/images/product_images/Cashew Powder/Cashew Powder 4.jpg",
    ],
    'name': "POWDER",
    'category': [
      {
        'weight': "100GM",
        'description':
            "Plain W320 (250 gram), Price Rs.581 (GST Inclusive), Product available only in India, Shipping and other Charges:- Kerala 8% ,South India 13%, Other States 18% will be added with the price for completing the ordering procedure.",
        'offerPrice': "289",
        'originalPrice': "433",
        'rating': "56890",
        'haveStock': true,
      },
    ]
  },
  {
    'imagePath': [
      "lib/core/assets/images/product_images/Cashew Vita/Cashew Vita.jpg",
    ],
    'name': "VITA",
    'category': [
      {
        'weight': "250GM",
        'description':
            "Plain W320 (250 gram), Price Rs.581 (GST Inclusive), Product available only in India, Shipping and other Charges:- Kerala 8% ,South India 13%, Other States 18% will be added with the price for completing the ordering procedure.",
        'offerPrice': "238",
        'originalPrice': "357",
        'rating': "56890",
        'haveStock': true,
      },
    ]
  },
  {
    'imagePath': [
      "lib/core/assets/images/product_images/Cashew Soup/Cashew Soup.jpg",
      "lib/core/assets/images/product_images/Cashew Soup/Cashew Soup-mix.jpg",
    ],
    'name': "SOUP MIX",
    'category': [
      {
        'weight': "65GM",
        'description':
            "Plain W320 (250 gram), Price Rs.581 (GST Inclusive), Product available only in India, Shipping and other Charges:- Kerala 8% ,South India 13%, Other States 18% will be added with the price for completing the ordering procedure.",
        'offerPrice': "215",
        'originalPrice': "323",
        'rating': "56890",
        'haveStock': true,
      },
    ]
  },
];
const List productDetailsList2 = [
  {
    'imagePath': [
      "lib/core/assets/images/product_images/Plain Cashew/Plain cashew (B) bgwhite.png",
      "lib/core/assets/images/product_images/Plain Cashew/Plain Cashew (F) bgwhite.png",
    ],
    'name': "PLAIN CASHEW",
    'category': [
      {
        'weight': "100GM",
        'description':
            "Plain W320 (250 gram), Price Rs.581 (GST Inclusive), Product available only in India, Shipping and other Charges:- Kerala 8% ,South India 13%, Other States 18% will be added with the price for completing the ordering procedure.",
        'offerPrice': "289",
        'originalPrice': "433",
        'rating': "56890",
        'haveStock': true,
      },
    ]
  },
  {
    'imagePath': [
      "lib/core/assets/images/product_images/Chilly Coated/Red Chilly Coated Cashew.jpg",
    ],
    'name': "RED CHILLY COATED CASHEW",
    'category': [
      {
        'weight': "250GM",
        'description':
            "Plain W320 (250 gram), Price Rs.581 (GST Inclusive), Product available only in India, Shipping and other Charges:- Kerala 8% ,South India 13%, Other States 18% will be added with the price for completing the ordering procedure.",
        'offerPrice': "238",
        'originalPrice': "357",
        'rating': "56890",
        'haveStock': true,
      },
    ]
  },
  {
    'imagePath': [
      "lib/core/assets/images/product_images/Honey Coated/Honey Coated Cashew.jpg",
    ],
    'name': "HONEY COATED CASHEW",
    'category': [
      {
        'weight': "65GM",
        'description':
            "Plain W320 (250 gram), Price Rs.581 (GST Inclusive), Product available only in India, Shipping and other Charges:- Kerala 8% ,South India 13%, Other States 18% will be added with the price for completing the ordering procedure.",
        'offerPrice': "215",
        'originalPrice': "323",
        'rating': "56890",
        'haveStock': true,
      },
    ]
  },
];

// const List productDetailsList2 = [
//   {
//     'imagePath': [
//       "lib/core/assets/images/product_images/Plain Cashew/Plain cashew (B) bgwhite.png",
//       "lib/core/assets/images/product_images/Plain Cashew/Plain Cashew (F) bgwhite.png",
//     ],
//     'name': "Plain cashew ",
//     'description': "Neque porro quisquam est qui dolorem ipsum quia",
//     'offerPrice': "1500",
//     'originalPrice': "2499",
//     'offerPercentage': "40%Off",
//     'rating': "56890
// 'haveStock':true,",
//   },
//   {
//     'imagePath': [
//       "lib/core/assets/images/product_images/Chilly Coated/Red Chilly Coated Cashew.jpg",
//     ],
//     'name': "Red Chilly Coated Cashew",
//     'description': "Neque porro quisquam est qui dolorem ipsum quia",
//     'offerPrice': "1500",
//     'originalPrice': "2499",
//     'offerPercentage': "40%Off",
//     'rating': "56890
// 'haveStock':true,",
//   },
//   {
//     'imagePath': [
//       "lib/core/assets/images/product_images/Honey Coated/Honey Coated Cashew.jpg",
//     ],
//     'name': "Honey Coated Cashew",
//     'description': "Neque porro quisquam est qui dolorem ipsum quia",
//     'offerPrice': "1500",
//     'originalPrice': "2499",
//     'offerPercentage': "40%Off",
//     'rating': "56890
// 'haveStock':true,",
//   },
//   {
//     'imagePath': [
//       "lib/core/assets/images/product_images/Roasted and Salted Cashew/Roasted and salted Cashew bgwhite.png",
//     ],
//     'name': "Roasted and salted Cashew",
//     'description': "Neque porro quisquam est qui dolorem ipsum quia",
//     'offerPrice': "1500",
//     'originalPrice': "2499",
//     'offerPercentage': "40%Off",
//     'rating': "56890
// 'haveStock':true,",
//   },
//   {
//     'imagePath': [
//       "lib/core/assets/images/product_images/Salt and Pepper/Salt and Pepper.jpg",
//     ],
//     'name': "Salt and Pepper",
//     'description': "Neque porro quisquam est qui dolorem ipsum quia",
//     'offerPrice': "1500",
//     'originalPrice': "2499",
//     'offerPercentage': "40%Off",
//     'rating': "56890
// 'haveStock':true,",
//   },
// ];

List fullProductsList = [productDetailsList1 + productDetailsList2];
