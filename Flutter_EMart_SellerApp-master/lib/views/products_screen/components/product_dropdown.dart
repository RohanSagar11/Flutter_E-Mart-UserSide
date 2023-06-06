import 'package:emart_seller/const/const.dart';

import '../../auth_screen/widgets/text_style.dart';

Widget productDropDown() {
  return DropdownButtonHideUnderline(
    child: DropdownButton<String>(
      hint: normalText(text: " Choose Category", color: fontGrey),
      items: [],
      onChanged: (value) {},
      value: null,
      isExpanded: true,
    ),
  )
      .box
      .white
      .border(color: Colors.black, width: 2.0)
      .padding(const EdgeInsets.symmetric(horizontal: 4))
      .rounded
      .make();
}
