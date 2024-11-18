import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../app_styles.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    Key? key,
    required this.buttonText,
    this.width = 400.0,
    this.height = 50.0,
    this.borderColor = Colors.transparent,
    this.fillColor = AppStyles.themeColor,
    this.fontColor = Colors.black,
    this.fontWeight = FontWeight.w500,
    this.fontSize = 16,
    this.borderWidth = 1.5,
    this.borderRadius = 5,
    this.onTap,
    this.isIconOnly = false,
    this.iconData,
    this.imageAsIcon,
    this.isClickable = true,
    this.isOutlined = false,
    this.isGradient = false,
    this.colorGrade1 = Colors.transparent,
    this.colorGrade2 = Colors.transparent,
    this.elevation = 6.0,
    this.hasButtonImage = false,
    this.isAssetSvg = false,
    this.svgGradient = const [Colors.grey, Colors.grey],
    this.imageAsset = '',
    this.imageHeight = 1.2,
    this.imageWidth = 1.2,
    this.hasSuffixIcon = false,
    this.isSuffixIconAlignedToEnd = false,
    this.suffixIconColor = Colors.white,
    this.alignment = MainAxisAlignment.center, // Add alignment parameter
  }) : super(key: key);

  final bool isIconOnly;
  final IconData? iconData;
  final String? imageAsIcon;
  final String buttonText;
  final double width;
  final double height;
  final Color borderColor;
  final double borderRadius;
  final Color fillColor;
  final Color fontColor;
  final FontWeight fontWeight;
  final double fontSize;
  final double borderWidth;
  final Function()? onTap;
  final bool isClickable;
  final bool isOutlined;
  final bool isGradient;
  final Color colorGrade1;
  final Color colorGrade2;
  final double elevation;
  final bool hasButtonImage;
  final String imageAsset;
  final bool isAssetSvg;
  final List<Color> svgGradient;
  final double imageHeight;
  final double imageWidth;
  final bool hasSuffixIcon;
  final bool isSuffixIconAlignedToEnd;
  final Color suffixIconColor;
  final MainAxisAlignment alignment; // New alignment parameter

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        elevation: elevation,
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius),
        borderOnForeground: true,
        child: InkWell(
          onTap: isClickable ? onTap : null,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isGradient ? [colorGrade1, colorGrade2] : [fillColor, fillColor], // Define the colors
                begin: Alignment.topLeft, // Start of the gradient
                end: Alignment.bottomRight, // End of the gradient
              ),
              border: Border.all(
                color: isClickable ? borderColor : AppStyles.defaultButtonColorWithOpacity,
                width: borderWidth,
              ),
              borderRadius: BorderRadius.circular(borderRadius),
              color: isClickable ? fillColor : AppStyles.defaultButtonColorWithOpacity,
            ),
            child:
            isIconOnly && iconData != null
                ? Center(
              child: Icon(
                iconData,
                size: width * 0.6,
                color: Colors.white,
              ),
            )
                : isIconOnly && imageAsIcon != null
                ? Center(
              child:
              Image(
                width: width * 0.6,
                height: height * 0.6,
                fit: BoxFit.fitWidth,
                image: AssetImage(imageAsIcon.toString()),
                color: Colors.white,
              ),
            )
                : Row(
              mainAxisAlignment: alignment, // Use alignment parameter
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // if(hasButtonImage && isAssetSvg)
                //   Spacer(),
                if (hasButtonImage)
                  if(isAssetSvg)
                    Padding(
                        padding: EdgeInsets.only(left: 10),
                        child:
                        imageAsset.contains("https") ?
                        SvgPicture.network(
                          width: imageWidth,
                          height: imageHeight,
                          fit: BoxFit.cover,
                          imageAsset,
                          placeholderBuilder: (BuildContext context) => CircularProgressIndicator(),
                        )
                            :
                        Image(
                          width: width * 0.6,
                          height: height * 0.6,
                          fit: BoxFit.fitWidth,
                          image: AssetImage(imageAsIcon.toString()),
                          color: Colors.white,
                        ),
                    )
                  else
                    Image(
                      width: fontSize * imageWidth,
                      height: fontSize * imageHeight,
                      fit: BoxFit.fitHeight,
                      image: AssetImage(imageAsset),
                    ),
                if (hasButtonImage) SizedBox(width: 10,),
                if (hasSuffixIcon) Spacer(),
                Padding(
                  padding: isSuffixIconAlignedToEnd ? EdgeInsets.only(left: 10): EdgeInsets.zero,
                  child: Text(
                    buttonText,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                        color: isClickable ? fontColor : Colors.white.withOpacity(0.7),
                        fontWeight: fontWeight,
                        fontSize: fontSize
                    ),
                  ),
                ),
                if (hasSuffixIcon) Spacer(), // Optional spacing
                if (hasSuffixIcon && isSuffixIconAlignedToEnd) Spacer(),
                if (hasSuffixIcon)
                  Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(
                      size: 20,
                      iconData,
                      color: suffixIconColor,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
