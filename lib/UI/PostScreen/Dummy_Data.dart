import 'CategoryClass.dart';
import 'package:flutter/material.dart';

import 'CategoryDetailsClass.dart';

const Dummy_Categories = const [
  Category(
    id: 'c1',
    title: 'Buying a home',
  ),
  Category(
    id: 'c2',
    title: 'Renting a home',
  ),
  Category(
    id: 'c3',
    title: 'Sell or Rent Your Propery/Building',
  ),
  Category(
    id: 'c4',
    title: 'Paying Guest',
  ),
  Category(
    id: 'c5',
    title: 'Co-living spaces for Male',
  ),
  Category(
    id: 'c6',
    title: 'Co-living spaces for Female',
  ),
  Category(
    id: 'c7',
    title: 'Buy Commercial property',
  ),
  Category(
    id: 'c8',
    title: 'Rent Commercial property',
  ),
];

const Dummy_CategoryDetails = const [
  CategoryDetails(
      id: "cd1",
      categories: [
        'c1',
      ],
      title: "Nobab Villa",
      address: "Shekhghat",
      price: "20,00,000",
      imageUrl: 'https://images.unsplash.com/photo-1613977257363-707ba9348227?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
  ),
  CategoryDetails(
    id: "cd2",
    categories: [
      'c1',
    ],
    title: "Heaven",
    address: "Uposohor",
    price: "18,00,000",
    imageUrl: 'https://images.unsplash.com/photo-1564501049412-61c2a3083791?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1032&q=80',
  ),
  CategoryDetails(
    id: "cd3",
    categories: [
      'c1',
    ],
    title: "Momtaz Cottage",
    address: "Pathantula",
    price: "22,00,000",
    imageUrl: 'https://images.unsplash.com/photo-1581974206939-b42731ea9dc9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
  ),
  CategoryDetails(
    id: "cd4",
    categories: [
      'c1',
    ],
    title: "Shanti Bari",
    address: "Pirerbazar",
    price: "25,00,000",
    imageUrl: 'https://images.unsplash.com/photo-1603382401636-c352fb5755ec?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
  ),
  CategoryDetails(
    id: "cd5",
    categories: [
      'c1',
    ],
    title: "Moyur Kunjjo",
    address: "Modina Market",
    price: "30,00,000",
    imageUrl: 'https://images.unsplash.com/photo-1582610116397-edb318620f90?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
  ),
  CategoryDetails(
    id: "cd6",
    categories: [
      'c2',
    ],
    title: "Jamal Monjil",
    address: "Lamabazar",
    price: "25,000",
    imageUrl: 'https://images.unsplash.com/photo-1630650231815-a567e2ed26cc?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
  ),
  CategoryDetails(
    id: "cd7",
    categories: [
      'c2',
    ],
    title: "Ashraf Villa",
    address: "Rikabi Bazar",
    price: "15,000",
    imageUrl: 'https://images.unsplash.com/photo-1544984243-ec57ea16fe25?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
  ),
  CategoryDetails(
    id: "cd8",
    categories: [
      'c2',
    ],
    title: "Ali Cottage",
    address: "Medical Road",
    price: "30,000",
    imageUrl: 'https://images.unsplash.com/photo-1505843513577-22bb7d21e455?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1032&q=80',
  ),
  CategoryDetails(
    id: "cd9",
    categories: [
      'c3',
    ],
    title: "Wasif Villa",
    address: "Bagbari",
    price: "15,00,000",
    imageUrl: 'https://images.unsplash.com/photo-1628744448840-55bdb2497bd4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
  ),
  CategoryDetails(
    id: "cd10",
    categories: [
      'c3',
    ],
    title: "Rezwan Villa",
    address: "Sust Gate",
    price: "18,00,000",
    imageUrl: 'https://images.unsplash.com/photo-1531971589569-0d9370cbe1e5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=881&q=80',
  ),
  CategoryDetails(
    id: "cd11",
    categories: [
      'c3',
    ],
    title: "Emran Monjil",
    address: "Akhalia",
    price: "20,00,000",
    imageUrl: 'https://images.unsplash.com/photo-1630650233871-35a35ff27095?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=871&q=80',
  ),
  CategoryDetails(
    id: "cd12",
    categories: [
      'c4',
    ],
    title: "Rumi Holdings",
    address: "Pathantula",
    price: "2,000",
    imageUrl: 'https://images.unsplash.com/photo-1594540992254-0e2239661647?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=869&q=80',
  ),
  CategoryDetails(
    id: "cd13",
    categories: [
      'c4',
    ],
    title: "Fatema Villa",
    address: "Tati Para",
    price: "3,000",
    imageUrl: 'https://images.unsplash.com/photo-1513584684374-8bab748fbf90?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=865&q=80',
  ),
  CategoryDetails(
    id: "cd14",
    categories: [
      'c4',
    ],
    title: "Rahena Cottage",
    address: "Haowa Para",
    price: "2,500",
    imageUrl: 'https://images.unsplash.com/photo-1628744448839-a475cc0e90c3?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
  ),
  CategoryDetails(
    id: "cd15",
    categories: [
      'c5',
    ],
    title: "Ali Monjil",
    address: "Modina Market",
    price: "2,000",
    imageUrl: 'https://images.unsplash.com/photo-1515541369882-f47fa81d1454?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
  ),
  CategoryDetails(
    id: "cd16",
    categories: [
      'c5',
    ],
    title: "Hasan Villa",
    address: "AmberKhana",
    price: "2,200",
    imageUrl: 'https://images.unsplash.com/photo-1598903762144-729676d258c1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
  ),
  CategoryDetails(
    id: "cd17",
    categories: [
      'c5',
    ],
    title: "Sakib Monjil",
    address: "Lamabazar",
    price: "2,500",
    imageUrl: 'https://images.unsplash.com/photo-1630650228493-a60075b9e8e0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
  ),
  CategoryDetails(
    id: "cd18",
    categories: [
      'c6',
    ],
    title: "Kaiyum Villa",
    address: "Kuarpar",
    price: "1,200",
    imageUrl: 'https://images.unsplash.com/photo-1568092775154-7fa176a29c0f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
  ),
  CategoryDetails(
    id: "cd19",
    categories: [
      'c6',
    ],
    title: "Numan Holdings",
    address: "Vatalia",
    price: "1,500",
    imageUrl: 'https://images.unsplash.com/photo-1416331108676-a22ccb276e35?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=867&q=80',
  ),
  CategoryDetails(
    id: "cd20",
    categories: [
      'c6',
    ],
    title: "Emran Holdings",
    address: "Mirer Moydan",
    price: "1,800",
    imageUrl: 'https://images.unsplash.com/photo-1628744448953-89b6b70965c7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
  ),
  CategoryDetails(
    id: "cd21",
    categories: [
      'c7',
    ],
    title: "Sadia Commercial Complex",
    address: "Zinda Bazar",
    price: "3,00,00,000",
    imageUrl: 'https://images.unsplash.com/photo-1564166820921-2b102dad13fd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1374&q=80',
  ),
  CategoryDetails(
    id: "cd22",
    categories: [
      'c7',
    ],
    title: "Rahena Commercial Complex",
    address: "Chowhatta",
    price: "3,50,00,000",
    imageUrl: 'https://images.unsplash.com/photo-1574362848149-11496d93a7c7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=784&q=80',
  ),
  CategoryDetails(
    id: "cd23",
    categories: [
      'c7',
    ],
    title: "Nuzhat Commercial Complex",
    address: "Subid Bazar",
    price: "4,00,00,000",
    imageUrl: 'https://images.unsplash.com/photo-1565363887715-8884629e09ee?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=388&q=80',
  ),
  CategoryDetails(
    id: "cd24",
    categories: [
      'c8',
    ],
    title: "Nowshin Commercial Complex",
    address: "Housing Estate",
    price: "1,00,000",
    imageUrl: 'https://images.unsplash.com/photo-1565777078232-a10610205e8b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=327&q=80',
  ),
  CategoryDetails(
    id: "cd25",
    categories: [
      'c8',
    ],
    title: "Fatema Commercial Complex",
    address: "Subid Bazar",
    price: "1,50,000",
    imageUrl: 'https://images.unsplash.com/photo-1601039913996-d74e58095333?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=800&q=80',
  ),
  CategoryDetails(
    id: "cd26",
    categories: [
      'c8',
    ],
    title: "Ali Commercial Complex",
    address: "Modina Market",
    price: "1,20,000",
    imageUrl: 'https://images.unsplash.com/photo-1605022567420-76f932d7f121?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=426&q=80',
  ),
];

