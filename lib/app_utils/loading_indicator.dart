
import 'package:flutter/material.dart';
import 'package:texdoc/resources/app_assets.dart';
import 'package:texdoc/resources/app_theme.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingIndicator extends StatelessWidget {
  final double height;
  final double width;
  const LoadingIndicator({Key? key, this.height = 50, this.width = 50})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: height,
        width: width,
        child: const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
          strokeWidth: 1.0,
        ),
      ),
    );
  }
}

showLoadingIndicatorDialog(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          // insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          child: Container(
            height: 120,
            width: 100,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  backgroundColor: AppTheme.primaryColor,
                  radius: 30,
                  child: Image.asset(AppAssets.splashLogo,color: Colors.white,width: 28,height: 28,),
                ),
                Center(
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Loading"),
                    LoadingAnimationWidget.staggeredDotsWave(color: AppTheme.primaryColor, size: 20)
                  ],
                ))
                // const Center(
                //   child: CircularProgressIndicator(
                //     color: AppTheme.primaryColor,
                //   ),
                // )
              ],
            ),
          ),
        );
      });
}
