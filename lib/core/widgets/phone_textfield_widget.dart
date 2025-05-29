import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneNumberTextField extends StatefulWidget {
  final String? label;
  final bool isRequired;
  final PhoneNumber number;
  final SelectorConfig? selectorConfig;
  final void Function(bool)? onInputValidated;
  final TextEditingController? controller;
  final void Function(PhoneNumber)? onInputChanged;

  const PhoneNumberTextField({
    super.key,
    this.label,
    this.selectorConfig,
    this.controller,
    required this.number,
    required this.isRequired,
    required this.onInputChanged,
    required this.onInputValidated,
  });

  @override
  State<PhoneNumberTextField> createState() => _PhoneNumberTextFieldState();
}

class _PhoneNumberTextFieldState extends State<PhoneNumberTextField> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          FormFieldsLabel(
            label: widget.label ?? 'Phone Number',
            isRequired: widget.isRequired,
          ),
        if (widget.label != null) const SizedBox(height: 8),
        InternationalPhoneNumberInput(
          selectorConfig:
              widget.selectorConfig ??
              const SelectorConfig(
                selectorType: PhoneInputSelectorType.DROPDOWN,
                setSelectorButtonAsPrefixIcon: false,
                showFlags: true,
              ),
          onInputValidated: widget.onInputValidated,
          onInputChanged: widget.onInputChanged,
          textFieldController: widget.controller,
          initialValue: widget.number,
          countries: const ['GH', 'TG'],
          autoValidateMode: AutovalidateMode.onUserInteraction,
          inputDecoration: InputDecoration(
            hintText: "244000000",
            hintStyle: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              fontStyle: FontStyle.italic,
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 16,
            ),
            filled: true,
            fillColor: theme.inputDecorationTheme.fillColor,
            border: theme.inputDecorationTheme.border,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: theme.colorScheme.primary,
                width: 2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: theme.colorScheme.primary,
                width: 1,
              ),
            ),
          ),
          spaceBetweenSelectorAndTextField: 8,
          selectorTextStyle: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface,
          ),
          searchBoxDecoration: InputDecoration(
            hintStyle: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: theme.colorScheme.primary,
                width: 2,
              ),
            ),
          ),
          ignoreBlank: false,
          selectorButtonOnErrorPadding: 0,
          formatInput: false,
          keyboardType: TextInputType.number,
          textStyle: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}

class FormFieldsLabel extends StatelessWidget {
  final String label;
  final bool isRequired;

  const FormFieldsLabel({
    super.key,
    required this.label,
    required this.isRequired,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RichText(
      text: TextSpan(
        text: label,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: theme.colorScheme.onSurface,
        ),
        children: isRequired
            ? [
                TextSpan(
                  text: '*',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.error,
                  ),
                ),
              ]
            : null,
      ),
    );
  }
}
