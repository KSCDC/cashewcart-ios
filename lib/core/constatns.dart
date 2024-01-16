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
    'imagePath': "lib/core/assets/images/product_images/Plain Cashew/Plain Cashew (F).png",
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
      "lib/core/assets/images/product_images/Cashew Plain2-600x600.jpg",
    ],
    'name': "PLAIN CASHEW KERNELS W320",
    'description':
        "Plain W320 (500 gram), Price Rs.581 (GST Inclusive), Product available only in India, Shipping and other Charges:- Kerala 8% ,South India 13%, Other States 18% will be added with the price for completing the ordering procedure.",
    'offerPrice': "581",
    'originalPrice': "610",
    'offerPercentage': "10%Off",
    'rating': "56890",
  },
  {
    'imagePath': [
      "lib/core/assets/images/product_images/Cashew Soup/Cashew Soup-mix .jpg",
    ],
    'name': "CASHEW SOUP MIX",
    'description':
        "Cashew Soup Mix (65 gram), Price Rs.53 (GST Inclusive), Product available only in India, Shipping and other Charges:- Kerala 8% , South India 13%, Other States 18% will be added with the price for completing the ordering procedure.",
    'offerPrice': "53",
    'originalPrice': "60",
    'offerPercentage': "10%Off",
    'rating': "56890",
  },
  {
    'imagePath': [
      "lib/core/assets/images/product_images/Cashew Plain2-600x600.jpg",
    ],
    'name': "PLAIN CASHEW KERNELS W320",
    'description': "Neque porro quisquam est qui dolorem ipsum quia",
    'offerPrice': "1500",
    'originalPrice': "2499",
    'offerPercentage': "40%Off",
    'rating': "56890",
  },
  {
    'imagePath': ["lib/core/assets/images/product_images/Cashew Plain2-600x600.jpg"],
    'name': "PLAIN CASHEW KERNELS W240",
    'description': "Neque porro quisquam est qui dolorem ipsum quia",
    'offerPrice': "1500",
    'originalPrice': "2499",
    'offerPercentage': "40%Off",
    'rating': "56890",
  },
  {
    'imagePath': ["lib/core/assets/images/product_images/Cashew Plain2-600x600.jpg"],
    'name': "PLAIN CASHEW KERNELS W320",
    'description': "Neque porro quisquam est qui dolorem ipsum quia",
    'offerPrice': "1500",
    'originalPrice': "2499",
    'offerPercentage': "40%Off",
    'rating': "56890",
  },
];

const List plainCashewsList = [
  {
    'imagePath': [
      "lib/core/assets/images/product_images/Cashew Plain2-600x600.jpg",
    ],
    'name': "PLAIN CASHEW KERNELS W320",
    'description':
        "Plain W320 (500 gram), Price Rs.581 (GST Inclusive), Product available only in India, Shipping and other Charges:- Kerala 8% ,South India 13%, Other States 18% will be added with the price for completing the ordering procedure.",
    'offerPrice': "581",
    'originalPrice': "610",
    'offerPercentage': "10%Off",
    'rating': "56890",
  },
  {
    'imagePath': [
      "lib/core/assets/images/product_images/Cashew Plain2-600x600.jpg",
    ],
    'name': "PLAIN CASHEW KERNELS W320",
    'description': "Neque porro quisquam est qui dolorem ipsum quia",
    'offerPrice': "1500",
    'originalPrice': "2499",
    'offerPercentage': "40%Off",
    'rating': "56890",
  },
  {
    'imagePath': ["lib/core/assets/images/product_images/Cashew Plain2-600x600.jpg"],
    'name': "PLAIN CASHEW KERNELS W240",
    'description': "Neque porro quisquam est qui dolorem ipsum quia",
    'offerPrice': "1500",
    'originalPrice': "2499",
    'offerPercentage': "40%Off",
    'rating': "56890",
  },
  {
    'imagePath': ["lib/core/assets/images/product_images/Cashew Plain2-600x600.jpg"],
    'name': "PLAIN CASHEW KERNELS W320",
    'description': "Neque porro quisquam est qui dolorem ipsum quia",
    'offerPrice': "1500",
    'originalPrice': "2499",
    'offerPercentage': "40%Off",
    'rating': "56890",
  },
];
const List roastedCashewsList = [
  {
    'imagePath': [
      "lib/core/assets/images/product_images/Roasted.jpg",
    ],
    'name': "PLAIN CASHEW KERNELS W320",
    'description':
        "Plain W320 (500 gram), Price Rs.581 (GST Inclusive), Product available only in India, Shipping and other Charges:- Kerala 8% ,South India 13%, Other States 18% will be added with the price for completing the ordering procedure.",
    'offerPrice': "581",
    'originalPrice': "610",
    'offerPercentage': "10%Off",
    'rating': "56890",
  },
  {
    'imagePath': [
      "lib/core/assets/images/product_images/Roasted.jpg",
    ],
    'name': "PLAIN CASHEW KERNELS W320",
    'description': "Neque porro quisquam est qui dolorem ipsum quia",
    'offerPrice': "1500",
    'originalPrice': "2499",
    'offerPercentage': "40%Off",
    'rating': "56890",
  },
  {
    'imagePath': ["lib/core/assets/images/product_images/Roasted.jpg"],
    'name': "PLAIN CASHEW KERNELS W240",
    'description': "Neque porro quisquam est qui dolorem ipsum quia",
    'offerPrice': "1500",
    'originalPrice': "2499",
    'offerPercentage': "40%Off",
    'rating': "56890",
  },
  {
    'imagePath': ["lib/core/assets/images/product_images/Roasted.jpg"],
    'name': "PLAIN CASHEW KERNELS W320",
    'description': "Neque porro quisquam est qui dolorem ipsum quia",
    'offerPrice': "1500",
    'originalPrice': "2499",
    'offerPercentage': "40%Off",
    'rating': "56890",
  },
];

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
    'rating': "56890",
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
    'rating': "56890",
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
    'rating': "56890",
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
    'rating': "56890",
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
    'rating': "56890",
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
    'rating': "56890",
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
  },
];
const List valueAddedProducts = [
  {
    'imagePath': [
      "lib/core/assets/images/product_images/Cashew Powder/Cashew Powder 1.jpg",
    ],
    'name': "CASHEW POWDER",
    'description': "Neque porro quisquam est qui dolorem ipsum quia",
    'offerPrice': "1500",
    'originalPrice': "2499",
    'offerPercentage': "40%Off",
    'rating': "56890",
  },
  {
    'imagePath': [
      "lib/core/assets/images/product_images/Cashew Soup/Cashew Soup-mix .jpg",
    ],
    'name': "CASHEW SOUP MIX",
    'description': "Neque porro quisquam est qui dolorem ipsum quia",
    'offerPrice': "1500",
    'originalPrice': "2499",
    'offerPercentage': "40%Off",
    'rating': "56890",
  },
  {
    'imagePath': [
      "lib/core/assets/images/product_images/Cashew Vita/Cashew Vita.jpg",
    ],
    'name': "CASHEW VITA",
    'description': "Neque porro quisquam est qui dolorem ipsum quia",
    'offerPrice': "1500",
    'originalPrice': "2499",
    'offerPercentage': "40%Off",
    'rating': "56890",
  },
  {
    'imagePath': [
      "lib/core/assets/images/product_images/Roasted and Salted Cashew/Roasted and salted Cashew.png",
    ],
    'name': "Roasted and salted Cashew",
    'description': "Neque porro quisquam est qui dolorem ipsum quia",
    'offerPrice': "1500",
    'originalPrice': "2499",
    'offerPercentage': "40%Off",
    'rating': "56890",
  },
  {
    'imagePath': [
      "lib/core/assets/images/product_images/Salt and Pepper/Salt and Pepper.jpg",
    ],
    'name': "Salt and Pepper",
    'description': "Neque porro quisquam est qui dolorem ipsum quia",
    'offerPrice': "1500",
    'originalPrice': "2499",
    'offerPercentage': "40%Off",
    'rating': "56890",
  },
];

const List productDetailsList2 = [
  {
    'imagePath': [
      "lib/core/assets/images/product_images/Plain Cashew/Plain cashew (B).png",
      "lib/core/assets/images/product_images/Plain Cashew/Plain Cashew (F).png",
    ],
    'name': "Plain cashew ",
    'description': "Neque porro quisquam est qui dolorem ipsum quia",
    'offerPrice': "1500",
    'originalPrice': "2499",
    'offerPercentage': "40%Off",
    'rating': "56890",
  },
  {
    'imagePath': [
      "lib/core/assets/images/product_images/Chilly Coated/Red Chilly Coated Cashew.jpg",
    ],
    'name': "Red Chilly Coated Cashew",
    'description': "Neque porro quisquam est qui dolorem ipsum quia",
    'offerPrice': "1500",
    'originalPrice': "2499",
    'offerPercentage': "40%Off",
    'rating': "56890",
  },
  {
    'imagePath': [
      "lib/core/assets/images/product_images/Honey Coated/Honey Coated Cashew.jpg",
    ],
    'name': "Honey Coated Cashew",
    'description': "Neque porro quisquam est qui dolorem ipsum quia",
    'offerPrice': "1500",
    'originalPrice': "2499",
    'offerPercentage': "40%Off",
    'rating': "56890",
  },
  {
    'imagePath': [
      "lib/core/assets/images/product_images/Roasted and Salted Cashew/Roasted and salted Cashew.png",
    ],
    'name': "Roasted and salted Cashew",
    'description': "Neque porro quisquam est qui dolorem ipsum quia",
    'offerPrice': "1500",
    'originalPrice': "2499",
    'offerPercentage': "40%Off",
    'rating': "56890",
  },
  {
    'imagePath': [
      "lib/core/assets/images/product_images/Salt and Pepper/Salt and Pepper.jpg",
    ],
    'name': "Salt and Pepper",
    'description': "Neque porro quisquam est qui dolorem ipsum quia",
    'offerPrice': "1500",
    'originalPrice': "2499",
    'offerPercentage': "40%Off",
    'rating': "56890",
  },
];

List fullProductsList = [productDetailsList1 + productDetailsList2];
