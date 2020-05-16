import 'package:equatable/equatable.dart';

abstract class BaseModel implements Equatable {
  Map<String, Object> toMap();
}