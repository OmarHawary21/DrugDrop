import '../models/tag.dart';
import '../models/category.dart';
import '../providers/drug_data.dart';

class Data {
  List<Drug> drugs0 = [
    Drug(
      id: 0,
      tradeName: 'tradeName',
      scientificName: 'scientificName',
      company: 'company',
      tagId: 0,
      dose: 100,
      doseUnit: 'doseUnit',
      price: 1600,
      quantity: 15,
      expiryDate: 'expiryDate',
      imageUrl: 'imageUrl',
    ),
    Drug(
      id: 1,
      tradeName: 'tradeName1',
      scientificName: 'scientificName1',
      company: 'company',
      tagId: 0,
      dose: 100,
      doseUnit: 'doseUnit',
      price: 1600,
      quantity: 15,
      expiryDate: 'expiryDate',
      imageUrl: 'imageUrl',
    ),
    Drug(
      id: 2,
      tradeName: 'tradeName2',
      scientificName: 'scientificName2',
      company: 'company',
      tagId: 0,
      dose: 100,
      doseUnit: 'doseUnit',
      price: 1600,
      quantity: 15,
      expiryDate: 'expiryDate',
      imageUrl: 'imageUrl',
    ),
    Drug(
      id: 3,
      tradeName: 'tradeName3',
      scientificName: 'scientificName3',
      company: 'company',
      tagId: 0,
      dose: 100,
      doseUnit: 'doseUnit',
      price: 1600,
      quantity: 15,
      expiryDate: 'expiryDate',
      imageUrl: 'imageUrl',
    ),
  ];

  List<Drug> drugs1 = [
    Drug(
      id: 0,
      tradeName: 'tradeName',
      scientificName: 'scientificName',
      company: 'company',
      tagId: 1,
      dose: 100,
      doseUnit: 'doseUnit',
      price: 1600,
      quantity: 15,
      expiryDate: 'expiryDate',
      imageUrl: 'imageUrl',
    ),
    Drug(
      id: 1,
      tradeName: 'tradeName1',
      scientificName: 'scientificName1',
      company: 'company',
      tagId: 1,
      dose: 100,
      doseUnit: 'doseUnit',
      price: 1600,
      quantity: 15,
      expiryDate: 'expiryDate',
      imageUrl: 'imageUrl',
    ),
    Drug(
      id: 2,
      tradeName: 'tradeName2',
      scientificName: 'scientificName2',
      company: 'company',
      tagId: 1,
      dose: 100,
      doseUnit: 'doseUnit',
      price: 1600,
      quantity: 15,
      expiryDate: 'expiryDate',
      imageUrl: 'imageUrl',
    ),
    Drug(
      id: 3,
      tradeName: 'tradeName3',
      scientificName: 'scientificName3',
      company: 'company',
      tagId: 1,
      dose: 100,
      doseUnit: 'doseUnit',
      price: 1600,
      quantity: 15,
      expiryDate: 'expiryDate',
      imageUrl: 'imageUrl',
    ),
  ];

  late List<Tag> tags0 = [
    Tag(
      id: 0,
      name: 'pills0',
      drugs: drugs0,
    ),
    Tag(
      id: 1,
      name: 'drinks0',
      drugs: drugs1,
    ),
  ];

  late List<Tag> tags1 = [
    Tag(
      id: 0,
      name: 'pills1',
      drugs: drugs0,
    ),
    Tag(
      id: 1,
      name: 'drinks1',
      drugs: drugs1,
    ),
  ];

  late List<Tag> tags2 = [
    Tag(
      id: 0,
      name: 'pills2',
      drugs: drugs0,
    ),
    Tag(
      id: 1,
      name: 'drinks2',
      drugs: drugs1,
    ),
  ];

  late List<Categories> categories = [
    Categories(
      id: 0,
      name: 'Antibiotics',
      tags: tags0,
    ),
    Categories(
      id: 1,
      name: 'Analgesics',
      tags: tags1,
    ),
    Categories(
      id: 2,
      name: 'Heart Medications',
      tags: tags2,
    ),
  ];
}
