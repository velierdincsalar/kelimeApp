import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  Indicator({
    this.controller,
    this.itemCount: 0,
  }) : assert(controller != null);

  /// PageView Controller
  final PageController controller;

  /// Number of indicators
  final int itemCount;

 

  /// Size of points
  final double size = 28.0;

  /// Spacing of points
  final double spacing =7.0;

  /// Point Widget
  Widget _buildIndicator(
      int index, int pageCount, double dotSize, double spacing) {
    // Is the current page selected?
   
    return new Container(
      height: size,
      width: size + (2 * spacing),
      child: new Center(
        
        child: new Material(
        
         child:   FlatButton
          (
             padding: EdgeInsets.all(1.0),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            child: Text((index+1).toString(),style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 16.0,
                          color: Color(0xFF525252),
                          letterSpacing: 0.1)),
            onPressed: ()
            {
             
              controller.jumpToPage(index);
             
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount, (int index) {
        return _buildIndicator(index, itemCount, size, spacing);
      }),
    );
  }
}