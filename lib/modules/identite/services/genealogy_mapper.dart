import '../models/genealogy_model.dart';

/// Mapper that converts between GenealogyModel and map data from OCR or storage.
class GenealogyMapper {
  GenealogyModel fromMap(Map<String, dynamic> map) {
    return GenealogyModel.fromMap(map);
  }

  Map<String, dynamic> toMap(GenealogyModel model) {
    return model.toMap();
  }
}
