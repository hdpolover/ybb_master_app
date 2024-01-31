import 'package:ybb_master_app/core/models/admin/admin.dart';
import 'package:ybb_master_app/core/models/program.dart';
import 'package:ybb_master_app/core/models/program_category.dart';

Admin currentAdmin = Admin(
    1,
    'Admin',
    'admin@ybb.com',
    '1234'
        'https://png.pngtree.com/png-vector/20211023/ourmid/pngtree-salon-logo-png-image_4004444.png',
    'superadmin');

List<ProgramCategory> programCategories = [
  ProgramCategory(
    id: 1,
    name: 'Istanbul Youth Summit',
    description:
        'Istanbul Youth Summit is an international summit which brings together both Turkish and foreign young people from all over the world to establish a bridge between “East” and “West” and “North” and “South”.',
    image:
        'https://png.pngtree.com/png-vector/20211023/ourmid/pngtree-salon-logo-png-image_4004444.png',
  ),
  ProgramCategory(
    id: 2,
    name: 'Japan Youth Summit',
    description:
        'Japan Youth Summit is an international summit which brings together both Japanese and foreign young people from all over the world to establish a bridge between “East” and “West” and “North” and “South”.',
    image:
        // find an image of japan
        'https://png.pngtree.com/png-vector/20211023/ourmid/pngtree-salon-logo-png-image_4004444.png',
  ),
];

List<Program> programs = [
  Program(
    id: 1,
    name: 'Istanbul Youth Summit 2021',
    description:
        'Istanbul Youth Summit is an international summit which brings together both Turkish and foreign young people from all over the world to establish a bridge between “East” and “West” and “North” and “South”.',
    image:
        'https://png.pngtree.com/png-vector/20211023/ourmid/pngtree-salon-logo-png-image_4004444.png',
    programCategory: programCategories[0],
    isActive: false,
  ),
  Program(
    id: 1,
    name: 'Istanbul Youth Summit 2024',
    description:
        'Istanbul Youth Summit is an international summit which brings together both Turkish and foreign young people from all over the world to establish a bridge between “East” and “West” and “North” and “South”.',
    image:
        'https://png.pngtree.com/png-vector/20211023/ourmid/pngtree-salon-logo-png-image_4004444.png',
    programCategory: programCategories[0],
    isActive: true,
  ),
  Program(
    id: 2,
    name: 'Japan Youth Summit 2021',
    description:
        'Japan Youth Summit is an international summit which brings together both Japanese and foreign young people from all over the world to establish a bridge between “East” and “West” and “North” and “South”.',
    image:
        // find an image of japan
        'https://png.pngtree.com/png-vector/20211023/ourmid/pngtree-salon-logo-png-image_4004444.png',
    programCategory: programCategories[1],
    isActive: false,
  ),
];
