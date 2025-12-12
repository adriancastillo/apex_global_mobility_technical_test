part of '../ui.dart';

class UISpacing {
  const UISpacing._(this.context);

  final BuildContext context;

  static UISpacing of(BuildContext context) => UISpacing._(context);

  static Widget get horizontal_2 => const SizedBox(width: UISizing.value_2);

  static Widget get vertical_2 => const SizedBox(height: UISizing.value_2);

  static Widget get horizontal_4 => const SizedBox(width: UISizing.value_4);

  static Widget get vertical_4 => const SizedBox(height: UISizing.value_4);

  static Widget get horizontal_5 => const SizedBox(width: UISizing.value_5);

  static Widget get vertical_5 => const SizedBox(height: UISizing.value_5);

  static Widget get horizontal_6 => const SizedBox(width: UISizing.value_6);
  static Widget get vertical_6 => const SizedBox(height: UISizing.value_6);

  static Widget get horizontal_8 => const SizedBox(width: UISizing.value_8);

  static Widget get vertical_8 => const SizedBox(height: UISizing.value_8);

  static Widget get horizontal_10 => const SizedBox(width: UISizing.value_10);
  static Widget get vertical_10 => const SizedBox(height: UISizing.value_10);

  static Widget get horizontal_12 => const SizedBox(width: UISizing.value_12);

  static Widget get vertical_12 => const SizedBox(height: UISizing.value_12);

  static Widget get horizontal_16 => const SizedBox(width: UISizing.value_16);

  static Widget get vertical_16 => const SizedBox(height: UISizing.value_16);

  static Widget get horizontal_20 => const SizedBox(width: UISizing.value_20);

  static Widget get vertical_20 => const SizedBox(height: UISizing.value_20);

  static Widget get horizontal_22 => const SizedBox(width: UISizing.value_22);

  static Widget get vertical_22 => const SizedBox(height: UISizing.value_22);

  static Widget get horizontal_24 => const SizedBox(width: UISizing.value_24);

  static Widget get vertical_24 => const SizedBox(height: UISizing.value_24);

  static Widget get horizontal_26 => const SizedBox(width: UISizing.value_26);
  static Widget get vertical_26 => const SizedBox(height: UISizing.value_26);

  static Widget get horizontal_28 => const SizedBox(width: UISizing.value_28);

  static Widget get vertical_28 => const SizedBox(height: UISizing.value_28);

  static Widget get horizontal_32 => const SizedBox(width: UISizing.value_32);

  static Widget get vertical_32 => const SizedBox(height: UISizing.value_32);

  static Widget get horizontal_34 => const SizedBox(width: UISizing.value_34);

  static Widget get vertical_34 => const SizedBox(height: UISizing.value_34);

  static Widget get horizontal_36 => const SizedBox(width: UISizing.value_36);

  static Widget get vertical_36 => const SizedBox(height: UISizing.value_36);

  static Widget get horizontal_40 => const SizedBox(width: UISizing.value_40);

  static Widget get vertical_40 => const SizedBox(height: UISizing.value_40);

  static Widget get horizontal_48 => const SizedBox(width: UISizing.value_48);

  static Widget get vertical_48 => const SizedBox(height: UISizing.value_48);

  static Widget get horizontal_64 => const SizedBox(width: UISizing.value_64);

  static Widget get vertical_64 => const SizedBox(height: UISizing.value_64);

  static Widget get horizontal_70 => const SizedBox(width: UISizing.value_70);

  static Widget get vertical_70 => const SizedBox(height: UISizing.value_70);

  static Widget get horizontal_75 => const SizedBox(width: UISizing.value_75);
  static Widget get vertical_75 => const SizedBox(height: UISizing.value_75);

  static Widget get horizontal_85 => const SizedBox(width: UISizing.value_85);
  static Widget get vertical_85 => const SizedBox(height: UISizing.value_85);

  static Widget get horizontal_96 => const SizedBox(width: UISizing.value_96);

  static Widget get vertical_96 => const SizedBox(height: UISizing.value_96);

  static Widget get horizontal_124 => const SizedBox(width: UISizing.value_124);

  static Widget get vertical_124 => const SizedBox(height: UISizing.value_124);

  Widget get paddingTop => SizedBox(height: MediaQuery.of(context).padding.top);

  Widget get paddingBottom =>
      SizedBox(height: MediaQuery.of(context).padding.bottom);

  Widget get vertical16Rp {
    final height = MediaQuery.sizeOf(context).height * 0.02;
    return height < UISizing.value_16
        ? SizedBox(height: height)
        : const SizedBox(height: UISizing.value_16);
  }

  Widget get vertical24Rp {
    final height = MediaQuery.sizeOf(context).height * 0.025;
    return height < UISizing.value_24
        ? SizedBox(height: height)
        : const SizedBox(height: UISizing.value_24);
  }

  Widget get vertical32Rp {
    final height = MediaQuery.sizeOf(context).height * 0.035;
    return height < UISizing.value_32
        ? SizedBox(height: height)
        : const SizedBox(height: UISizing.value_32);
  }

  Widget get vertical36Rp {
    final height = MediaQuery.sizeOf(context).height * 0.04;
    return height < UISizing.value_36
        ? SizedBox(height: height)
        : const SizedBox(height: UISizing.value_36);
  }

  static Widget horizontalResponsive(BuildContext context, double percent) =>
      SizedBox(width: MediaQuery.sizeOf(context).width * percent);

  static Widget verticalResponsive(BuildContext context, double percent) =>
      SizedBox(height: MediaQuery.sizeOf(context).height * percent);
}
