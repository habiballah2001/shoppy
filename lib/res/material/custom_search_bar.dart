import 'package:flutter/material.dart';

import '../styles/colors.dart';

class CustomSearchBar extends StatefulWidget {
  final Function()? onTab;
  final Function(String?)? onChanged;
  final Function(String?)? onSubmit;
  final TextEditingController? controller;
  const CustomSearchBar(
      {super.key, this.onTab, this.onChanged, this.onSubmit, this.controller});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SearchBar(
        controller: widget.controller,
        padding:
            const MaterialStatePropertyAll(EdgeInsets.fromLTRB(30, 5, 30, 5)),
        backgroundColor: const MaterialStatePropertyAll(secColor),
        leading: const Icon(
          Icons.search,
          size: 30,
          color: Colors.white,
        ),
        hintText: 'Search products',
        hintStyle:
            const MaterialStatePropertyAll(TextStyle(color: Colors.white)),
        onTap: widget.onTab,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmit,
      ),
    );
  }
}
