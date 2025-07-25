import 'package:flutter/material.dart';
import 'package:movies_application/cubit/cubit.dart';

Widget defaultButton({
  required VoidCallback function,
  bool isDisabled = false,
  double width = double.infinity,
  Color background = Colors.red,
  Color color = Colors.white,
  bool isUpperCase = true,
  double radius = 0.0,
  double fontSize = 14.0,
  FontWeight fontWeight = FontWeight.w500,
  required String text,
}) => Container(
  width: width,
  child: MaterialButton(
    onPressed: function,
    child: Text(
      isUpperCase ? text.toUpperCase() : text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    ),
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    color: background,
  ),
);

Widget defaultFormField({
  required BuildContext context,
  required TextEditingController controller,
  required TextInputType type,
  bool isPassword = false,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  required Function validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPrssed,
  bool isClickable = true,
}) => TextFormField(
  controller: controller,
  keyboardType: type,
  obscureText: isPassword,
  style: const TextStyle(color: Colors.white),
  onFieldSubmitted: (s) {
    onSubmit!(s);
  },
  onChanged: (s) {
    onChange!(s);
  },
  onTap: () {
    onTap!();
  },
  // validator: (s) {
  //   validate(s);
  //   return null;
  // },
  validator: (value) => validate(value),
  enabled: isClickable,
  decoration: InputDecoration(
    labelStyle: TextStyle(color: secondryColor),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: primaryColor),
    ),
    labelText: label,
    prefixIcon: Icon(prefix, color: Colors.white),
    suffix:
        suffix != null
            ? IconButton(
              onPressed: () {
                MoviesCubit.get(context).changePasswordVisibility();
                isPassword = !isPassword;
                suffixPrssed!();
              },
              icon: Icon(suffix, color: secondryColor),
            )
            : null,
    border: OutlineInputBorder(),
  ),
);

Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(start: 20.0),
  child: Container(
    width: double.infinity,
    height: 2.0,
    color: Colors.grey[300],
  ),
);

Future<dynamic> navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

int selectedMeal = 0;
List<String> selectedMealIds = [];

const Color primaryColor = Colors.red;

const Color secondryColor = Colors.white;
bool isFavorite = false;

Widget itemBuilder({
  required IconData icon,
  required String text,
  required String imageUrl,
  required int itemCount,
  Color? color,
  required IconData favorite,
  Function? favoritePrssed,
  Map<String, dynamic> Function(int)? customItemBuilder,
  required Function(int) onFavoriteTap,
  required Function(int) onTap,
}) => Column(
  children: [
    Row(
      children: [
        Icon(icon, color: secondryColor, size: 40.0),
        SizedBox(width: 5.0),
        Text(
          text,
          style: TextStyle(
            color: secondryColor,
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
    SizedBox(height: 10.0),
    SizedBox(
      height: 220.0,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final itemData =
              customItemBuilder != null ? customItemBuilder(index) : {};
          final img = itemData['imageUrl'] ?? imageUrl;
          final currentColor = itemData['color'] ?? Colors.white;
          return GestureDetector(
            onTap: () {
              onTap(index);
            },
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  width: 150.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: NetworkImage(img),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // IconButton(
                //   onPressed: () {
                //     MoviesCubit.get(context).changeFavorite();
                //     onTap(index);
                //   },
                //   icon: Icon(
                //     Icons.favorite,
                //     color: isFavorite ? primaryColor : secondryColor,
                //     size: 30,
                //   ),
                // ),
                IconButton(
                  onPressed: () {
                    MoviesCubit.get(context).changeFavorite();
                    // onTap(index);
                    onFavoriteTap.call(index);
                  },
                  icon:
                      isFavorite
                          ? Icon(favorite, color: currentColor, size: 40.0)
                          : Icon(favorite, color: currentColor, size: 40.0),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(width: 20.0),
        itemCount: itemCount,
      ),
    ),
  ],
);
