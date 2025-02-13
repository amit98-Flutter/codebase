import 'package:codebase/core/theme/app_color.dart';
import 'package:codebase/core/theme/app_size.dart';
import 'package:codebase/core/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String screenName;
  final bool isShowBackBtn;
  final bool centerTitle;
  final double elevation;
  final VoidCallback? onBackClick;
  final TextStyle? titleStyle;
  final Color? statusBarColor;
  final ValueChanged<String>? onSearchChanged;
  final ValueChanged<bool>? onSearchVisibilityChanged;

  const CustomAppBar({
    super.key,
    required this.screenName,
    this.isShowBackBtn = true,
    this.titleStyle,
    this.onBackClick,
    this.centerTitle = true,
    this.elevation = 1.5,
    this.statusBarColor,
    this.onSearchChanged,
    this.onSearchVisibilityChanged,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(54.h);
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: widget.statusBarColor ?? AppColors.whiteColor,
        statusBarIconBrightness: Brightness.dark, // Android (dark icons)
        statusBarBrightness: Brightness.light, // iOS (dark icons)
      ),
      elevation: widget.elevation,
      backgroundColor: AppColors.whiteColor,
      leading: widget.isShowBackBtn
          ? GestureDetector(
        onTap: widget.onBackClick,
        child: Padding(
          padding: REdgeInsets.only(left: 14.w),
          child: Container(
            decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.backBgColor),
            child: Image.asset("assets/icons/back_icon.png", height: 20.r, width: 20.r, scale: 2.5),
          ),
        ),
      )
          : null,
      titleSpacing: 0,
      centerTitle: widget.centerTitle,
      title: _isSearching ? _buildSearchField() : _buildTitle(),
      actions: widget.onSearchChanged != null ? _buildActions() : null,
    );
  }

  /// **Default App Bar Title**
  Widget _buildTitle() {
    return Padding(
      padding: EdgeInsets.only(left: widget.isShowBackBtn ? 0 : 25.w),
      child: Text(
        widget.screenName,
        style: widget.titleStyle ??
            AppTextStyle.medium500(
              fontSize: AppSize.fontSize18,
              color: AppColors.headlineTextColor,
            ).copyWith(height: 1.35),
      ),
    );
  }

  /// **Search Field**
  Widget _buildSearchField() {
    return Padding(
      padding: EdgeInsets.only(left: 25.w),
      child: TextField(
        controller: _searchController,
        autofocus: true,
        style: AppTextStyle.medium500(fontSize: AppSize.fontSize16, color: AppColors.blackColor),
        cursorColor: AppColors.blackColor,
        onChanged: widget.onSearchChanged,
        decoration: InputDecoration(
          hintText: "Search...",
          hintStyle: AppTextStyle.regular400(fontSize: AppSize.fontSize16, color: AppColors.hintTextColor),
          border: InputBorder.none,
        ),
      ),
    );
  }

  /// **App Bar Actions**
  List<Widget> _buildActions() {
    return [
      Padding(
        padding: EdgeInsets.only(right: 8.w),
        child: IconButton(
          icon: Icon(_isSearching ? Icons.close : Icons.search, color: AppColors.blackColor),
          onPressed: _isSearching ? _stopSearching : _startSearching,
        ),
      ),
    ];
  }

  /// **Start Searching**
  void _startSearching() {
    setState(() {
      _isSearching = true;
    });
    widget.onSearchVisibilityChanged?.call(true); // Notify parent that search is visible
  }

  /// **Stop Searching**
  void _stopSearching() {
    setState(() {
      _isSearching = false;
      _searchController.clear();
    });
    widget.onSearchVisibilityChanged?.call(false); // Notify parent that search is hidden
    widget.onSearchChanged?.call(""); // Clear search results
  }
}
