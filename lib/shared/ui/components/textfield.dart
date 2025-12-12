import 'package:apex_global_mobility_test/shared/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AgmTextField extends StatefulWidget {
  const AgmTextField({
    required this.labelText,
    this.hintText,
    this.maxLength,
    this.maxLines = 1,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.borderRadius,
    this.controller,
    this.onChanged,
    this.readOnly = false,
    this.initialValue,
    this.focusNode,
    this.autofocus = false,
    this.keyboardType,
    this.inputFormatters,
    this.errorText,
    super.key,
  });

  final String labelText;
  final String? hintText;
  final int? maxLength;
  final int? maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final BorderRadius? borderRadius;
  final bool readOnly;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? initialValue;
  final FocusNode? focusNode;
  final bool autofocus;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? errorText;

  @override
  State<AgmTextField> createState() => _AgmTextFieldState();
}

class _AgmTextFieldState extends State<AgmTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: UIPadding.vertical_8,
      child: TextFormField(
        enableInteractiveSelection: false,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
        autofocus: widget.autofocus,
        readOnly: widget.readOnly,
        onTap: widget.onTap,
        initialValue: widget.initialValue,
        controller: widget.controller,
        onChanged: widget.onChanged,
        focusNode: widget.focusNode,
        maxLines: widget.maxLines,
        maxLength: widget.maxLength,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          floatingLabelAlignment: FloatingLabelAlignment.start,
          counterText: "",
          errorText: widget.errorText,
          filled: true,
          fillColor: Theme.of(context).colorScheme.surfaceContainerHigh,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
          labelText: widget.labelText,
          hintText: widget.hintText,
          border: OutlineInputBorder(
            borderRadius: widget.borderRadius ?? UIBorderRadius.medium,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: widget.borderRadius ?? UIBorderRadius.medium,
            borderSide: const BorderSide(color: Colors.blue, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: widget.borderRadius ?? UIBorderRadius.medium,
            borderSide: const BorderSide(color: Colors.white),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}
