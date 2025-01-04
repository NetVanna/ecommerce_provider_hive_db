// Helper class
import 'package:ecommerce_provider/models/sneaker_model.dart';
import 'package:flutter/services.dart' as the_bundle;

class Helper {
  /// Get all men's sneakers
  Future<List<Sneaker>> getMenSneakers() async {
    final data =
    await the_bundle.rootBundle.loadString("assets/json/men_shoes.json");
    final List<Sneaker> maleList = sneakersFromJson(data);
    return maleList;
  }
  /// Get a men's sneaker by ID
  Future<Sneaker> getMenSneakersById(String id) async {
    // Load the JSON file as a string
    final data =
    await the_bundle.rootBundle.loadString("assets/json/men_shoes.json");

    // Parse the JSON string into a list of sneakers
    final List<Sneaker> maleList = sneakersFromJson(data);

    // Find the sneaker with the matching ID
    final sneaker = maleList.firstWhere((sneaker) => sneaker.id == id,
        orElse: () => throw Exception("Sneaker not found"));

    return sneaker;
  }
  /// Get all women's sneakers
  Future<List<Sneaker>> getWomenSneakers() async {
    final data =
    await the_bundle.rootBundle.loadString("assets/json/women_shoes.json");
    final List<Sneaker> womenList = sneakersFromJson(data);
    return womenList;
  }
  /// Get a women's sneaker by ID
  Future<Sneaker> getWomenSneakersById(String id) async {
    // Load the JSON file as a string
    final data =
    await the_bundle.rootBundle.loadString("assets/json/women_shoes.json");

    // Parse the JSON string into a list of sneakers
    final List<Sneaker> womenList = sneakersFromJson(data);

    // Find the sneaker with the matching ID
    final sneaker = womenList.firstWhere((sneaker) => sneaker.id == id,
        orElse: () => throw Exception("Sneaker not found"));

    return sneaker;
  }
  /// Get all kid's sneakers
  Future<List<Sneaker>> getKidSneakers() async {
    final data =
    await the_bundle.rootBundle.loadString("assets/json/kids_shoes.json");
    final List<Sneaker> kidList = sneakersFromJson(data);
    return kidList;
  }
  /// Get a kid's sneaker by ID
  Future<Sneaker> getKidSneakersById(String id) async {
    // Load the JSON file as a string
    final data =
    await the_bundle.rootBundle.loadString("assets/json/kids_shoes.json");

    // Parse the JSON string into a list of sneakers
    final List<Sneaker> kidList = sneakersFromJson(data);

    // Find the sneaker with the matching ID
    final sneaker = kidList.firstWhere((sneaker) => sneaker.id == id,
        orElse: () => throw Exception("Sneaker not found"));

    return sneaker;
  }
}