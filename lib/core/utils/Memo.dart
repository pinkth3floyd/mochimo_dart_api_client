import 'dart:typed_data';
import 'dart:convert';

import 'package:flutter/foundation.dart';

/**
 * Validates a transaction memo according to MDST reference field rules:
 * - Contains only uppercase [A-Z], digits [0-9], dash [-]
 * - Groups can be multiple uppercase OR digits (not both)
 * - Dashes must separate different group types
 * - Cannot have consecutive groups of the same type
 * - Cannot start or end with a dash
 *
 * Valid examples: "AB-00-EF", "123-CDE-789", "ABC", "123"
 * Invalid examples: "AB-CD-EF", "123-456-789", "ABC-", "-123"
 *
 * @param memo - The memo string to validate
 * @returns true if valid, false otherwise
 */
bool isValidMemo(String? memo) {
  // Empty memo is valid (will be null-terminated)
  if (memo == null || memo.isEmpty) return true;

  // Check for invalid characters
  if (!RegExp(r'^[A-Z0-9-]+$').hasMatch(memo)) {
    return false;
  }

  // Cannot start or end with dash
  if (memo.startsWith('-') || memo.endsWith('-')) {
    return false;
  }

  // Split into groups by dash
  final groups = memo.split('-');

  // Check each group and the relationship between consecutive groups
  for (int i = 0; i < groups.length; i++) {
    final group = groups[i];

    // Empty group is invalid
    if (group.isEmpty) return false;

    // Check if group is all letters or all numbers
    final isLetters = RegExp(r'^[A-Z]+$').hasMatch(group);
    final isNumbers = RegExp(r'^[0-9]+$').hasMatch(group);

    // Group must be either all letters or all numbers
    if (!isLetters && !isNumbers) {
      return false;
    }

    // Check consecutive groups
    if (i > 0) {
      final prevGroup = groups[i - 1];
      final prevIsLetters = RegExp(r'^[A-Z]+$').hasMatch(prevGroup);

      // Cannot have consecutive groups of the same type
      if (isLetters == prevIsLetters) {
        return false;
      }
    }
  }

  return true;
}

/**
 * Formats a memo string to be compatible with MDST reference field.
 * Adds null termination and pads with zeros to 16 bytes.
 *
 * @param memo - The memo string to format
 * @returns Uint8List of 16 bytes containing the formatted memo
 */
Uint8List formatMemo(String? memo) {
  final result = Uint8List(16)..fillRange(0, 16, 0);

  if (memo == null || !isValidMemo(memo)) {
    return result;
  }

  // Convert string to bytes using ASCII encoding
  final memoBytes = utf8.encode(memo); // Assuming ASCII-compatible characters

  // Calculate the length to copy (leaving room for null termination)
  final copyLength = memoBytes.length.clamp(0, 15);

  // Copy memo bytes
  result.setRange(0, copyLength, memoBytes.sublist(0, copyLength));

  // Add null termination right after the memo content
  if (copyLength < 16) {
    result[copyLength] = 0;
  }
  debugPrint('Result (hex): ${result.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join()}');
  debugPrint('Result (ascii): ${utf8.decode(result.sublist(0, result.indexOf(0)), allowMalformed: true)}');

  return result;
}

void main() {
  debugPrint('isValidMemo tests:');
  debugPrint('"AB-00-EF": ${isValidMemo("AB-00-EF")}');   // true
  debugPrint('"123-CDE-789": ${isValidMemo("123-CDE-789")}'); // true
  debugPrint('"ABC": ${isValidMemo("ABC")}');             // true
  debugPrint('"123": ${isValidMemo("123")}');             // true
  debugPrint('"AB-CD-EF": ${isValidMemo("AB-CD-EF")}');   // false
  debugPrint('"123-456-789": ${isValidMemo("123-456-789")}'); // false
  debugPrint('"ABC-": ${isValidMemo("ABC-")}');           // false
  debugPrint('"-123": ${isValidMemo("-123")}');           // false
  debugPrint('"": ${isValidMemo("")}');                 // true
  debugPrint('null: ${isValidMemo(null)}');               // true
  debugPrint('"A-1-B": ${isValidMemo("A-1-B")}');         // true
  debugPrint('"1-A-2": ${isValidMemo("1-A-2")}');         // true
  debugPrint('"AA-BB": ${isValidMemo("AA-BB")}');       // false
  debugPrint('"11-22": ${isValidMemo("11-22")}');       // false
  debugPrint('"A--B": ${isValidMemo("A--B")}');         // false

  debugPrint('\nformatMemo tests:');
  debugPrint('"ABC": ${formatMemo("ABC")}');
  debugPrint('"123-DEF": ${formatMemo("123-DEF")}');
  debugPrint('"GHI-45": ${formatMemo("GHI-45")}');
  debugPrint('"LONG-STRING-123": ${formatMemo("LONG-STRING-123")}');
  debugPrint('"": ${formatMemo("")}');
  debugPrint('null: ${formatMemo(null)}');
  debugPrint('"INVALID-MEMO-123": ${formatMemo("INVALID-MEMO-123")}');
}