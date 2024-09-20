// Copyright 2024 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import Foundation

/// A `Schema` object allows the definition of input and output data types.
///
/// These types can be objects, but also primitives and arrays. Represents a select subset of an
/// [OpenAPI 3.0 schema object](https://spec.openapis.org/oas/v3.0.3#schema).
public class Schema {
  /// The data type.
  let type: DataType

  /// The format of the data.
  let format: String?

  /// A brief description of the parameter.
  let description: String?

  /// Indicates if the value may be null.
  let nullable: Bool?

  /// Possible values of the element of type ``DataType/string`` with "enum" format.
  let enumValues: [String]?

  /// Schema of the elements of type ``DataType/array``.
  let items: Schema?

  /// Properties of type ``DataType/object``.
  let properties: [String: Schema]?

  /// Required properties of type ``DataType/object``.
  let requiredProperties: [String]?
  
  /// Minimum value for numeric types.
  let minimum: Double?
  
  /// Maximum value for numeric types.
  let maximum: Double?
  
  /// Minimum length for string types.
  let minLength: Int?
  
  /// Maximum length for string types.
  let maxLength: Int?
  
  /// Regular expression pattern for string types.
  let pattern: String?
  
  /// Minimum number of elements for array types.
  let minItems: Int?
  
  /// Maximum number of elements for array types.
  let maxItems: Int?

  /// Constructs a new `Schema`.
  ///
  /// - Parameters:
  ///   - type: The data type.
  ///   - format: The format of the data; used only for primitive datatypes.
  ///     Supported formats:
  ///     - ``DataType/integer``: int32, int64
  ///     - ``DataType/number``: float, double
  ///     - ``DataType/string``: enum
  ///   - description: A brief description of the parameter; may be formatted as Markdown.
  ///   - nullable: Indicates if the value may be null.
  ///   - enumValues: Possible values of the element of type ``DataType/string`` with "enum" format.
  ///     For example, an enum `Direction` may be defined as `["EAST", NORTH", "SOUTH", "WEST"]`.
  ///   - items: Schema of the elements of type ``DataType/array``.
  ///   - properties: Properties of type ``DataType/object``.
  ///   - requiredProperties: Required properties of type ``DataType/object``.
  ///   - minimum: Minimum value for numeric types.
  ///   - maximum: Maximum value for numeric types.
  ///   - minLength: Minimum length for string types.
  ///   - maxLength: Maximum length for string types.
  ///   - pattern: Regular expression pattern for string types.
  ///   - minItems: Minimum number of elements for array types.
  ///   - maxItems: Maximum number of elements for array types.
  public init(type: DataType, format: String? = nil, description: String? = nil,
              nullable: Bool? = nil,
              enumValues: [String]? = nil, items: Schema? = nil,
              properties: [String: Schema]? = nil,
              requiredProperties: [String]? = nil,
              minimum: Double? = nil, maximum: Double? = nil,
              minLength: Int? = nil, maxLength: Int? = nil,
              pattern: String? = nil,
              minItems: Int? = nil, maxItems: Int? = nil) {
    self.type = type
    self.format = format
    self.description = description
    self.nullable = nullable
    self.enumValues = enumValues
    self.items = items
    self.properties = properties
    self.requiredProperties = requiredProperties
    self.minimum = minimum
    self.maximum = maximum
    self.minLength = minLength
    self.maxLength = maxLength
    self.pattern = pattern
    self.minItems = minItems
    self.maxItems = maxItems
  }
}

/// A data type.
///
/// Contains the set of OpenAPI [data types](https://spec.openapis.org/oas/v3.0.3#data-types).
public enum DataType: String {
  /// A `String` type.
  case string = "STRING"

  /// A floating-point number type.
  case number = "NUMBER"

  /// An integer type.
  case integer = "INTEGER"

  /// A boolean type.
  case boolean = "BOOLEAN"

  /// An array type.
  case array = "ARRAY"

  /// An object type.
  case object = "OBJECT"
}

// MARK: - Codable Conformance

extension Schema: Encodable {
  enum CodingKeys: String, CodingKey {
    case type
    case format
    case description
    case nullable
    case enumValues = "enum"
    case items
    case properties
    case requiredProperties = "required"
    case minimum
    case maximum
    case minLength
    case maxLength
    case pattern
    case minItems
    case maxItems
  }
}

extension DataType: Encodable {}
