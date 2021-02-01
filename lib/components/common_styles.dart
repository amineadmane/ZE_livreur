import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:ze_livreur/provider/navigation_provider.dart';
import 'package:provider/provider.dart';

class CommonStyles {
  Color background = Color(0xFFF2F2F2);
  Color green = Color(0xFF25E879);
  Color orange = Color(0xFFF28322);
  Color violet = Color(0xFF382B8C);

  static textFormFieldStyle(String label, String hint) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      alignLabelWithHint: true,
      contentPadding: EdgeInsets.symmetric(vertical: 5),
      labelStyle: TextStyle(color: Colors.black),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 2),
      ),
    );
  }

  static profileFormFieldStyle(
    context,
    String label,
    String hint,
    Icon icon,
  ) {
    Color violet = Color(0xFF382B8C);
    return InputDecoration(
      icon: icon,
      labelText: label,
      hintText: hint,
      focusColor: violet,
      fillColor: violet,
      hoverColor: violet,
      hintStyle: TextStyle(
        color: violet,
        fontSize: ResponsiveFlutter.of(context).fontSize(3),
        fontFamily: "Mom cake",
      ),
      alignLabelWithHint: true,
      contentPadding: EdgeInsets.symmetric(vertical: 5),
      labelStyle: TextStyle(color: violet),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: violet, width: 2),
      ),
    );
  }

  static profilecontrainerdeco() {
    Color violet = Color(0xFF382B8C);

    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: violet),
    );
  }

  static rows(String champ, IconData icon, BuildContext context) {
    Color violet = Color(0xFF382B8C);
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      SizedBox(
        width: ResponsiveFlutter.of(context).scale(35),
        child: Icon(
          icon,
          color: violet,
        ),
      ),
      Text(
        champ,
        style: TextStyle(
            color: violet,
            fontFamily: 'Mom cake',
            fontWeight: FontWeight.w500,
            fontSize: ResponsiveFlutter.of(context).fontSize(2.8)),
      ),
    ]);
  }

  passFormFieldStyle(
      context, String label, String hint, Icon icon, bool _isvisible) {
    Color violet = Color(0xFF382B8C);
    return InputDecoration(
      icon: icon,
      labelText: label,
      hintText: hint,
      focusColor: violet,
      fillColor: violet,
      hoverColor: violet,
      suffixIcon: IconButton(
        icon: Icon(
          _isvisible ? Icons.visibility_rounded : Icons.visibility_off_rounded,
          color: violet,
        ),
        onPressed: () {
          NavigationProvider().changepassstate();
        },
      ),
      hintStyle: TextStyle(
        color: violet,
        fontSize: ResponsiveFlutter.of(context).fontSize(3),
        fontFamily: "Mom cake",
      ),
      alignLabelWithHint: true,
      contentPadding: EdgeInsets.symmetric(vertical: 5),
      labelStyle: TextStyle(color: violet),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: violet, width: 2),
      ),
    );
  }
}
